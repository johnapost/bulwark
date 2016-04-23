module Bulwark
  class FilePermittor
    attr_reader :permission

    def initialize(argv)
      @permission = set_permission(argv.first)
    end

    def change_permissions
      s3_bucket.files.each do |file|
        Aws::S3::ObjectAcl.new(s3_bucket.name, file[:key], client: s3_bucket.client).put({ acl: permission })
        puts "#{file[:file_name]} is now #{permission}"
      end
    end

    def s3_bucket
      @s3_bucket ||= Bulwark::S3Bucket.new
    end

    private

    def set_permission(argv)
      argv_to_permission(argv)
    rescue KeyError => e
      puts "#{e} is not a valid Bulwark command. Try these:\n\nbulwark publicize_files\nbulwark privatize_files\n\n"
      exit
    end

    def argv_to_permission(argv)
      { 'privatize'       => 'private',
        'privatize_files' => 'private',
        'publicize'       => 'public-read',
        'publicize_files' => 'public-read'
      }.fetch(argv)
    end
  end
end
