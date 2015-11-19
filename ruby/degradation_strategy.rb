require 'singleton'

class DegradationStrategy
  include Singleton
  
  # Degrades sellIn and quality values due one iteration. Returns an
  # array containing sellIn and quality under 0 and 1 positions
  # respectively. This class defines default degradation
  # behavior. Inherited classes should redefine this method to achieve
  # another degradation strategy.
  def degrade(sell_in, quality)
    sell_in -= 1
    quality -= (sell_in < 0 ? 2 : 1)
    quality = 0 if quality < 0
    quality = 50 if quality > 50
    [sell_in, quality]
  end
end

Dir["./degradation/*.rb"].each {|file| require file }
