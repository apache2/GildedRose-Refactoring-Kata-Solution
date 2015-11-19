class DegradationStrategySulfuras < DegradationStrategy
  def degrade(sell_in, quality)
    [sell_in, quality]
  end
end
