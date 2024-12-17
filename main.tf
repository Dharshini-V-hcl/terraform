provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create Subnet
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  # Specify a valid AZ, such as 'us-east-1a'
  map_public_ip_on_launch = true
}

# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Create Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
}

# Create Route to Internet Gateway
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Create S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = "december17thtesting-unique"  # Make the name unique
  acl    = "private"
}

# Create EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-01816d07b1128cd2d"  # Replace with valid AMI ID for your region
  instance_type = "t2.micro"  

  tags = {
    Name = "Example EC2"
  }
}

