resource "aws_subnet" "main" {
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 3, 1)
  vpc_id            = aws_vpc.main.id
  availability_zone = "us-east-1a"
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "GitLab Route Table"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}