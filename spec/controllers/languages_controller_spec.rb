require 'spec_helper'
require 'rr'

describe LanguagesController do
  it "should get index" do
    get :index
    response.should be_success
    assigns[:languages].should_not be_nil
  end

  it "should get new" do
    get :new
    response.should be_success
  end

  it "should create language" do
    post :create, :language => { :english => "Foo", :local => "Bar" }
    response.should redirect_to language_path(assigns[:language])
  end

  describe "#show, edit, update, destroy" do
    before do
      @lang = Language.create(:english => 'Foo', :local => 'Bar')
    end

    it "should show language" do
      get :show, :id => @lang.id
      response.should be_success
    end

    it "should get edit" do
      get :edit, :id => @lang.id
      response.should be_success
    end
    
    it "should update language" do
      put :update, :id => @lang.id, :language => { }
      response.should redirect_to language_path(assigns[:language])
    end
    
    it "should destroy language" do
      delete :destroy, :id => @lang.id
      response.should redirect_to languages_path
    end
  end
end
