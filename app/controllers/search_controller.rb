class SearchController < ApplicationController
  def search
    @first = Language.find(params[:language][:first])
    @second = Language.find(params[:language][:second])
    @gender = params[:gender][:id]

    @results = []
    first_names = @first.names.find_all_by_gender([@gender, 'U'])
    second_names = @second.names.find_all_by_gender([@gender, 'U'])
    first_names.each do |name1|
      name2 = second_names.find {|name| name1 == name}
      if name2
        @results << [name1, name2]
      end
    end
  end
end
