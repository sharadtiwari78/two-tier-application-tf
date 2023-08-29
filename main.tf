module "vpc" {
  source          = "./modules/vpc"
  project_name    = var.project_name
  vpc_name        = "${var.project_name}-vpc"
  vpc_cidr        = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.51.0/24", "10.0.52.0/24"]
  db_subnets      = ["10.0.100.0/24", "10.0.101.0/24"]
}

module "key" {
  source = "./modules/key"
}

module "securitygroup" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "database" {
  source               = "./modules/rds"
  project_name         = var.project_name
  subnet_ids           = module.vpc.db_subnet_ids
  subnet_group_name    = "database-subnet-group"
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "MyUsername"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

module "alb" {
  source                     = "./modules/alb"
  security_group_ids         = module.securitygroup.alb_sg_id
  subnet_ids                 = module.vpc.public_subnet_ids
  vpc_id                     = module.vpc.vpc_id
  project_name               = var.project_name
  alb_name                   = "my-frontend-alb"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = false
  tg_name                    = "alb-tg"
  tg_type                    = "instance"
}

module "cloudfront" {
  source                         = "./modules/cloudfront"
  alb_domain_name                = module.alb.alb_dns_name
  project_name                   = var.project_name
  allowed_methods                = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  cached_methods                 = ["GET", "HEAD"]
  cookies_forward                = "all"
  locations                      = ["US", "IN"]
  cloudfront_default_certificate = true
}

module "server" {
  source             = "./modules/ec2"
  project_name       = var.project_name
  key_name           = module.key.key_name
  security_group_ids = module.securitygroup.client_sg_id
  instance_type      = "t2.micro"

}

module "asg" {
  source                    = "./modules/asg"
  project_name              = var.project_name
  vpc_zone_identifier       = module.vpc.private_subnet_ids
  target_group_arns         = module.alb.target_group_arn
  launch_template_id        = module.server.launch_template_id
  launch_template_version   = module.server.launch_template_version
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  metrics_granularity       = "1Minute"
  scaling_adjustment_up     = 1  #increasing instance by 1
  scaling_adjustment_down   = -1 #decreasing instance by 1 
  adjustment_type           = "ChangeInCapacity"
  cooldown                  = 300
}

module "cloudwatch" {
  source                    = "./modules/cloudwatch"
  project_name              = var.project_name
  asg_name                  = module.asg.asg_name
  asg_scale_up_policy_arn   = module.asg.scale_up_policy_arn
  asg_scale_down_policy_arn = module.asg.scale_down_policy_arn
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold_up              = "70" # New instance will be created once CPU utilization is higher than 30 %
  threshold_down            = "5"  # Instance will scale down when CPU utilization is lower than 5 %
}

module "route53" {
  source                    = "./modules/route53"
  cloudfront_domain_name    = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
  domain                    = "awscloudlab.co"
}
