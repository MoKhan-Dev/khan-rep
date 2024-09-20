import time
import boto3
ec2 = boto3.client('ec2')


response = ec2.run_instances(
    ImageId= 'ami-0fe630eb857a6ec83',
    InstanceType='t2.micro',
    MinCount=1,
    MaxCount=1,
    KeyName= 'red hat'
)
instance_id = response['Instances'][0]['InstanceId']
print("Successfuly launce RHEL EC2 instance with Instance ID:  " + instance_id)
ec2.create_tags(
    Resources=[instance_id],
    Tags=[{'Key':'Name', 'Value':'RHEL-Linux-Machine'}]
)
time.sleep(30)
response = ec2.terminate_instances(InstanceIds=[instance_id])
state = response['TerminatingInstances'][0]['CurrentState']['Name']
print(f"Instance " + instance_id + " is now " + state)
