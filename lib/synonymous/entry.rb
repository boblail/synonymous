require "synonymous/definition"
require "synonymous/headword"

module Synonymous
  class Entry
    def initialize(data)
      @data = data
    end

    def functional_label
      # https://dictionaryapi.com/products/json#sec-2.fl
      @data.fetch("fl")
    end

    def headword
      # https://dictionaryapi.com/products/json#sec-2.hwi
      Headword.new(@data.fetch("hwi"))
    end

    def senses
      definition.senses
    end

    def definition
      case definitions.count
      when 1 then definitions[0]
      when 0 then raise Synonymous::Error, "No definitions"
      else raise Synonymous::Error, "Multiple definitions"
      end
    end

    def definitions
      # https://dictionaryapi.com/products/json#sec-2.def
      @data.fetch("def").map { |data| Definition.new(data) }
    end
  end
end
