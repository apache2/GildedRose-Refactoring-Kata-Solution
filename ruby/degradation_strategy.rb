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

  # Static method registers specific class to be able to assign with
  # corresponding item. Once registered, that class can be returned by
  # `::determine` method
  # 
  # Params: 
  # +klass+:: class to store in registry, should be a descendant of 
  # +DegradationStrategy+ class
  #
  # +&block+:: associated block, takes one argument, must return true
  # if given item fits conditions, otherwise false
  def self.register_strategy(klass, &block)
    @@registry.push({class: klass, proc: Proc.new(&block)})
  end
  @@registry = []

  # Returns an instance of +DegradationStrategy+ class, that fits to
  # given +item+. The classes, which have been registered through
  # `register_strategy` are considering first. If there isn't any,
  # then an instance of DegradationStrategy will return
  # 
  # Params: 
  # +item+:: an instance of +Item+
  def self.determine(item)
    @@registry.each do |registry_item|
      if registry_item[:proc].call(item)
        return registry_item[:class].instance
      end
    end
    return DegradationStrategy.instance
  end
end

Dir[File.join(File.dirname(__FILE__), 'degradation') + "/*.rb"].sort.each { |file| require file }
