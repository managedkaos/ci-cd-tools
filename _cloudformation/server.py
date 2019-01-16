'''Module: Create a CloudFormation Stack'''
import time
import troposphere.ec2 as ec2
from troposphere import Base64, FindInMap, GetAtt, Join
from troposphere import Parameter, Output, Ref, Template
from troposphere.cloudformation import Init, InitConfig, InitFiles, InitFile, Metadata
from troposphere.policies import CreationPolicy, ResourceSignal

def main():
    '''Function: Generates the Cloudformation template'''
    template = Template()
    template.add_description("A target server for CI/CD tests.")

    keyname_param = template.add_parameter(
        Parameter(
            'KeyName',
            Description='An existing EC2 KeyPair.',
            ConstraintDescription='An existing EC2 KeyPair.',
            Type='AWS::EC2::KeyPair::KeyName',
        )
    )

    template.add_mapping('RegionMap', {'ap-south-1': {'ami': 'ami-0dba8796fe499ae48'}, 'eu-west-3': {'ami': 'ami-07b2287c6776361c8'}, 'eu-north-1': {'ami': 'ami-34c14f4a'}, 'eu-west-2': {'ami': 'ami-0573b1dbbd809d6c3'}, 'eu-west-1': {'ami': 'ami-001b0e20a92d8db1e'}, 'ap-northeast-2': {'ami': 'ami-0dc961dd0c2c83bdd'}, 'ap-northeast-1': {'ami': 'ami-0f2c38ac2e37197be'}, 'sa-east-1': {'ami': 'ami-04ab6be036f8635bd'}, 'ca-central-1': {'ami': 'ami-0de195e1958cc0d52'}, 'ap-southeast-1': {'ami': 'ami-08540b8d2f7fa85a5'}, 'ap-southeast-2': {'ami': 'ami-0bbcf853aaf6ca4a6'}, 'eu-central-1': {'ami': 'ami-0332a5c40cf835528'}, 'us-east-1': {'ami': 'ami-0edd3706ab2e952c4'}, 'us-east-2': {'ami': 'ami-050553a7784d00d21'}, 'us-west-1': {'ami': 'ami-065ebd3e6b63c75d5'}, 'us-west-2': {'ami': 'ami-00f13b45242aff065'}})

    ec2_security_group = template.add_resource(
        ec2.SecurityGroup(
            'EC2SecurityGroup',
            Tags=[{'Key':'Name', 'Value':Ref('AWS::StackName')},],
            GroupDescription='EC2 Security Group',
            SecurityGroupIngress=[
                ec2.SecurityGroupRule(
                    IpProtocol='tcp',
                    FromPort='22',
                    ToPort='22',
                    CidrIp='0.0.0.0/0',
                    Description='SSH'),
                ec2.SecurityGroupRule(
                    IpProtocol='tcp',
                    FromPort='80',
                    ToPort='80',
                    CidrIp='0.0.0.0/0',
                    Description='HTTP'),
                ec2.SecurityGroupRule(
                    IpProtocol='tcp',
                    FromPort='443',
                    ToPort='443',
                    CidrIp='0.0.0.0/0',
                    Description='HTTPS'),
            ],
        )
    )

    ec2_instance = template.add_resource(
        ec2.Instance(
            'Instance',
            Metadata=Metadata(
                Init({
                    "config": InitConfig(
                        files=InitFiles({
                            "/tmp/instance.txt": InitFile(
                                content=Ref('AWS::StackName'),
                                mode="000644",
                                owner="root",
                                group="root"
                            )
                        }),
                    )
                }),
            ),
            CreationPolicy=CreationPolicy(
                ResourceSignal=ResourceSignal(Timeout='PT15M')
            ),
            Tags=[{'Key':'Name', 'Value':Ref('AWS::StackName')},],
            ImageId=FindInMap('RegionMap', Ref('AWS::Region'), 'ami'),
            InstanceType='t2.micro',
            KeyName=Ref(keyname_param),
            SecurityGroups=[Ref(ec2_security_group)],
            UserData=Base64(
                Join(
                    '',
                    [
                        '#!/bin/bash -x\n',
                        'exec > /tmp/user-data.log 2>&1\n',
                        'unset UCF_FORCE_CONFFOLD\n',
                        'export UCF_FORCE_CONFFNEW=YES\n',
                        'ucf --purge /boot/grub/menu.lst\n',
                        'export DEBIAN_FRONTEND=noninteractive\n',
                        'apt-get update\n',
                        'apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy upgrade\n',
                        'apt-get install -y nginx build-essential libssl-dev libffi-dev python-pip python3-pip python3-dev python3-setuptools python3-venv\n',
                        'pip install https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz\n',
                        '# Signal Cloudformation when set up is complete\n',
                        '/usr/local/bin/cfn-signal -e $? --resource=Instance --region=', Ref('AWS::Region'), ' --stack=', Ref('AWS::StackName'), '\n',
                    ]
                )
            )
        )
    )

    template.add_output([
        Output(
            'InstanceDnsName',
            Description='PublicDnsName',
            Value=GetAtt(ec2_instance, 'PublicDnsName'),
        ),
    ])

    print(template.to_yaml())

if __name__ == '__main__':
    main()
