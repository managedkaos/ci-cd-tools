AWS=/usr/local/bin/aws
JQ=/usr/local/bin/jq
STACKNAME=server
AWSPROFILE=cicd
KEYNAME=cicd-service-account
SSHUSER=ubuntu

$(STACKNAME).yml: $(STACKNAME).py
	python $< | tee $@

lint: $(STACKNAME).py
	pylint $<

clean:
	@rm $(STACKNAME).yml || echo "All clean! :D"

stack: $(STACKNAME).yml delete-stack
	@$(AWS) --profile=$(AWSPROFILE) cloudformation create-stack \
		--stack-name $(STACKNAME) \
		--template-body file://$(STACKNAME).yml \
		--tags Key=Name,Value=$(STACKNAME) \
		--parameters ParameterKey=KeyName,ParameterValue=$(KEYNAME)
	 $(AWS) --profile=$(AWSPROFILE) cloudformation wait stack-create-complete \
		 --stack-name $(STACKNAME)
	 $(AWS) --profile=$(AWSPROFILE) cloudformation describe-stacks \
		 --stack-name $(STACKNAME) | $(JQ) .Stacks[0].Outputs

describe-stack:
	 $(AWS) --profile=$(AWSPROFILE) cloudformation describe-stacks \
		 --stack-name $(STACKNAME) | $(JQ) .Stacks[0].Outputs,.Stacks[0].Parameters

delete-stack:
	$(AWS) --profile=$(AWSPROFILE) cloudformation delete-stack \
		--stack-name $(STACKNAME)
	$(AWS) --profile=$(AWSPROFILE) cloudformation wait stack-delete-complete \
		--stack-name $(STACKNAME)

ssh:
	@chmod 600 ~/.ssh/$(KEYNAME).pem
	ssh -i ~/.ssh/$(KEYNAME).pem $(SSHUSER)@$(shell $(AWS) --profile=$(AWSPROFILE) cloudformation describe-stacks --stack-name $(STACKNAME) | $(JQ) -r .Stacks[0].Outputs[1].OutputValue)

regionmap:
	python ./create_ami_region_map.py

list-stack:
	$(AWS) --profile=$(AWSPROFILE) cloudformation describe-stacks | jq .Stacks[].StackName

.PHONY: lint clean stack describe-stack delete-stack ssh regionmap list-stack
