require File.dirname(__FILE__) + '/spec_helper.rb'

describe Array do
  it 'should give a random element' do
    [].should respond_to(:random)
  end
  
  describe 'giving a random element' do
    before :each do
      @array = (1..20).to_a
    end
    
    it 'should find a random number' do
      @array.expects(:rand).returns(0)
      @array.random
    end
    
    it 'should find a random number between 0 and its length' do
      @array.expects(:rand).with(@array.length).returns(0)
      @array.random
    end
    
    it 'should return the element indexed by the random number' do
      i = 7
      @array.stubs(:rand).returns(i)
      @array.random.should == @array[i]
    end
  end
end
