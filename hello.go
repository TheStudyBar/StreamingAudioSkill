package main

import (
	"github.com/aws/aws-lambda-go/lambda"
)

// Response contains the message for the world
type Response struct {
	Message string
}

// Handler is the lambda hander
func Handler() (Response, error) {
	return Response{Message: "Hello, world"}, nil
}

func main() {
	lambda.Start(Handler)
}
