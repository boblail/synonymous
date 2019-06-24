require "test_helper"

class SynonymousTest < Minitest::Test
  attr_reader :response

  context "asdf" do
    setup do
      VCR.use_cassette("asdf", record: :new_episodes) do
        @response = client.get("asdf")
      end
    end

    should "not be successful" do
      assert_equal false, response.success?
    end

    should "suggest words you might mean" do
      assert response.suggestions.to_set > Set["aside", "aid"]
    end
  end

  context "slice" do
    setup do
      VCR.use_cassette("slice", record: :new_episodes) do
        @response = client.get("slice")
      end
    end

    should "be successful" do
      assert_equal true, response.success?
    end

    should "have two parts of speech: noun and verb" do
      assert_equal %w{ noun verb }, response.entries.map(&:functional_label).sort
    end
  end

  context "adaptable" do
    setup do
      VCR.use_cassette("adaptable", record: :new_episodes) do
        @response = client.get("adaptable")
      end
    end

    should "have one part of speech: adjective" do
      assert_equal %w{ adjective }, response.entries.map(&:functional_label)
    end

    should "have two senses" do
      assert_equal [
        "able to do many different kinds of things",
        "capable of being readily changed"
      ], response.entries[0].senses.map { |sense| sense.to_s }
    end
  end

  context "phrases" do
    setup do
      VCR.use_cassette("police force", record: :new_episodes) do
        @response = client.get("police force")
      end
    end

    should "work" do
      assert response.success?
    end
  end

private

  def client
    Synonymous::Client.new(api_key: ENV["DICTIONARYAPI_KEY"])
  end
end
