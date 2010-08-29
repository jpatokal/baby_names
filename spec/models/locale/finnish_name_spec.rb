require 'spec_helper'

module Locale
  describe FinnishName do

    describe '#normalize!' do

      it "should map J into Y" do
        name = FinnishName.create(:latin => "Jani").normalize!
        name.normalized.should == "Yani"
      end
    end

  end

end
