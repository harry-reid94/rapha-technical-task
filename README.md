# Rapha Senior DevOps Engineer technical task

This is a Terraform repository for deploying an Apache web server to ECS Fargate in AWS.

## System Design

## Design Choices



## Usage

First configure the remote state by instantiating the [init_tf_state](https://github.com/harry-reid94/rapha-technical-task/tree/master/terraform/init_tf_state) subdirectory:

```
terraform init
terraform plan
terraform apply
```
This creates an S3 bucket to store the state file and also a DynamoDB table for the state lock.
Then navigate to the parent directory where the main code lies and run the same Terraform commands to create the system. Output from plan:

```
Plan: 22 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + load_balancer_ip = (known after apply)
```

## Example Output

```plain
❯ curl http://lb-rapha-1073370279.eu-west-1.elb.amazonaws.com
<html><body><h1>It works!</h1></body></html>
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.7.0 |

Recommend using tfenv for Terraform version management - https://github.com/tfutils/tfenv

## Considerations

