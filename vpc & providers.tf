# For Provider
provider "aws" {
  region     = "eu-west-1"
  access_key = "ASIARM4RAQE4J3IDEDPS"
  secret_key = "UTpVcVaiEQx1qNi2KWP4fWV3xeApNUIiHdCXYg8L"
  token      = "IQoJb3JpZ2luX2VjEL3//////////wEaCXVzLWVhc3QtMSJHMEUCIQDSxEuMKwT0Ze+hAU970Phk1tFaCnSvgnNuJx/3RcAK1gIgW8I2GoDdne5s8cPLMql9lylfENaCYO8NQO1dk5TbM2kqnQMIhv//////////ARACGgwwOTY0MDQwMTMzNjgiDH+WpdE+glSLENiiqyrxAiZH1NdauiOSSBf41Xuzqoma+JYCcrNNo2NBHRzbfiVMMHx1Tz6XhO8vPV1nWyMJERbtrQ/4gLXWEX2i4JA/ed1A0toJzZA00+ROl1TjwI2RmgotPJ4SX5sBI/8+CI0psCZBo3Sk8HM49WDWO6VKJ+h/Skcb4KxmXMNyw5szvoQwmIRzGJNELwKvPVxtRswi2zpTKPLjOF/2UvUC68sXDLG/BTq4m0MEQ3A3AE/8UbWM+jaWsK6KXUUOSidG5bZR7CokJrs3iA7vNRfX2MqOQiUPJuv0x3tKWIDqMQc9Jy8DkAagdeMa9RtG5eZBBibpMmZNpx4Iqc+Ptwjk2lD2+7eJI7fuvfzudOJwC9aWOCz38456ApIua6fssk2MYtqAw0hL8DeaJRXEVUL9oF2gc3ZS/7Jqu+Xp5FtpEl3zZSLybDFCLVvGWqLsrVSwEtCbj5gID4mwjxw7oDlU5wEmGXno9Gq7E2Osh0vKn0g5UI5dZzC9tM2TBjqmAdsgMLuWa7MW9B/69GTZfM2n93sGbm8VrVZfAsJAK8rYP88BIX77CyJ1glP17BNS0kZbIqinCLnb8ZfQ+n7qfFU74gFBKYaaA2wlHlCnyHWXUkT6b9oOVy8WGadCmXbvNOh4rsqzA4/nDAHcvsi7FXnnyyiFYmqbSNBvO6HVcaRvMEwwgTgJ+C/2IZUVE5dK4WwQZ0KXX+syxkEf0L7NNUz5yP+v3pQ="
}

# For VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "main"
  }
}

# For Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1a"
  tags = {
    Name = "main-public-1"
  }
}

resource "aws_subnet" "main-private-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1b"
  tags = {
    Name = "main-private-1"
  }
}

# For Internet Gateway
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main_igw"
  }
}

# For Route Tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
  tags = {
    Name = "main-public-1_RT"
  }
}

# For Route associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}
