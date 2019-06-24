require "synonymous/word"

module Synonymous
  class Sense
    def initialize(data)
      if data.length > 1
        pp data
        raise Synonymous::Error, "Sense Sequence has more than one element"
      end
      unless data[0][0] == "sense"
        pp data[0]
        raise Synonymous::Error, "Sense didn't start with keyword 'sense'"
      end
      unless data[0].length == 2
        pp data[0]
        raise Synonymous::Error, "Sense has more than two entries"
      end

      @data = data[0][1]
    end

    def number
      # https://dictionaryapi.com/products/json#sec-2.sn
      @data["sn"]
    end

    def to_s
      # https://dictionaryapi.com/products/json#sec-2.dt
      @data.fetch("dt").to_h.fetch("text").strip
    end

    def synonyms
      # https://dictionaryapi.com/products/json#sec-3.synlist
      @data.fetch("syn_list", []).flatten.map(&Word.method(:new))
    end

    def related_words
      # https://dictionaryapi.com/products/json#sec-3.rellist
      @data.fetch("rel_list", []).flatten.map(&Word.method(:new))
    end

    def synonymous_phrases
      # https://dictionaryapi.com/products/json#sec-3.phraselist
      @data.fetch("phrase_list", []).flatten.map(&Word.method(:new))
    end

    def antonyms
      # https://dictionaryapi.com/products/json#sec-3.antlist
      @data.fetch("ant_list", []).flatten.map(&Word.method(:new))
    end

    def near_antonyms
      # https://dictionaryapi.com/products/json#sec-3.nearlist
      @data.fetch("near_list", []).flatten.map(&Word.method(:new))
    end
  end
end
