resource "aws_route_table" "kb-front-rtb" {
  vpc_id = aws_vpc.kb-vpc.id

  route {
    gateway_id = aws_internet_gateway.kb-igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "kb-front-rtb"
  }
}
resource "aws_route_table" "kb-back-rtb" {
  vpc_id = aws_vpc.kb-vpc.id

  route {
    gateway_id = aws_internet_gateway.kb-igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "kb-back-rtb"
  }
}


resource "aws_route_table_association" "kb-front-rtb-1a" {
  subnet_id      = aws_subnet.kb-front-1a.id
  route_table_id = aws_route_table.kb-front-rtb.id
}
resource "aws_route_table_association" "kb-front-rtb-1c" {
  subnet_id      = aws_subnet.kb-front-1c.id
  route_table_id = aws_route_table.kb-front-rtb.id
}
resource "aws_route_table_association" "kb-back-rtb-1a" {
  subnet_id      = aws_subnet.kb-back-1a.id
  route_table_id = aws_route_table.kb-back-rtb.id
}
resource "aws_route_table_association" "kb-back-rtb-1c" {
  subnet_id      = aws_subnet.kb-back-1c.id
  route_table_id = aws_route_table.kb-back-rtb.id
}