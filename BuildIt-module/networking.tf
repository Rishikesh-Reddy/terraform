resource "aws_vpc" "BuildIt_VPC" {
  cidr_block = "10.0.0.0/24"

  tags = local.tags
}

resource "aws_subnet" "BuildIt_PublicSubnet" {
  vpc_id = resource.aws_vpc.BuildIt_VPC.id
  availability_zone = var.availability_zone
  cidr_block = "10.0.0.0/28"

  tags = local.tags
}

resource "aws_subnet" "BuildIt_PrivateSubnet" {
  vpc_id = resource.aws_vpc.BuildIt_VPC.id
  availability_zone = var.availability_zone
  cidr_block = "10.0.0.96/28"

  tags = local.tags
}

resource "aws_internet_gateway" "BuildIt_IGW" {
  vpc_id = resource.aws_vpc.BuildIt_VPC.id

  tags = local.tags
}

resource "aws_eip" "NGW_eip" {
    domain = "vpc"
    tags = local.tags
}

resource "aws_nat_gateway" "BuildIt_NGW" {
  allocation_id = resource.aws_eip.NGW_eip.id
  subnet_id = resource.aws_subnet.BuildIt_PublicSubnet.id

  depends_on = [ aws_internet_gateway.BuildIt_IGW ]

  tags = local.tags
}

resource "aws_route_table" "Public_RT" {
  vpc_id = resource.aws_vpc.BuildIt_VPC.id

  tags = local.tags
}

resource "aws_route_table_association" "public_RT_subnet_association" {
  subnet_id = resource.aws_subnet.BuildIt_PublicSubnet.id
  route_table_id = resource.aws_route_table.Public_RT.id
}

resource "aws_route" "public_igw" {
  route_table_id = resource.aws_route_table.Public_RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = resource.aws_internet_gateway.BuildIt_IGW.id
}

resource "aws_route_table" "Private_RT" {
  vpc_id = resource.aws_vpc.BuildIt_VPC.id

  tags = local.tags
}

resource "aws_route_table_association" "private_RT_subnet_association" {
  subnet_id = resource.aws_subnet.BuildIt_PrivateSubnet.id
  route_table_id = resource.aws_route_table.Private_RT.id
}

resource "aws_route" "private_ngw" {
  route_table_id = resource.aws_route_table.Private_RT.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = resource.aws_nat_gateway.BuildIt_NGW.id
}