#!/bin/bash

# Set variables
INSTANCE_NAME="freelance-demo-instance"
AMI_ID="ami-0c02fb55956c7d316"  # Ubuntu 22.04 LTS (update based on region)
INSTANCE_TYPE="t2.micro"
KEY_NAME="freelance-key"
SECURITY_GROUP_NAME="freelance-sg"
REGION="us-east-1"

echo ">>> Creating security group..."
SECURITY_GROUP_ID=$(aws ec2 create-security-group \
  --group-name "$SECURITY_GROUP_NAME" \
  --description "Freelance demo SG" \
  --region "$REGION" \
  --output text \
  --query 'GroupId')

echo ">>> Adding rules to security group..."
aws ec2 authorize-security-group-ingress --group-id "$SECURITY_GROUP_ID" \
  --protocol tcp --port 22 --cidr 0.0.0.0/0 --region "$REGION"
aws ec2 authorize-security-group-ingress --group-id "$SECURITY_GROUP_ID" \
  --protocol tcp --port 80 --cidr 0.0.0.0/0 --region "$REGION"

echo ">>> Creating key pair..."
aws ec2 create-key-pair --key-name "$KEY_NAME" \
  --query 'KeyMaterial' --output text > "$KEY_NAME.pem"
chmod 400 "$KEY_NAME.pem"

echo ">>> Launching EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id "$AMI_ID" \
  --count 1 \
  --instance-type "$INSTANCE_TYPE" \
  --key-name "$KEY_NAME" \
  --security-group-ids "$SECURITY_GROUP_ID" \
  --region "$REGION" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
  --user-data file://user-data.sh \
  --query 'Instances[0].InstanceId' \
  --output text)

echo ">>> Waiting for instance to be running..."
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID" --region "$REGION"

PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --region "$REGION" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

echo ">>> EC2 instance launched successfully!"
echo "Instance ID: $INSTANCE_ID"
echo "Public IP: $PUBLIC_IP"
echo "Connect: ssh -i $KEY_NAME.pem ubuntu@$PUBLIC_IP"
