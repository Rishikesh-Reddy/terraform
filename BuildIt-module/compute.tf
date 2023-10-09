resource "aws_instance" "frontend_instance" {



  ami = var.ami
  instance_type = var.instance_type
  key_name = var.keyname
  subnet_id = resource.aws_subnet.BuildIt_PublicSubnet.id
  associate_public_ip_address = true
  security_groups = [resource.aws_security_group.frontend_SG.id]


  tags = merge(
    local.tags,
    {
      name = "frontend_instance"
    }
  )
}

resource "aws_eip" "frontend_instance_EIP" {
  instance = resource.aws_instance.frontend_instance.id
  domain = "vpc"

  tags = local.tags
}

resource "aws_instance" "server_instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.keyname
  subnet_id = resource.aws_subnet.BuildIt_PrivateSubnet.id
  security_groups = [ resource.aws_security_group.server_SG.id ]

  tags = merge(
    local.tags,
    {
      name = "server_instance"
    }
  )
}

resource "aws_instance" "api_instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.keyname
  subnet_id = resource.aws_subnet.BuildIt_PrivateSubnet.id
  security_groups = [ resource.aws_security_group.server_SG.id ]

  tags = merge(
    local.tags,
    {
      name = "api_instance"
    }
  )
}