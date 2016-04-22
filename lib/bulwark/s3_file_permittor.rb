module Bulwark
  class S3FilePermittor
    attr_reader :permission

    def initialize(command)
      @permission = set_permission(command.first)
    end

    def set_permission(command)
      command_to_permission(command)
    rescue KeyError => e
      puts "#{e} is not a valid Bulwark command. Try these:\n\nbulwark publicize_files\nbulwark privatize_file\n\n"
      exit
    end

    def files
      client.list_objects(bucket: bucket).contents
    end

    def file_keys
      files.map { |file| file.key }
    end

    def change_permissions
      file_keys.each do |key|
        Aws::S3::ObjectAcl.new(bucket, key, client: client).put({ acl: permission })
        puts "#{key} is now #{permission}"
      end
    end

    def bucket
      ENV.fetch('S3_BUCKET')
    end

    private

    def command_to_permission(command)
      { 'privatize'       => 'private',
        'privatize_files' => 'private',
        'publicize'       => 'public-read',
        'publicize_files' => 'public-read'
      }.fetch(command)
    end

    def client
      @client ||= begin
        Aws::S3::Client.new(
          access_key_id: ENV.fetch('S3_ACCESS_KEY_ID'),
          secret_access_key: ENV.fetch('S3_SECRET_ACCESS_KEY'),
          region: ENV.fetch('S3_REGION')
        )
      end
    end
  end
end
