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
  
  it 'should reset itself' do
    @markov.should respond_to(:reset)
  end
  
  describe 'when resetting itself' do
    before :each do
      Markov.instance_eval do
        public :data, :data=
      end
    end
    
    it 'should empty its data' do
      @markov.data = { 'a' => [ 'b' ] }
      @markov.reset
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
  
  describe 'checking data after adding' do
    before :each do
      Markov.instance_eval do
        public :data, :data=
      end
    end
    
    describe 'a single argument' do
      it 'should add the argument when its data is empty' do
        @markov.reset
        @markov.add('a')
        @markov.data.should == { 'a' => [] }
      end
      
      it 'should add the argument to already-present data' do
        @markov.data = { 'a' => [ 'b' ] }
        @markov.add('e')
        @markov.data.should == { 'a' => [ 'b' ], 'e' => [] }
      end
    end
    
    describe 'a pair of arguments' do
      it 'should add the arguments when its data is empty' do
        @markov.reset
        @markov.add('a', 'b')
        @markov.data.should == { 'a' => [ 'b' ], 'b' => [] }
      end
      
      it 'should add the arguments to already-present data' do
        @markov.data = { 'a' => [ 'b' ] }
        @markov.add('e', 'f')
        @markov.data.should == { 'a' => [ 'b' ], 'e' => [ 'f' ], 'f' => [] }
      end
    end
    
    describe 'many arguments' do
      it 'should add the arguments when its data is empty' do
        @markov.reset
        @markov.add('a', 'b', 'c', 'd', 'e')
        @markov.data.should == { 'a' => [ 'b' ], 'b' => [ 'c' ], 'c' => [ 'd' ], 'd' => [ 'e' ], 'e' => [] }
      end
      
      it 'should add the arguments to already-present data' do
        @markov.data = { 'a' => [ 'b' ] }
        @markov.add('e', 'f', 'g', 'h', 'i')
        @markov.data.should == { 'a' => [ 'b' ], 'e' => [ 'f' ], 'f' => [ 'g' ], 'g' => [ 'h' ], 'h' => [ 'i' ], 'i' => [] }
      end
    end
  end
end
