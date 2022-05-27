resource "aws_vpc" "simple-web-app" {
    cidr_block = "10.0.0.0/16" 
    enable_dns_hostnames = true

    tags = {
        Name = "Web App VPC"
    }
}

resource "aws_internet_gateway" "simple-web-app" {
    vpc_id = aws_vpc.simple-web-app.id
}

resource "aws_route_table" "allow-outgoing-access" {
    vpc_id = aws_vpc.simple-web-app.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.simple-web-app.id
    }

    tags = {
        Name = "Route Table Allowing Outgoing Access"
    }
}

resource "aws_subnet" "subnet-public-jenkins" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.simple-web-app.id
    availability_zone = "ap-southeast-1a"

    tags = {
        Name = "Jenkins Subnet"
    }
}

resource "aws_subnet" "subnet-public-web-app" {
    cidr_block = "10.0.3.0/24"
    vpc_id = aws_vpc.simple-web-app.id
    availability_zone = "ap-southeast-1a"

    tags = {
        Name = "Simple Web App Subnet"
    } 
}

resource "aws_route_table_association" "jenkins-subnet" {
    subnet_id = aws_subnet.subnet-public-jenkins.id
    route_table_id = aws_route_table.allow-outgoing-access.id
}

resource "aws_route_table_association" "web-app-subnet" {
    subnet_id = aws_subnet.subnet-public-web-app.id
    route_table_id = aws_route_table.allow-outgoing-access.id
}

resource "aws_security_group" "allow-web-traffic" {
    name = "allow-web-traffic"
    description = "Allow HTTP / HTTPS inbound traffic"
    vpc_id = aws_vpc.simple-web-app.id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow-ssh-traffic" {
    name = "allow-ssh-traffic"
    description = "Allow SSH inbound traffic"
    vpc_id = aws_vpc.simple-web-app.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow-jenkins-traffic" {
    name = "allow-jenkins-traffic"
    description = "Allow jenkins inbound traffic"
    vpc_id = aws_vpc.simple-web-app.id

    ingress {
        description = "Jenkins"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow-staging-traffic" {
    name = "allow-stagin-traffic"
    description = "Allow Inbound traffic for security checks"
    vpc_id = aws_vpc.simple-web-app.id

    ingress {
        description = "Staging"
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow-all-outbound" {
    name = "allow-all-outbound"
    description = "Allow all outbound traffic"
    vpc_id = aws_vpc.simple-web-app.id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_network_interface" "jenkins" {
    subnet_id = aws_subnet.subnet-public-jenkins.id
    private_ips = ["10.0.1.50"]
    security_groups = [aws_security_group.allow-all-outbound.id,
                        aws_security_group.allow-ssh-traffic.id, 
                        aws_security_group.allow-jenkins-traffic.id,
                        aws_security_group.allow-staging-traffic.id]
}

resource "aws_network_interface" "simple-web-app" {
    subnet_id = aws_subnet.subnet-public-web-app.id
    private_ips = ["10.0.3.50"]
    security_groups = [ aws_security_group.allow-all-outbound.id,
                        aws_security_group.allow-ssh-traffic.id,
                        aws_security_group.allow-web-traffic.id ]
}

resource "aws_eip" "jenkins" {
    vpc = true
    network_interface = aws_network_interface.jenkins.id
    associate_with_private_ip = "10.0.1.50"
    depends_on = [
        aws_internet_gateway.simple-web-app
    ]
}

resource "aws_eip" "simple-web-app" {
    vpc = true
    network_interface = aws_network_interface.simple-web-app.id
    associate_with_private_ip = "10.0.3.50"
    depends_on = [
        aws_internet_gateway.simple-web-app
    ] 
}