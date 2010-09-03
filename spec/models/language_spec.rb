require 'spec_helper'

describe Language do

  describe "#locale_names" do
    describe "if the locale is known" do
      module Locale::Test
        def permutations
          [ "locale name" ]
        end
      end

      before do
        @language = Language.create(:english => "Test", :local => "Test")
        @name1 = @language.names.create(:latin => "1")
        @name2 = @language.names.create(:latin => "2")
        @locale_names = @language.locale_names
      end

      it "should return all names" do
        @locale_names.should include(@name1, @name2)
      end

      it "should use the permutations method in the locale" do
        @locale_names.each do |locale_name|
          locale_name.permutations.should include "locale name"
        end
      end
    end

    describe "if the locale is not known" do
      before do
        @language = Language.create(:english => "Test", :local => "Test")
        @name1 = @language.names.create(:latin => "1")
        @name2 = @language.names.create(:latin => "2")
        @locale_names = @language.locale_names
      end

      it "should return the same as #names" do
        @locale_names.should == @language.names
      end
    end
  end

end
