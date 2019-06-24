$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "synonymous"

require "minitest/autorun"
require "shoulda/context"
require "webmock"
require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.define_cassette_placeholder("<DICTIONARYAPI_KEY>") { ENV["DICTIONARYAPI_KEY"] }
end
