.PHONY: clean package deploy build

SKILL_ROOT := streaming_audio_skill
SKILL_BINARY := $(SKILL_ROOT)
SKILL_TEMPLATE_FILE := $(SKILL_ROOT).yaml
SKILL_OUTPUT_TEMPLATE_FILE := serverless-deploy_$(SKILL_TEMPLATE_FILE).yaml
STACK_NAME := streaming-audio-skill-lambda
BUCKET_NAME := tsbalexaskills
ZIP_ARCHIVE := $(SKILL_BINARY).zip
DEPLOY_DIR := deploy
DEPENDENCY_TOOL := /usr/local/bin/dep
GO_SRCS := streaming_audio_skill.go

clean:
	rm -rf $(DEPLOY_DIR)
	mkdir $(DEPLOY_DIR)

deploy: package
	aws cloudformation deploy \
		--template-file $(SKILL_OUTPUT_TEMPLATE_FILE) \
	  	--stack-name $(STACK_NAME) \
	  	--capabilities CAPABILITY_IAM

package: clean $(SKILL_BINARY)
	cp $(SKILL_BINARY) $(DEPLOY_DIR)
	(cd $(DEPLOY_DIR) && zip $(ZIP_ARCHIVE) $(SKILL_BINARY))
	aws cloudformation package \
		--template-file $(SKILL_TEMPLATE_FILE) \
	   	--output-template-file $(SKILL_OUTPUT_TEMPLATE_FILE) \
		--s3-bucket $(BUCKET_NAME)

$(SKILL_BINARY): $(GO_SRCS)
	@echo "GOPATH is $(GOPATH)"
	$(DEPENDENCY_TOOL) ensure
	GOOS=linux go build -o streaming_audio_skill
