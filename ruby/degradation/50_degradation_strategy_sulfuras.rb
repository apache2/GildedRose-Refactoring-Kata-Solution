class DegradationStrategySulfuras < DegradationStrategy
  def degrade(sell_in, quality)
    [sell_in, quality]
  end

  register_strategy(self) do |item|
    item.name == "Sulfuras, Hand of Ragnaros" ? true : false
  end
end
