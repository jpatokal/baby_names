require 'spec_helper'

module Locale
  describe Finnish do

    describe '#normalize!' do

      it "should map J into Y" do
        name = Name.create_with_locale(Locale::Finnish, :latin => "Jani")
        name.normalized.should == "Yani"
      end
    end

  end

end
