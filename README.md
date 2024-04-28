# aws-lambda-docker-test-local
 
### Local Testing:

1. Build the image
docker build -t lambda_scraping .

2. Run the image
docker run -p 9000:8080 lambda_scraping:latest

3. Test the running image
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'