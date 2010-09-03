require 'spec_helper'

module Locale
  describe Japanese do

    describe '#normalize!' do

      it "should map R/L into wildcards" do
        Name.create_with_locale(Locale::Japanese, :latin => "Abcdefghijklmnopqrstuvwxyz").normalized.should == "Abcdefghijk_mnopq_stuvwxyz"
      end
    end

    describe '#permutations' do
      describe "with a name with no L/R" do
        it "should return an array containing the original name" do
          Name.create_with_locale(Locale::Japanese, :latin => "Izumi").permutations.should == [ "Izumi" ]
        end
      end
      
      describe "with a name containing R" do
        it "should return an array containing both L and R substituted" do
          Name.create_with_locale(Locale::Japanese, :latin => "Erina").permutations.should include("Erina", "Elina")
          Name.create_with_locale(Locale::Japanese, :latin => "Arila").permutations.should include("Arira", "Arila", "Alira", "Alila")
        end
      end
    end

  end
end
