require 'spec_helper'

describe Name do

  describe '#==' do

    it "should match if the normalized names are exactly the same" do
      Name.create(:normalized => "Foo").should == Name.create(:normalized => "Foo")
    end

    it "should not match if the normalized names are different" do
      Name.create(:normalized => "Foo").should_not == Name.create(:normalized => "Bar")
    end

  end

end
