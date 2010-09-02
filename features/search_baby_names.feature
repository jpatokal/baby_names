Feature: Authors and editors can create and edit content
In order to find a cross-cultural name for my baby
As a parent-to-be
I can search for them at baby names

Scenario: Find a name for a Japanese-Finnish girl with an exact match
  Given the language "Japanese" exists
  And that there is a "Japanese" name for a "girl" written "マリア" and read "Maria"
  And the language "Finnish" exists
  And that there is a "Finnish" name for a "girl" called "Maria"

  When I go to the home page
  And I select "girl" from "gender_id"
  And I select "Japanese" from "language[first]"
  And I select "Finnish" from "language[second]"
  And I press "Search"

  Then the search results contain the following information:
    | Japanese-script | Japanese-latin | Finnish-script | Finnish-latin |
    | マリア           | Maria          | Maria          | Maria         |

Scenario: Find a name for a Japanese-Finnish girl with a fuzzy match
  Given the language "Japanese" exists
  And that there is a "Japanese" name for a "girl" written "えりな" and read "Erina"
  And the language "Finnish" exists
  And that there is a "Finnish" name for a "girl" called "Elina"

  When I go to the home page
  And I select "girl" from "gender_id"
  And I select "Japanese" from "language[first]"
  And I select "Finnish" from "language[second]"
  And I press "Search"

  Then the search results contain the following information:
    | Japanese-script | Japanese-latin | Finnish-script | Finnish-latin |
    | えりな           | Erina          | Elina          | Elina         |
