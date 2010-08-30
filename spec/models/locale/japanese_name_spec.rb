require 'spec_helper'

module Locale
  describe JapaneseName do

    describe '#normalize!' do

      it "should map R/L into wildcards" do
        name = JapaneseName.create(:latin => "Abcdefghijklmnopqrstuvwxyz").normalize!
        name.normalized.should == "Abcdefghijk_mnopq_stuvwxyz"
      end
    end

    describe '#permutations' do
      describe "with a name with no L/R" do
        it "should return an array containing the original name" do
          JapaneseName.create(:latin => "Izumi").permutations.should == [ "Izumi" ]
        end
      end
      
      describe "with a name containing R" do
        it "should return an array containing both L and R substituted" do
          JapaneseName.create(:latin => "Erina").permutations.should include("Erina", "Elina")
          JapaneseName.create(:latin => "Arila").permutations.should include("Arira", "Arila", "Alira", "Alila")
        end
      end
    end

  end
end
