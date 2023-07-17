provider "aws" {
  region = var.region # Update with your desired region
}

# Retrieve the root volume ID of the existing instance
data "aws_instance" "source_instance" {
  instance_id = var.instance_id # Update with the ID of your existing instance
}
#retrive the source VPC details
data "aws_vpc" "source_vpc" {
  id = var.vpc_id
}

# Retrieve the root volume details
data "aws_ebs_volume" "source_volume" {
  most_recent = true
  filter {
    name   = "attachment.instance-id"
    values = [data.aws_instance.source_instance.id]
  }
}
resource "aws_security_group" "dev-connector-box-sg" {
  name        = "dev-connector-box-sg"
  description = "Security group for mongo connector box in dev"
  vpc_id      = data.aws_vpc.source_vpc.id
  
    

  dynamic "ingress" {  ##for any traffic coming to this connector box using 27017 port with following existing sg groups
    for_each        = var.security_groups_mongo
    content{
    description     = "Mongo tcp port to ${ingress.value}"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [ingress.value]
  }
}
  ingress {
    description     = "self service"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["XXXX"]
  }

  egress {   ##connector box to send traffic to any https page
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {   ##connector box to send traffic to any https page
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {   ##connector box to send traffic to any mongo RDS  using 27017
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {   ##connector box to send traffic to any mysql  RDS using 3306
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {    ##connector box to send traffic to any PostgressSql RDS using port 5432
    description = "PostgreSQL tcp port to XXXXX "
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["XXXXXXXX"]
  }
  egress {    
    description = "Redis tcp port to XXXXX"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = ["XXXXXX"]
  }
tags = {
    Name = "connector-box-dev-sg"
  }
}


# Create a new ARM-based instance
resource "aws_instance" "dev_mongo_connector_arm" {
  ami                    = var.ami
  instance_type          = var.instance_type # Update with the desired ARM instance type
  subnet_id              = data.aws_instance.source_instance.subnet_id
  vpc_security_group_ids = [aws_security_group.dev-connector-box-sg.id]
  key_name               = data.aws_instance.source_instance.key_name
  iam_instance_profile   = data.aws_instance.source_instance.iam_instance_profile
  ebs_block_device {
    device_name           = var.device_name
    volume_size           = data.aws_ebs_volume.source_volume.size
    volume_type           = data.aws_ebs_volume.source_volume.volume_type
    delete_on_termination = true # Assuming the root volume should be deleted on instance termination
  }
  user_data = file("user-data.sh")


tags = {
  Name = "dev-mongo-connector-arm"
  ssm_connector = "yes"
}

}
