resource "aws_lb_target_group" "target_group" {
  name     = "my-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_principal.id
  health_check {
    healthy_threshold   = 2
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "test1" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.instancia1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "test2" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.instancia2.id
  port             = 80
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb" "load_balancer" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.instance_security_group.id]
  subnets            = [aws_subnet.subred_publica1.id, aws_subnet.subred_publica2.id]
  tags = {
    Name = "my-load-balancer"
  }
  
}
