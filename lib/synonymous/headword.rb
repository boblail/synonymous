module Synonymous
  class Headword
    def initialize(data)
      @data = data
    end

    def to_s
      # https://dictionaryapi.com/products/json#sec-2.hwi
      @data.fetch("hw")
    end
    alias to_str to_s
  end
end
