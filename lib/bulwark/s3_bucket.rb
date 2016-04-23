module Bulwark
  class S3Bucket
    def client
      @client ||= begin
        Aws::S3::Client.new(
          access_key_id: ENV.fetch('S3_ACCESS_KEY_ID'),
          secret_access_key: ENV.fetch('S3_SECRET_ACCESS_KEY'),
          region: ENV.fetch('S3_REGION')
        )
      end
    end

    def files
      raw_files.map do |file|
        { key: file.key, file_name: file.key.split('/').last }
      end
    end

    def name
      ENV.fetch('S3_BUCKET')
    end

    private

    def raw_files
      client.list_objects(bucket: name).contents
    end
  end
end
