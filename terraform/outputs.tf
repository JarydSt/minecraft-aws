output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.minecraft.id
}

output "public_ip" {
  description = "Public IPv4 address for Minecraft and nmap testing."
  value       = aws_instance.minecraft.public_ip
}

output "minecraft_address" {
  description = "Minecraft server address."
  value       = "${aws_instance.minecraft.public_ip}:25565"
}

output "nmap_command" {
  description = "Command to verify the Minecraft port from your local machine."
  value       = "nmap -sV -Pn -p T:25565 ${aws_instance.minecraft.public_ip}"
}
