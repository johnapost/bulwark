require 'bundler'
require_relative 'lib/s3_file_permittor'
Bundler.require
Dotenv.load

S3FilePermittor.new(permission: 'private').change_permissions
