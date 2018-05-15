module Hangman
  module Dictionary
    WORDS = File.read("words.txt").split("\n")

    def self.random
      if WORDS.sample.length > 4
        WORDS.sample
      end
    end
  end
end
