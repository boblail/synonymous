require "synonymous/entry"

module Synonymous
  class Response
    attr_reader :suggestions, :entries

    def initialize(word, response)
      data = JSON.parse(response.body)

      if data.all? { |entry| entry.is_a?(Hash) }
        entries = data.map { |result| Entry.new(result) }
        @entries, suggestions = entries.partition { |entry| entry.headword.to_s == word }
        @suggestions = suggestions.map { |entry| entry.headword.to_s }
      else
        @entries = []
        @suggestions = data
      end
    end

    def success?
      entries.any?
    end
  end
end
