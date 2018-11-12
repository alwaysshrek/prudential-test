# prudential-test
1. The <DEV_SERVER> is an Amazon Linux based Linux server and is a t2.micro EC2 instance hosted on a free tier AWS account.
2. The <DEV_SERVER> hosts both components : CI - Jenkins (in the 'jenkins' user account) and the DEV environment (in the 'dev' user account).
3. Server configuration (including Jenkins and docker installation) is part of script/jenkins_setup.sh
4. The job has been configured as a Multi-branch pipeline job driven by the configuration in Jenkinsfile. The Github Jenkinsfile is not actually used by the job since I don't have permissions on the original repo, so Jenkinsfile contents have been copied as is in the job configuration.
5. The job has the below stages:
  a. Checkout : The repo - https://github.com/ahfarmer/emoji-search.git
  b. Build Docker: Cleans old docker images, builds the new docker image with the build tag.
  c. Deploy: Deploys the built docker image to the dev Environment
  d. All the above steps are in a try..catch block, which will mail the user if anything fails.
6. The job is timed to run every 6 hours or based on every new commit(polled every 15 mins since no permissions to create push web hooks in original repo)

If provided with additional time, I would have done one/some of the following things:
* Would provision the EC2 instance and security groups through terraform.
* If there would have been more environments, I would have provisioned an ECS cluster (for each) along with supporting AWS resources through Terraform.
* Would have broken up the pipeline into separate jobs - manifest and deploy.
* Would have put some testcases in the pipeline Test stage.
