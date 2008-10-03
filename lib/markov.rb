$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

class Markov
  private
  attr_accessor :data
  
  public
  def initialize
    @data = {}
  end
  
  def reset
    @data = {}
  end
  
  def add(*items)
    raise ArgumentError, 'at least one argument required' if items.empty?
    data[items.first] = {}
  end
end
