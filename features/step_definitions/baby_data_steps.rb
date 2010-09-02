Given /^the language "([^"]*)" exists$/ do |language_name|
  language = Language.find_or_create_by_english(language_name)
  if language.new_record?
    language.local = "Local"
    language.save!
  end
end

Given /^that there is a "([^"]*)" name for a "([^"]*)" called "([^"]*)"$/ do |language_name, gender, name|
  Given "that there is a \"#{language_name}\" name for a \"#{gender}\" written \"#{name}\" and read \"#{name}\""
end
  
Given /^that there is a "([^"]*)" name for a "([^"]*)" written "([^"]*)" and read "([^"]*)"$/ do |language_name, gender, script, latin|
  language = Language.find_by_english(language_name)
  name = language.names.find_or_create_by_latin(latin)
  name.script = script
  name.save! if name.new_record?
end

Then /^the search results contain the following information:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.rows.each do |row|
    row.each do |column|
      Then "I should see \"#{column}\""
    end
  end
end
