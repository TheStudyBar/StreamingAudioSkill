package main

import (
	"github.com/aws/aws-lambda-go/lambda"
)

// Response contains the message for the world
type Response struct {
	Version string  `json:"version"`
	Body    ResBody `json:"response"`
}

// ResBody is the actual body of the response
type ResBody struct {
	OutputSpeech     Payload ` json:"outputSpeech,omitempty"`
	ShouldEndSession bool    `json:"shouldEndSession"`
}

// Payload ...
type Payload struct {
	Type string `json:"type,omitempty"`
	Text string `json:"text,omitempty"`
}

// NewResponse builds a simple Alexa session response
func NewResponse(speech string) Response {
	return Response{
		Version: "1.0",
		Body: ResBody{
			OutputSpeech: Payload{
				Type: "PlainText",
				Text: speech,
			},
			ShouldEndSession: true,
		},
	}
}

// Handler is the lambda hander
func Handler() (Response, error) {
	return NewResponse("Hello, World"), nil
}

func main() {
	lambda.Start(Handler)
}
