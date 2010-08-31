Feature: Authors and editors can create and edit content
In order to find a cross-cultural name for my baby
As a parent-to-be
I can search for them at baby names

Scenario: Find a name for a Japanese-Finnish girl
  Given the language "Japanese" exists
  And that there is "Japanese" name called "Erina"
  And the language "Finnish" exists
  And that there is "Finnish" name called "Elina"

  When I go to the home page
  And I select "Japanese" from "First language"
  And I select "Finnish" from "Second language"
  And I select "Girl" from "Gender"
  And I press "Search"

  Then the search results contain the following information:
    | Japanese | Finnish |
    | Erina    | Elina   |
