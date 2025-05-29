# Terraform-Jenkins-Docker-CloudWatch-AWS-WebApp
 🚀 A fully automated, scalable web application infrastructure on AWS using Terraform, Jenkins, Docker, and CloudWatch. Features CI/CD pipelines, Dockerized Flask app deployment, and real-time monitoring with AWS-native services. <br>

🧾 We built a highly available, secure, and scalable application architecture on AWS. Traffic flows through Route 53 into an ALB distributed across two public subnets. The backend is hosted in private subnets via an Auto Scaling Group of Dockerized EC2 instances. Jenkins in a private subnet handles CI/CD, pushing images to ECR and deploying to EC2 via SSM. All traffic is internal, secrets are managed securely, and observability is enabled via CloudWatch

![image](https://github.com/user-attachments/assets/48e518f2-971a-47a9-be65-8286c1b817fd)



 ## Phase 1 - Build the Base Flask App, Create Docker Image, and Test the Container
1.  Create a basic Flask app - Create a file named app.py
2.  Create a Dockerfile
3.  To test build docker image - docker build -t app .
4.  Run the container -  docker run -p 5000:5000 app
5.  Open your browser and navigate to: 👉 http://localhost:5000
   
🔌 Docker Port Mapping and Flask Accessibility Explained
   <code> docker build -t app . && docker run -p 5000:5000 app </code>
   | Component           | Role                                                                 |
 | ------------------- | -------------------------------------------------------------------- |
 | `docker run -p`     | Maps host port to container port                                     |
 | Host port 5000      | You hit `http://localhost:5000` on browser — request reaches Docker  |
 | Container port 5000 | Docker forwards the request here                                     |
 | Flask on `0.0.0.0`  | Listens on all container interfaces, so it accepts incoming requests |

