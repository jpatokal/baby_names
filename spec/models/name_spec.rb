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

  describe '#male?' do
    it 'should return true for a male name' do
      Name.create(:gender => 'M').should be_male
    end

    it 'should return true for a unisex name' do
      Name.create(:gender => 'U').should be_male
    end

    it 'should return false for a female name' do
      Name.create(:gender => 'F').should_not be_male
    end
  end

  describe '#female?' do
    it 'should return true for a female name' do
      Name.create(:gender => 'F').should be_female
    end

    it 'should return true for a unisex name' do
      Name.create(:gender => 'U').should be_female
    end

    it 'should return false for a male name' do
      Name.create(:gender => 'M').should_not be_female
    end
  end

  describe '#unisex?' do
    it 'should return true for a unisex name' do
      Name.create(:gender => 'U').should be_unisex
    end

    it 'should return false for anything else' do
      Name.create(:gender => 'X').should_not be_unisex
    end
  end
 
  describe '#compatible_gender?' do
    [
     { :first => 'M', :second => 'M', :expected_result => true },
     { :first => 'M', :second => 'F', :expected_result => false },
     { :first => 'M', :second => 'U', :expected_result => true },
     { :first => 'F', :second => 'F', :expected_result => true },
     { :first => 'F', :second => 'M', :expected_result => false },
     { :first => 'F', :second => 'U', :expected_result => true },
     { :first => 'U', :second => 'M', :expected_result => true },
     { :first => 'U', :second => 'F', :expected_result => true },
     { :first => 'U', :second => 'U', :expected_result => true },
    ].each do |combo|
      describe "for names with genders #{combo[:first]}, #{combo[:second]}" do
        it "should return #{combo[:expected_result]}" do
          first = Name.create(:gender => combo[:first])
          second = Name.create(:gender => combo[:second])
          first.compatible_gender?(second).should == combo[:expected_result]
        end
      end
    end
  end

  describe '#gender_from_string!' do
    it "should set a boy to male" do
      name = Name.create.gender_from_string!('boy')
      name.should be_male
    end

    it "should set a girl to female" do
      name = Name.create.gender_from_string!('girl')
      name.should be_female
    end

    it "should set unisex to unisex" do
      name = Name.create.gender_from_string!('unisex')
      name.should be_male
      name.should be_female
    end

    it "should raise exception for an unknown gender" do
      lambda {
        name = Name.create.gender_from_string!('klingon')
      }.should raise_error
    end
  end

  describe '#normalize!' do
    it "should set the normalized name to the latin name" do
      Name.create(:latin => "Foo", :normalized => "Bar").normalize!.should == Name.create(:normalized => "Foo")
    end

  end

  describe '#validate' do
    it "should reject unknown genders" do
      Name.new(:gender => 'X').validate.should_not be_empty
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
