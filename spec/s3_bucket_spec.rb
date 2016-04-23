require 'spec_helper'
require_relative '../lib/bulwark/s3_bucket'

describe Bulwark::S3Bucket do
  before do
    allow_any_instance_of(described_class).to receive(:client).and_return(client)
    allow(client).to receive_message_chain(:list_objects, :contents).and_return(s3_objects)
  end
  let(:client) { double(:client) }
  let(:s3_objects) do
    [
      Aws::S3::Types::Object.new(key: 'attachments/attachment.pdf'),
      Aws::S3::Types::Object.new(key: 'logos/company_logo.png')
    ]
  end
  let(:files) do
    s3_objects.map do |object|
      { key: object.key, file_name: object.key.split('/').last }
    end
  end

  describe '#files' do
    it 'converts s3 objects into a hash' do
      expect(described_class.new.files).to eq(files)
    end
  end
end
