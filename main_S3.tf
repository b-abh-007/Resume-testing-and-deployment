
locals {
  bucket_name = "resume-website-hosting"
}

resource "aws_s3_bucket_website_configuration" "example" {
#   bucket = aws_s3_bucket.bucket.bucket
  bucket = local.bucket_name

  index_document {
    suffix = "resume.html" 
  }

}

resource "aws_s3_bucket_policy" "policy" {
  bucket = local.bucket_name
#   bucket = aws_s3_bucket.bucket.id
  policy = file("bucket-policy.json")
}

# resource "aws_s3_bucket" "bucket" {
#   bucket = local.bucket_name
# }


resource "aws_s3_bucket_acl" "acl" {
#   bucket = aws_s3_bucket.bucket.id
bucket = local.bucket_name
  acl    = "public-read"
}
 
resource "aws_s3_object" "folder-object" {
  bucket = local.bucket_name
  key    = "Resume/"
  # source       = "../Resume/"
  content_type = "application/x-directory"

}
# resource "aws_s3_object" "file-object-1" {
#   bucket = "test-rwh"
#   key    = "Resume/resume.html"
#   source = "../Resume/resume.html"

# }

# resource "aws_s3_object" "files" {
#   for_each = fileset("../Resume/", "*")

#   bucket = "test-rwh"
#   key    = "Resume/${each.value}"
#   source = "../Resume/${each.value}"

#   # etag makes the file update when it changes;
#   # see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
#   # etag   = filemd5("../Resume/${each.value}")
# }

resource "aws_s3_object" "html-files" {
  for_each = fileset("Resume/", "*.html")

  bucket       = local.bucket_name
  key          = "Resume/${each.value}"
  source       = "Resume/${each.value}"
  content_type = "text/html"
  # etag makes the file update when it changes;
  # see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  # etag   = filemd5("Resume/${each.value}")
}

resource "aws_s3_object" "css-files" {
  for_each = fileset("Resume/", "*.css")

  bucket       = local.bucket_name
  key          = "Resume/${each.value}"
  source       = "Resume/${each.value}"
  content_type = "text/css"
  # etag makes the file update when it changes;
  # see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  # etag   = filemd5("Resume/${each.value}")
}

resource "aws_s3_object" "js-files" {
  for_each = fileset("Resume/", "*.js")

  bucket       = local.bucket_name
  key          = "Resume/${each.value}"
  source       = "Resume/${each.value}"
  content_type = "application/javascript"
  # etag makes the file update when it changes;
  # see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  # etag   = filemd5("Resume/${each.value}")
}

resource "aws_s3_object" "image-files" {
  for_each = fileset("Resume/", "*.png")

  bucket       = local.bucket_name
  key          = "Resume/${each.value}"
  source       = "Resume/${each.value}"
  content_type = "image/jpeg"
  # etag makes the file update when it changes;
  # see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  # etag   = filemd5("Resume/${each.value}")
}

resource "aws_s3_object" "image-files-2" {
  for_each = fileset("Resume/", "*.jfif")

  bucket       = local.bucket_name
  key          = "Resume/${each.value}"
  source       = "Resume/${each.value}"
  content_type = "image/jpeg"
  # etag makes the file update when it changes;
  # see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  # etag   = filemd5("Resume/${each.value}")
}

# resource "aws_s3_object" "image-files-test" {
# #   for_each = fileset("Resume/", "*.jfif")

#   bucket       = local.bucket_name
#   key          = "Resume/house.jfif"
#   source       = "Resume/house.jfif"
#   content_type = "image/jpeg"
#   # etag makes the file update when it changes;
#   # see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
#   # etag   = filemd5("Resume/${each.value}")
# }
