require 'spec_helper'

describe NamesController do
  before do
    @lang = Language.create(:english => 'Foo', :local => 'Bar')
  end

  it "should get index" do
    get :index, :language_id => @lang.id
    response.should be_success
    assigns[:names].should_not be_nil
  end

  it "should get new" do
    get :new, :language_id => @lang.id
    response.should be_success
  end

  it "should create name" do
    post :create, :name => { }, :language_id => @lang.id
    response.should redirect_to language_name_path(assigns[:language], assigns[:name])
  end

  describe "#show, edit, update, destroy" do
    before do
      @name = @lang.names.create(:latin => 'Foo')
      @name.save!
    end

    it "should show name" do
      get :show, :id => @name.id, :language_id => @lang.id
      response.should be_success
    end
    
    it "should get edit" do
      get :edit, :id => @name.id, :language_id => @lang.id
      response.should be_success
    end
    
    it "should update name" do
      pending
      put :update, :id => @name.id, :language_id => @lang.id, :name => { }
      response.should redirect_to language_name_path(assigns[:language], assigns[:name])
    end
    
    it "should destroy name" do
      delete :destroy, :id => @name.id, :language_id => @lang.id
      response.should redirect_to language_names_path(assigns[:language])
    end
  end
end
