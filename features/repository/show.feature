Feature: Show Repository
  In order to visualize the results of my repositories
  As a regular user
  I should see it's informations

  @kalibro_restart
  Scenario: With a ready processing
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project
    And I start to process that repository
    And I wait up for a ready processing
    When I visit the repository show page
    Then I should see the sample repository name
    And I should see "Address"
    And I should see "Configuration"
    And I should see "State"
    And I should see "Creation date"
    And I should see "LOADING time"
    And I should see "COLLECTING time"
    And I should see "ANALYZING time"
    And I should see "Metric"
    And I should see "Value"
    And I should see "Weight"
    And I should see "Threshold"

  @kalibro_restart
  Scenario: Just after start to process
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project
    And I start to process that repository
    When I visit the repository show page
    Then I should see the sample repository name
    And I should see "Address"
    And I should see "Configuration"
    And I should see "State"
    And I should see "Creation date"
    And I should not see Metric
    And I should not see Value
    And I should not see Weight
    And I should not see Threshold

    @kalibro_restart
    Scenario: Should show modules title
      Given I am a regular user 
      And I am signed in
      And I have a sample project
      And I have a sample configuration with native metrics
      And I have a sample repository within the sample project
      And I start to process that repository
      And I wait up for a ready processing
      When I visit the repository show page
      Then I should see "Source Tree"

    @kalibro_restart
    Scenario: Should show modules directories root when the process has been finished
      Given I am a regular user
      And I am signed in
      And I have a sample project
      And I have a sample configuration with native metrics
      And I have a sample repository within the sample project
      And I start to process that repository
      And I wait up for a ready processing
      And I ask for the last ready processing of the given repository
      And I ask for the module result of the given processing
      When I visit the repository show page
      Then I should see the given module result

  @kalibro_restart
  Scenario: Should show childrens of root when the process has been finished
      Given I am a regular user
      And I am signed in
      And I have a sample project
      And I have a sample configuration with native metrics
      And I have a sample repository within the sample project
      And I start to process that repository
      And I wait up for a ready processing
      And I ask for the last ready processing of the given repository
      And I ask for the module result of the given processing
      When I visit the repository show page
      Then I should see the given module result