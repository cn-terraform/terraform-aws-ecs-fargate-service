# Running tests

* In a separate shell, run localstack:
    * `docker pull localstack/localstack`
    * `docker run --rm -it -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack`
* In a shell in the ./examples/test directory run:
    * `export AWS_ACCESS_KEY_ID=localstack`
    * `export AWS_SECRET_ACCESS_ID=localstack`
    * `export AWS_REGION=us-east-1`
    * `terraform plan`
