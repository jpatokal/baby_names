require 'spec_helper'

describe SearchController do
  describe "if two valid languages are given" do
    before do
      @lang1 = Language.create(:english => 'Foo 1', :local => 'Bar 1')
      @name1 = @lang1.names.create(:latin => 'Name', :normalized => 'Match')
      @name1.save!

      @lang2 = Language.create(:english => 'Foo 2', :local => 'Bar 2')
      @name2 = @lang2.names.create(:latin => 'Name', :normalized => 'Match')
      @name2.save!
    end
    
    it "should get list of matches" do
      get :search, :language => {:first => @lang1.id, :second => @lang2.id }
      assigns[:results][0].should include(@name1, @name2)
      response.should be_success
    end
  end
end
