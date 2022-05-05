terraform { 
 backend "s3"{
  bucket = "terraform-bucket552022"
  key = "main"
  region = "eu-west-1"
  }
}
