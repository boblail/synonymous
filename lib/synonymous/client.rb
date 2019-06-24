require "faraday"
require "faraday/raise_errors"
require "json"

require "synonymous/response"

module Synonymous
  class Client
    attr_reader :api_key

    def initialize(api_key:)
      @api_key = api_key
    end

    def get(word)
      Response.new(word, client.get("#{URI.escape(word)}?key=#{api_key}"))
    end

  private
    attr_reader :client

    def client
      @client ||= Faraday.new("https://www.dictionaryapi.com/api/v3/references/thesaurus/json") do |client|
        client.use Faraday::RaiseErrors
        client.adapter Faraday.default_adapter
      end
    end
  end
end
