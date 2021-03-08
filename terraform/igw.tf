resource "aws_internet_gateway" "kb-igw" {
  vpc_id = aws_vpc.kb-vpc.id

  tags = {
    Name = "kb-igw"
  }
}