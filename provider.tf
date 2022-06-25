provider "aws" {
  region = var.AWS_REGION
 default_tags {
   tags = {

      environment = "dev"

      # #sandbox, dev, test, qa, uat, stage, prod, hotfix, train, mgmt

      # patchgroup = "a"

      # #os patchgroup determines frequency a, b, c, opt-out

      # project-infrastructure = true

      # project-ses = false

      # project-edp = false

      # project-nmls = false

      # #project-infrastructure, project-ses, project-edp, project-nmls

      # application = "datadog"

      # #AMI = "centos-7-golden-image"

      # #add or interpolate the ami from repo and replace above

      # iac-terraform = true

      # #iac-terraform, iac-cloudformation, iac-none

      # #commit = ""

      # #commit ID would need to be tagged manually to id statefile or maybe done before runner deploys

      # repo = "https://gitlab.srrcsbs.org/nmls/infrastructure/datadog_instance_creation/"

      # #copy repo url and replace above

      # start-stop = "schedule-a"

      # #schedule-a (7x24), schedule-b (M-F 9-5), schedule-c (M-F 6-6)

      # datadogagentenabled = true

   }
 }

 assume_role {
    role_arn    = "arn:aws:iam::560089993749:role/Engineer"
  
  }
}


