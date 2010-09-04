require 'spec_helper'

module Locale
  describe Finnish do

    before do
      @finnish = Language.create(:english => 'Finnish', :local => 'Suomi')
      @finnish.save!
    end

    describe '#locale' do
      it "should return Locale::Finnish" do
        @finnish.names.new.locale.should == Locale::Finnish
      end
    end

    describe '#normalize!' do

      it "should map J into Y" do
        name = @finnish.names.create(:latin => "Jani")
        name.normalized.should == "Yani"
      end
    end

    after do
      @finnish.destroy
    end
  end

end
