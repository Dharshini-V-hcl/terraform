provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"  # Specify your desired AZ
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_s3_bucket" "example" {
  bucket = "december17thtesting"
  acl    = "private"
}
# EC2 Instance Resource
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with your preferred AMI ID
  instance_type = "t2.micro"  # Specify your desired instance type

  tags = {
    Name = "Example EC2"
  }
}
