resource "aws_nat_gateway" "kb-ngw" {
  allocation_id = aws_eip.kb-ngw-eip.id
  subnet_id     = aws_subnet.kb-front-1a.id
  depends_on    = [aws_internet_gateway.kb-igw]

  tags = {
    Name = "kb-ngw"
  }
}