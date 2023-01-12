#create vpc
resource "aws_vpc" "project-1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = " project-1"
  }
}

#Create a public subnet
resource "aws_subnet" "project-1-public" {
  vpc_id     = aws_vpc.project-1.id
  cidr_block = "10.0.1.0/24"
   map_public_ip_on_launch = true

  tags = {
    Name = "project-1-public"
  }
}

#create a private subnet
resource "aws_subnet" "project-1-private" {
  vpc_id     = aws_vpc.project-1.id
  cidr_block = "10.0.2.0/24"
   map_public_ip_on_launch = false

  tags = {
    Name = "project-1-private"
  }
}
# create route table for public subnet
resource "aws_route_table" "route-table-public" {
  vpc_id = aws_vpc.project-1.id

  
  tags = {
    Name = "route-table.public"
  }
}

#create route table for private
resource "aws_route_table" "route-table-private" {
  vpc_id = aws_vpc.project-1.id  

  tags = {
    Name = "route-table-private"
  }
}

# create internet gateway
resource "aws_internet_gateway" "project-1-gw" {
  vpc_id = aws_vpc.project-1.id

  tags = {
    Name = "project-1-gw"
  }
}

# associate Public Subnet to "Public Route Table"
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.project-1-public.id
  route_table_id = aws_route_table.route-table-public.id
}

# associate Private Subnet to "Private Route Table"
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.project-1-private.id
  route_table_id = aws_route_table.route-table-private.id
}

