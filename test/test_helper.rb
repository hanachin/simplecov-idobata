require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'webmock/minitest'
WebMock.disable_net_connect!(allow: 'codeclimate.com')
