require 'spec_helper'

describe SearchController do
  describe "if two valid languages are given" do
    before do
      @lang1 = Language.create(:english => 'Foo 1', :local => 'Bar 1')
      @name1 = @lang1.names.create(:latin => 'Name', :normalized => 'Match', :gender => 'M')
      @red_herring = @lang1.names.create(:latin => 'Wrong gender', :normalized => 'Match', :gender => 'F')

      @lang2 = Language.create(:english => 'Foo 2', :local => 'Bar 2')
      @name2 = @lang2.names.create(:latin => 'Name', :normalized => 'Match', :gender => 'M')

      get :search, :language => {:first => @lang1.id, :second => @lang2.id }, :gender => {:id => 'M'}
    end

    it "should return success" do
      response.should be_success
    end

    it "should get list of matches" do
      assigns[:results].flatten.should include(@name1, @name2)
    end

    it "should exclude different genders" do
      assigns[:results].flatten.should_not include(@red_herring)
    end
  end
end
