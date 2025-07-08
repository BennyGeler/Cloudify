output "instance_public_ip" {
  value = module.ec2.instance_public_ip
}

output "volume_id" {
  value = module.ec2.volume_id
}

output "bucket_name" {
  value = module.s3.bucket_name
}

output "key_pair_name" {
  value = module.ec2.key_pair_name
}
