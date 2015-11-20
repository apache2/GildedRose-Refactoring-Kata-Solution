require File.join(File.dirname(__FILE__), 'degradation_strategy')

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      item.update_quality()
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality, :degradation_strategy;

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
    @degradation_strategy = DegradationStrategy.determine(self)
  end
  
  def update_quality()
    @sell_in, @quality = @degradation_strategy.degrade(@sell_in, @quality)
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
