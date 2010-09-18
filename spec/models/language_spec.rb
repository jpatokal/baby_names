require 'spec_helper'
describe Language do

  describe '.join_condition' do
    describe 'with two wildcardless languages' do
      before do
        @lang1 = Language.create(:english => 'Foo 1', :local => 'Bar 1', :wildcards => false)
        @lang2 = Language.create(:english => 'Foo 2', :local => 'Bar 2', :wildcards => false)
      end

      it 'should return a simple match' do
        @lang1.join_condition(@lang2).should == "names.normalized = n2.normalized"
      end
    end

    describe 'with one wildcard languages' do
      describe 'as argument' do
        before do
          @lang1 = Language.create(:english => 'Foo 1', :local => 'Bar 1', :wildcards => false)
          @lang2 = Language.create(:english => 'Foo 2', :local => 'Bar 2', :wildcards => true)
        end
        
        it 'should return a LIKE match on the argument' do
          @lang1.join_condition(@lang2).should == "names.normalized LIKE n2.normalized"
        end
      end

      describe 'as object' do
        before do
          @lang1 = Language.create(:english => 'Foo 1', :local => 'Bar 1', :wildcards => true)
          @lang2 = Language.create(:english => 'Foo 2', :local => 'Bar 2', :wildcards => false)
        end
        
        it 'should return a LIKE match on the object' do
          @lang1.join_condition(@lang2).should == "n2.normalized LIKE names.normalized"
        end
      end
    end

    describe 'with two wildcard languages' do
      it 'should do something sensible'
    end
  end
end
