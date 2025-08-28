resource "aws_instance" "vini-server" {
  ami           = data.aws_ami.selected.id # Substitua pela AMI em owners e ami_name_pattern via variavel
  instance_type = var.instance_type
  security_groups = [aws_security_group.allow_ssh_http.name]

  key_name = aws_key_pair.vini-key.key_name

  #user_data = var.user_data
  depends_on = [ data.template_file.userdata ]

  tags = {
    Name = var.instance_name
  }
}