require 'spec_helper'

module Locale
  describe JapaneseName do

    describe '#==' do

      it "should match if the normalized names are exactly the same" do
        JapaneseName.create(:normalized => "Erina").should == Name.create(:normalized => "Erina")
      end

      it "should match if the normalized names contain R/L for wildcards" do
        JapaneseName.create(:normalized => "E_ina").should == Name.create(:normalized => "Erina")
        JapaneseName.create(:normalized => "E_ina").should == Name.create(:normalized => "Elina")
      end

      it "should not match if the normalized names contains other characters for wildcards" do
        JapaneseName.create(:normalized => "E_ina").should_not == Name.create(:normalized => "Exina")
      end
    end

  end

end
