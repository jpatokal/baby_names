Given /^the language "([^"]*)" exists$/ do |language_name|
  language = Language.find_or_create_by_english(language_name)
  if language.new_record?
    language.local = "Local"
    language.save
  end
end

Given /^that there is "([^"]*)" name called "([^"]*)"$/ do |language_name, name_string|
  language = Language.find_by_english(language_name)
  name = language.names.find_or_create_by_latin(name_string)
  name.save if name.new_record?
end

Then /^the search results contain the following information:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end
