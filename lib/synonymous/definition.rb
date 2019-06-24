require "synonymous/sense"

module Synonymous
  class Definition
    def initialize(data)
      @data = data
    end

    def senses
      # https://dictionaryapi.com/products/json#sec-2.sseq
      @data.fetch("sseq").map { |data| Sense.new(data) }
    end
  end
end
