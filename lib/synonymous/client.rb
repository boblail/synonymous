require "faraday"
require "json"

require "synonymous/response"

module Synonymous
  class Client
    attr_reader :api_key

    def initialize(api_key:)
      @api_key = api_key
    end

    def get(word)
      Response.new(word, client.get("#{URI.encode_www_form_component(word).gsub("+", "%20")}?key=#{api_key}"))
    end

  private

    def client
      @client ||= Faraday.new("https://www.dictionaryapi.com/api/v3/references/thesaurus/json") do |client|
        client.response :raise_error
        client.adapter Faraday.default_adapter
      end
    end
  end
end
