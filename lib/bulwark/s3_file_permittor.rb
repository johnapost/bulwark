module Bulwark
  class S3FilePermittor
    attr_reader :client, :permission

    def initialize(permission:)
      @permission = permission
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
      ENV['S3_BUCKET']
    end

    private

    def client
      @client ||= begin
        Aws::S3::Client.new(
          access_key_id: ENV['S3_ACCESS_KEY_ID'],
          secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
          region: ENV['S3_REGION']
        )
      end
    end
  end
end
