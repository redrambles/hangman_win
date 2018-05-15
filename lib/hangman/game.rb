module Hangman
  class Game
    attr_reader :chances, :word, :wrong_tries, :guess

    def initialize
      @chances = 5
      @wrong_tries = 0
      @guess = ""
      @word = Dictionary.random
    end

    def play
      Graphics.clear_screen
      puts 'Guess this word: ' + Graphics.obfuscate_word(word, '')

      while true
        print "[#{@chances - wrong_tries} chances left]: "

        # If we get a ^C - let's bail gracefully
        Signal.trap("SIGINT") {
          Graphics.clear_screen
          Graphics.wanna_give_up
          exit
        }
        # Clear out the ARGV input so that gets.chomp works with user input
        ARGV.clear

        char = gets.chomp
        Graphics.clear_screen

        if word.include? char
          if guess.include? char

            if char == ""
              puts 'Hello - I need a letter please'
              puts 'Try again' + Graphics.obfuscate_word(word, guess)
              placeholder = Graphics.obfuscate_word(word, guess)
            else  
              puts "You already entered '#{char}'. Yes, it is still correct.. 🙄"
              puts 'Try again: ' + Graphics.obfuscate_word(word, guess)

            end

          else
            guess << char
            placeholder = Graphics.obfuscate_word(word, guess)

            puts 'Whoop Whoop!! ' + placeholder
          end

          unless placeholder.include? Graphics::OBFUSCATION_CHAR
            puts Graphics::ALIVE
            sleep 0.5
            Graphics.clear_screen
            puts Graphics::ALIVE2
            sleep 0.5
            Graphics.clear_screen
            puts Graphics::ALIVE3
            puts "\n\nWELL DONE!! YOU SURVIVED"
            break
          end
        else
          if !char.match(/^[[:alpha:]]$/) == true # If they did not guess a letter (special character)
            puts 'This is hangman! We need a letter! What the hell was that?'
          else
            if guess.include? char # If they already guessed this wrong letter -don't penalize them again
              puts "OH NOES! The word STILL doesn't contain '#{char}'"
              @wrong_tries = @wrong_tries
            else
              puts "OH NOES! The word doesn't contain '#{char}'"
              @wrong_tries = @wrong_tries + 1
              guess << char
            end
          end
          if wrong_tries == chances
            puts Graphics::DEAD
            puts "\nARRRRGGGGGGGGGGG YOU LOST! 😭  😵  ☠️"
            break
          else
            puts 'Try another: ' + Graphics.obfuscate_word(word, guess)
          end
        end
      end
    end
  end
end
