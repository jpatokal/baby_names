require 'spec_helper'

describe Name do

  describe '#==' do

    it "should match if the normalized names are exactly the same" do
      Name.create(:normalized => "Foo").should == Name.create(:normalized => "Foo")
    end

    it "should not match if the normalized names are different" do
      Name.create(:normalized => "Foo").should_not == Name.create(:normalized => "Bar")
    end

    it "should not match if the gender is not compatible" do
      Name.create(:gender => 'boy').should_not == Name.create(:gender => "F")
    end
  end

  describe '#locale' do
    it 'should return nil' do
      Name.new.locale.should be_nil
    end
  end

  describe '#male?' do
    it 'should return true for a male name' do
      Name.create(:gender => 'boy').should be_male
    end

    it 'should return true for a unisex name' do
      Name.create(:gender => 'unisex').should be_male
    end

    it 'should return false for a female name' do
      Name.create(:gender => 'girl').should_not be_male
    end
  end

  describe '#female?' do
    it 'should return true for a female name' do
      Name.create(:gender => 'girl').should be_female
    end

    it 'should return true for a unisex name' do
      Name.create(:gender => 'unisex').should be_female
    end

    it 'should return false for a male name' do
      Name.create(:gender => 'boy').should_not be_female
    end
  end

  describe '#unisex?' do
    it 'should return true for a unisex name' do
      Name.create(:gender => 'unisex').should be_unisex
    end

    it 'should return false for anything else' do
      Name.create(:gender => 'boy').should_not be_unisex
      Name.create(:gender => 'girl').should_not be_unisex
    end
  end
 
  describe '#compatible_gender?' do
    [
     { :first => 'boy'   , :second => 'boy'   , :expected_result => true },
     { :first => 'boy'   , :second => 'girl'  , :expected_result => false },
     { :first => 'boy'   , :second => 'unisex', :expected_result => true },
     { :first => 'girl'  , :second => 'girl'  , :expected_result => true },
     { :first => 'girl'  , :second => 'boy'   , :expected_result => false },
     { :first => 'girl'  , :second => 'unisex', :expected_result => true },
     { :first => 'unisex', :second => 'boy'   , :expected_result => true },
     { :first => 'unisex', :second => 'girl'  , :expected_result => true },
     { :first => 'unisex', :second => 'unisex', :expected_result => true },
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

  describe '#after_initialize' do
    it "should set a boy to male" do
      Name.create(:gender => 'boy').should be_male
    end

    it "should set a girl to female" do
      Name.create(:gender => 'girl').should be_female
    end

    it "should set a girl to female" do
      Name.create(:gender => 'unisex').should be_unisex
    end

    it "should raise exception for an unknown gender" do
      lambda {
        name = Name.create(:gender => 'klingon')
      }.should raise_error
    end
  end

  describe '#normalize!' do
    it "should set the normalized name to the latin name" do
      name = Name.new(:latin => 'Foo', :normalized => 'Bar').normalize!

      name.normalized.should == 'Foo'
    end

  end

  describe '#validate' do
    it "should reject unknown genders" do
      name = Name.new
      name.gender = 'X'
      name.validate.should_not be_empty
    end
  end

  describe '#permutations' do
    it "should return an array containing the normalized name" do
      Name.create(:latin => "Foo").permutations.should == [ "Foo" ]
    end
  end
end
