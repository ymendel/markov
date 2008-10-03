require File.dirname(__FILE__) + '/spec_helper.rb'

describe Markov do
  before :each do
    @markov = Markov.new
  end
  
  describe 'when initialized' do
    before :each do
      Markov.instance_eval do
        public :data
      end
    end
    
    it 'should have empty data' do
      @markov.data.should == {}
    end
  end
  
  it 'should allow adding' do
    @markov.should respond_to(:add)
  end
  
  describe 'adding' do
    it 'should accept an argument' do
      lambda { @markov.add('a') }.should_not raise_error(ArgumentError)
    end
    
    it 'should accept multiple arguments' do
      lambda { @markov.add('a', 'b', 'c', 'd', 'e', 'f') }.should_not raise_error(ArgumentError)
    end
    
    it 'should require at least one argument' do
      lambda { @markov.add }.should raise_error(ArgumentError)
    end
  end
end
