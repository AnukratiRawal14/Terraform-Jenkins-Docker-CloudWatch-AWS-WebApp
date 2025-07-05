# ALB Target Group
resource "aws_lb_target_group" "app_alb_jenkins_tg" {
  name     = "app-alb-jenkins-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/login"
    protocol            = "HTTP"
    port                = "8080"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name = "app-alb-jenkins-target-group"
  }
}

# Target Group Attachment
resource "aws_lb_target_group_attachment" "app_alb_jenkins_attachment" {
  target_group_arn = aws_lb_target_group.app_alb_jenkins_tg.arn
  target_id        = var.instance_id
  port             = 8080
}

# Internal ALB
resource "aws_lb" "app_alb_jenkins" {
  name               = "app-jenkins-internal-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_id # adjust to your setup
  security_groups    = [var.alb_sg_id]

  tags = {
    Name = "app-jenkins-alb"
  }
}

# ALB Listener
resource "aws_lb_listener" "jenkins_listener" {
  load_balancer_arn = aws_lb.app_alb_jenkins.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_alb_jenkins_tg.arn
  }
}

# Allow ALB SG to access Jenkins SG
resource "aws_security_group_rule" "allow_alb_to_jenkins" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = var.alb_sg_id
  source_security_group_id = var.alb_sg_id
}
