# mysimpleminiproject
Hello World!

Ideally, you should create the VPC, subnets and security groups separately so that Github actions won't flag an error during your next run.

Add a github actions step for sleep 5/10min followed by terraform destroy, which allows you to view your created resources before they are destroyed.