require 'spec_helper'

module Locale
  describe Japanese do

    before do
      @japanese = Language.create(:english => 'Japanese', :local => '日本語')
      @japanese.save!
    end

    describe '#locale' do
      it "should return Locale::Japanese" do
        @japanese.names.new.locale.should == Locale::Japanese
      end
    end

    describe '#normalize!' do

      it "should map R/L into wildcards" do
        @japanese.names.create(:latin => "Abcdefghijklmnopqrstuvwxyz").normalized.should == "Abcdefghijk_mnopq_stuvwxyz"
      end
    end

    describe '#permutations' do
      describe "with a name with no L/R" do
        it "should return an array containing the original name" do
          @japanese.names.create(:latin => "Izumi").permutations.should == [ "Izumi" ]
        end
      end
      
      describe "with a name containing R" do
        it "should return an array containing both L and R substituted" do
          @japanese.names.create(:latin => "Erina").permutations.should include("Erina", "Elina")
          @japanese.names.create(:latin => "Arila").permutations.should include("Arira", "Arila", "Alira", "Alila")
        end
      end
    end

    after do
      @japanese.destroy
    end
  end
end
