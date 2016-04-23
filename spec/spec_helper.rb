require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'rspec'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow: 'codeclimate.com')

require 'dotenv'
require 'aws-sdk'
Dotenv.load
