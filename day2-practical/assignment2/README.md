## create a project directory
in the project directory create a module directory and ec2 instance
## create a module/main.tf
in the main.tf create aws_instance 
## variable.tf
in the variable.tf file 
define instance type , ami_id , subnet_id , security_group_id , tags
## output.tf
Create outputs for the instance's id and public_ip
## CREATE A  main.tf(root)
in the main.tf define aws_vpc, aws_subnet, aws_internet_gateway, route tables, and the aws_security_group.
## variable
aws_region, instance_type, and web_server_ami
## output.tf
output "web_server_public_ip" {
  description = "Public IP of the EC2 instance created by the module."
  value       = module.my_web_server.public_ip
}
## terraform commands
1) terraform init
2) terraform validate
3) terraform plan
4) terraform apply
5) terraform destroy # to clean up
   ![Screenshot 2025-06-14 182406](https://github.com/user-attachments/assets/311d485b-7268-4303-a3dc-6bb9192c9175)

   ![Screenshot 2025-06-14 182345](https://github.com/user-attachments/assets/3ad18701-d34f-454a-8ac3-5b1be32ddcfa)

