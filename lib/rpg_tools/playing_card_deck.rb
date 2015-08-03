module RpgTools
  class PlayingCardDeck
    attr_accessor :type, :card_picks, :value

    def initialize(type)
      @type = type
      type_check
      @card_picks = 0
      @value = nil
    end

    def card
      @card_picks += 1

      @value =
        if @type == 52
          joker_picked? ? 'Joker' : standard_card
        else
          standard_card
        end
    end

    def hand
      [].tap do |hand|
        until hand.count == 5
          card = standard_card

          unless hand.include?(card) || hand.count('Joker') == 2
            hand << card
            @card_picks += 1
          end
        end
      end
    end

    private

    def type_check
      unless [32, 52].include?(@type)
        raise ArgumentError.new('A playing card deck contains 32 or 52 cards only.')
      end
    end

    def joker_picked?
      [0, 1].include?((0..54).to_a.sample(1).first)
    end

    def number
      if @type == 32
        [(7..10).to_a, 'Jack', 'Queen', 'King'].flatten.sample(1)
      else
        [(1..10).to_a, 'Jack', 'Queen', 'King'].flatten.sample(1)
      end
    end

    def color
      ['Clubs', 'Hearts', 'Diamonds', 'Spades'].sample(1)
    end

    def standard_card
      @value = [number, color].join(' of ')
    end
  end
end
