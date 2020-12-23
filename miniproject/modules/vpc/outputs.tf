output "public_networks" {
  value = aws_subnet.public[*]
}

output "private_networks" {
  value = aws_subnet.private[*]
}

output "vpc_id" {
  value = aws_vpc.this.id
}