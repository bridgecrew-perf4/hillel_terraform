resource "aws_subnet" "private" {
  count                   = local.az_num

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + local.az_num)
  tags                    = merge(var.tags, { "Name" = "Private-${cidrsubnet(var.vpc_cidr, 8, count.index+local.az_num)}" })
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = false
}