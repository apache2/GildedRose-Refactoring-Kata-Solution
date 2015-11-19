class DegradationStrategyAgedBrie < DegradationStrategy
  def degrade(sell_in, quality)
    sell_in -= 1
    quality += (sell_in < 0 ? 2 : 1)
    quality = 0 if quality < 0
    quality = 50 if quality > 50

    [sell_in, quality]
  end
end
