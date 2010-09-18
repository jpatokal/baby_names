Given /^the "([^"]*)" language "([^"]*)" exists$/ do |type, language_name|
  language = Language.find_or_create_by_english(language_name)
  language.local = "Local"
  language.wildcards = (type == "wildcard")
  language.save!
end

Given /^that there is a "([^"]*)" name for a "([^"]*)" called "([^"]*)"$/ do |language_name, gender, name|
  Given "that there is a \"#{language_name}\" name for a \"#{gender}\" written \"#{name}\" and read \"#{name}\""
end
  
Given /^that there is a "([^"]*)" name for a "([^"]*)" written "([^"]*)" and read "([^"]*)"$/ do |language_name, gender, script, latin|
  language = Language.find_by_english(language_name)
  language.names.create(:latin => latin, :gender => gender, :script => script).save!
end

Then /^the search results contain the following information:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.rows.each do |row|
    row.each do |column|
      Then "I should see \"#{column}\""
    end
  end
end

Then /^the search results do not contain the following information:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.rows.each do |row|
    row.each do |column|
      Then "I should not see \"#{column}\""
    end
  end
end
