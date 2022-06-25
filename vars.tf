variable "AWS_REGION" {
 default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "ses_key.pub"
}

variable "vpc_id"{
    default="vpc-07f3ccd94470f2f70"
}


variable "ami" {
  default = "ami-08f3d892de259504d"
}

variable "instance_type"{
  default ="t2.small"
}

variable "subnets" {
  type = list(string)
  default=[
    "subnet-095f8e571c239c885",
    "subnet-018e1b83fc5bf7daf",
   ]
}

