Feature: basic movie flows for coverage
  As a movie buff
  I want the common pages/actions to work
  So that I can manage my movies

  Background: movies in database
    Given the following movies exist:
      | title        | rating | director     | release_date |
      | Star Wars    | PG     | George Lucas | 1977-05-25   |
      | Blade Runner | PG     | Ridley Scott | 1982-06-25   |

  # Exercises index rendering
  Scenario: see the movies list
    When I go to the home page
    Then I should see "Star Wars"
    And I should see "Blade Runner"

  # Exercises new + create happy path
  Scenario: create a new movie
    When I go to the new movie page
    And I fill in "Title" with "New Movie"
    And I select "PG" from "movie_rating"
    And I fill in "Director" with "Some One"
    And I select "2000" from "movie_release_date_1i"
    And I select "January" from "movie_release_date_2i"
    And I select "1" from "movie_release_date_3i"
    And I press "Save Changes"
    Then I should be on the home page
    And I should see "New Movie"

  # Exercises destroy
  Scenario: delete a movie
    Given I am on the details page for "Star Wars"
    When I press "Delete"
    Then I should be on the home page
    And I should not see "More about Star Wars"

  Scenario: edit a movie title (no-op update still executes update path)
    Given I am on the edit page for "Blade Runner"
    And I fill in "Title" with "Blade Runner"
    And I press "Update Movie Info"
    Then I should be on the details page for "Blade Runner"
    And I should see "Blade Runner"

  Scenario: visit new movie then cancel
    When I go to the new movie page
    And I follow "Cancel"
    Then I should be on the home page

  # Exercises edit view + Cancel link (renders edit; redirects back to index)
  Scenario: open edit then cancel
    Given I am on the edit page for "Blade Runner"
    When I follow "Cancel"
    Then I should be on the home page
    And I should see "Blade Runner"

  # Exercises show view + Back to movie list link (renders show; redirects to index)
  Scenario: view details then go back
    Given I am on the details page for "Blade Runner"
    When I follow "Back to movie list"
    Then I should be on the home page
    And I should see "Blade Runner"