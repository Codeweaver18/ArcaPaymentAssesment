ReadMe
**********************
question number 2:-  to replicate and run the program,
     1-kindly setup development environment for Python.
     2-Install the appropriate AWS CLI tool and configure profile access with Access et Secret Key.
     3-sign up on aws  and navigate to => https://console.aws.amazon.com/cloudformation/
    4 -Copy and paste the content of "CloudFormation.yml" and create a cloudformation stack on aws.
    5-confirm stack creation was successfull and copy the EC2 instance id of the created instance
    6-Navigate to your python development environment and replace the default "instanceId" variable with the new instance id
    7-run the program and confirm the execution of the the functions respectively => "StopEc2Instance" et "StartEc2Instance" 
     8-Just incase you are having trouble with stack creation on AWS, switch ur region to "us-east-2"

Question number 1:
     -perform step 2 and 3 as instructed in question one
     -setup enviroment for terraform
     -navigae to the project directory and run the following commands
           {terraform init:-if all goes well, proceed wit terraform plan and then terraform apply.
           
            }

Improvement et betterway
************************
-a better way to do this is to store the ec2 userdata in s3 buckets and use the aws cli command to download and execute the content of the shell script
-also, terraform code should be manage using a suitable SCM