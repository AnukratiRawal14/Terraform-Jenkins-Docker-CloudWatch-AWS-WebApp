| Resource         | Status           |
| ---------------- |------------------|
| VPC              | Created          |
| Public Subnets   | Craeted          |
| Private Subnets  | Created          |
| Route Tables     | Created          |
| Internet Gateway | Created          |
| NAT Gateway      | Created          |
| AZ spread        | Craeted multi-az |

When NAT Gateway uses public connectivity, it requires a public IP address (Elastic IP).
Elastic IP provides NAT Gateway the ability to send/receive traffic to the internet.
NAT Gateway cannot work without public IP if it's public connectivity type.
The public Elastic IP becomes the external IP for instances behind the NAT.