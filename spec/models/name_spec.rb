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

  describe '#normalize' do

    it "should set the normalized name to the latin name" do
      Name.create(:latin => "Foo", :normalized => "Bar").normalize!.should == Name.create(:normalized => "Foo")
    end

  end

  describe '#save' do

    it "should create a normalized name if none was given" do
      Name.create(:latin => "Foo").normalized.should == "Foo"
    end

    it "should not create a normalized name if one was given" do
      Name.create(:latin => "Foo", :normalized => "Bar").normalized.should == "Bar"
    end

  end

  describe '#permutations' do
    it "should return an array containing the normalized name" do
      Name.create(:normalized => "Foo").permutations.should == [ "Foo" ]
    end
  end
end
