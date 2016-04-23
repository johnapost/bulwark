require 'spec_helper'
require_relative '../lib/bulwark/s3_bucket'
require_relative '../lib/bulwark/file_permittor'

describe Bulwark::FilePermittor do
  describe '#initialize' do
    it 'a privatize command becomes a private permission' do
      file_permittor = described_class.new(['privatize_files'])
      expect(file_permittor.permission).to eq('private')
    end

    it 'a publicize command becomes a public-read permission' do
      file_permittor = described_class.new(['publicize_files'])
      expect(file_permittor.permission).to eq('public-read')
    end

    it 'exits with an invalid permission' do
      expect(STDOUT).to receive(:puts)
      expect { described_class.new(['foobar']) }.to raise_error(SystemExit)
    end
  end

  describe '#change_permissions' do
    before do
      allow_any_instance_of(Bulwark::S3Bucket).to receive(:files).and_return(files)
    end
    let(:files) do
      [{ key: 'attachments/attachment.pdf', file_name: 'attachment.pdf'}]
    end
    let(:file_permittor) { described_class.new(['privatize']) }

    it 'updates the file permission on Amazon S3' do
      allow(STDOUT).to receive(:puts)
      expect_any_instance_of(Aws::S3::ObjectAcl).to receive(:put).with({ acl: file_permittor.permission })
      file_permittor.change_permissions
    end

    it 'tells the user that the permission has changed' do
      allow_any_instance_of(Aws::S3::ObjectAcl).to receive(:put).with({ acl: file_permittor.permission })
      expect(STDOUT).to receive(:puts)
      file_permittor.change_permissions
    end
  end
end
