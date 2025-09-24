Feature: layout and navigation coverage
  As a movie buff
  I want the common navigation and flash to render
  So that the app’s layout and links work

  Background: movies in database
    Given the following movies exist:
      | title        | rating | director     | release_date |
      | Star Wars    | PG     | George Lucas | 1977-05-25   |
      | Alien        | R      |              | 1979-05-25   |

  # Triggers the sad path to show the flash in the layout,
  # then exercises the index and new page via nav links.
  Scenario: see flash in layout and navigate via links
    Given I am on the details page for "Alien"
    When I follow "Find Movies With Same Director"
    Then I should be on the home page
    And I should see "'Alien' has no director info"

    # Hit the "Add new movie" link on index (exercises layout + index link)
    When I follow "Add new movie"
    Then I should be on the new movie page

    # Hit the Cancel link on the new page (exercises redirect back to index)
    When I follow "Cancel"
    Then I should be on the home page

  # Exercise the "Back to movie list" link on the show page (layout + show)
  Scenario: back to list from details
    Given I am on the details page for "Star Wars"
    When I follow "Back to movie list"
    Then I should be on the home page
    And I should see "Star Wars"
