import boto3
import sys
from botocore.config import Config
from botocore.exceptions import ClientError

my_config = Config(
    region_name = 'us-east-2',
    signature_version = 'v4',
    retries = {
        'max_attempts': 10,
        'mode': 'standard'
    }
)

ec2 = boto3.client('ec2')



#Function for stoping already running AWS EC2 instance
def StopEc2Instance(instanceId):
    print('About to stop EC2 instance with Instance Id ' + instanceId)
    try:
        response = ec2.stop_instances(InstanceIds=[instanceId], DryRun=False )
        print(response)
    except ClientError as e:
        print(e)
 
#Function for starting  Running Ec2 instance.
def StartEc2Instance(instanceId):
    print('About to Start EC2 instance with Instance Id ' + instanceId)
    try:
        response = ec2.start_instances(InstanceIds=[instanceId], DryRun=False )
        print(response)
    except ClientError as e:
        print(e)    

#Calling  Start EC2 Instance
StartEc2Instance('i-0eb6e8c3fe106320f')

