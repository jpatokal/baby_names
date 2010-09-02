class NamesController < ApplicationController
  before_filter :default_language

  def index
    @language = Language.find(params[:language_id])
    @names = @language.names
  end

  def show
    @language = Language.find(params[:language_id])
    @name = @language.names.find(params[:id])
  end

  def new
    @language = Language.find(params[:language_id])
    @name = @language.names.build
  end

  def create
    @language = Language.find(params[:language_id])
    @name = @language.names.build(params[:name])
    @name.save!
    redirect_to language_name_url(@language, @name)
  end

  def edit
    @language = Language.find(params[:language_id])
    @name = @language.names.find(params[:id])
  end

  def update
    @language = Language.find(params[:language_id])
    @name = Name.find(params[:id])
    if @name.update_attributes(params[:name])
      redirect_to language_name_url(@language, @name)
    else
      render :action => "edit"
    end
  end

  def destroy
    @language = Language.find(params[:language_id])
    @name = Name.find(params[:id])
    @name.destroy
    respond_to do |format|
      format.html { redirect_to language_names_path(@language) }
      format.xml { head :ok }
    end
  end

  private
  
  def default_language
    params[:language_id] = 1 unless params[:language_id]
  end

end
