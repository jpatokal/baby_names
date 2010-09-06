require 'spec_helper'

describe SearchController do
  describe "if two valid languages are given" do
    before do
      @lang1 = Language.create(:english => 'Foo 1', :local => 'Bar 1')
      @names = []
      @names << @lang1.names.create(:latin => 'Male', :normalized => 'Match', :gender => 'M')
      @names << @lang1.names.create(:latin => 'Unisex', :normalized => 'Match2', :gender => 'U')
      @red_herring = @lang1.names.create(:latin => 'Female', :normalized => 'Match', :gender => 'F')

      @lang2 = Language.create(:english => 'Foo 2', :local => 'Bar 2')
      @names << @lang2.names.create(:latin => 'Male', :normalized => 'Match', :gender => 'M')
      @names << @lang2.names.create(:latin => 'Male', :normalized => 'Match2', :gender => 'M')

      get :search, :language => {:first => @lang1.id, :second => @lang2.id }, :gender => {:id => 'M'}
    end

    it "should return success" do
      response.should be_success
    end

    it "should get list of matches" do
      @names.each do |name|
        assigns[:results].flatten.should include name
      end
    end

    it "should exclude different genders" do
      assigns[:results].flatten.should_not include(@red_herring)
    end
  end
end
