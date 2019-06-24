module Synonymous
  class Word
    def initialize(data)
      @data = data
    end

    def to_s
      # https://dictionaryapi.com/products/json#sec-3.synlist
      @data.fetch("wd")
    end
    alias to_str to_s
  end
end
