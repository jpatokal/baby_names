class SearchController < ApplicationController
  def search
    @first = Language.find(params[:language][:first])
    @second = Language.find(params[:language][:second])
    @gender = params[:gender][:id]

    @results = []
    Name.all(:select    => "names.*, n2.id AS id2",
             :joins     => "JOIN names AS n2 
                              ON n2.normalized LIKE names.normalized AND n2.id != names.id",
             :conditions => ["names.language_id=? AND n2.language_id=? AND names.gender IN (?, 'U') AND n2.gender IN (?, 'U')",
                             @first.id, @second.id, @gender, @gender]
             ).each do |name|
      name2 = Name.find(name.id2)
      @results << [ name, name2 ] if name == name2
    end
  end
end
