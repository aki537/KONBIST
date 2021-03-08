resource "aws_eip" "kb-ngw-eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.kb-igw]

  tags = {
    Name = "kb-ngw-eip"
  }
}