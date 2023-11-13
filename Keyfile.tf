#============== FILE Function =============
#== SYNTAX is in below line ==
############## file("${path.module}/hello.txt") #################

# METHOD-1 -- In this method we can copy the entire RSA key under "public_key" argument(i.e., input).
# ========
#  Ex:- public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2dGHx7eJyZ8n7OAKUryNOYOf5ctsVn3iOzxqWQmawmW7dFZgpV45zz9IBxwdyZq2Brt/264836w0wFyv9f2yU6sImaHxnNUIvomJex/1bOvky4OzOAQg5kYp/7kH0827D6L429+sT0H+9KHrwa0UTH/SeAlZkjHJoGc/osE8xLSAn9C8HzsuPkMqSgQSjpt40SPalVkQAmsToOhX/qFBpKNB+Sx0u1sOLQtF/F1mrOojxvrVj82hsjm6F0X7tiMJlqi0GzLSHigEbuLOW0j+fQpROEIApkHh1cPWgMUJcZNqezQ6gxG4vA/T6JRi9wl6xWtwNgHVmrG+GEMlO7ziEGjbTAvSDZHzPovjUE+rC7FPic+lY6cqExZgIxe/dfzKI/ibEqyGb7ApBoHJj8XRMly4btd6EcTGFVz2FTuDveCWECEHDmq/XoIWplmLC/YYN7jsyHKSmXpbSsSAORkD1pubJSAtvPqVSJ0wNfRB5zpxq2uTKDUl6Cj9mSq74mcE= prakash@VGLAP-HP-01"

# METHOD-2(i) -- We can add the entire key file in separate file and calling that file to here using below line.
# ===========
#  <-- public_key =  file("${path.module}/id_rsa.pub")  -->
#  Here Path Module is the location of file. 
#  In the place of "/id_rsa.pub" we can give any file like ".txt" file also. Here in this example we have   given RSA key.

#  METHOD-2(ii) -- Instead of "${path.module}/" we give the entire path as below.
# ==============
#   Ex:-  public_key = file("C:/Users/username/Terraform/id_rsa.pub")

resource "aws_key_pair" "CICD" {
  key_name   = "CICD-key"
  public_key = file("${path.module}/id_rsa.pub")
}
