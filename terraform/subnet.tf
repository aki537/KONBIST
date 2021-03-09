resource "aws_subnet" "kb-front-1a" {
  vpc_id                  = aws_vpc.kb-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "kb-front-1a"
  }
}
resource "aws_subnet" "kb-front-1c" {
  vpc_id                  = aws_vpc.kb-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "kb-front-1c"
  }
}
resource "aws_subnet" "kb-back-1a" {
  vpc_id                  = aws_vpc.kb-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "kb-back-1a"
  }
}
resource "aws_subnet" "kb-back-1c" {
  vpc_id                  = aws_vpc.kb-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "kb-back-1c"
  }
}

resource "aws_db_subnet_group" "kb-rds-subnet-group" {
  name        = "kb-rds-subnet-group"
  description = "rds subnet for kb"
  subnet_ids  = [aws_subnet.kb-back-1a.id, aws_subnet.kb-back-1c.id]
}