class SearchController < ApplicationController
  def search
    @first = Language.find(params[:language][:first])
    @second = Language.find(params[:language][:second])

    @results = []
    @first.locale_names.each do |name1|
      @second.locale_names.each do |name2|
        @results << [name1, name2] if name1 == name2
      end
    end
  end
end
