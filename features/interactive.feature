Feature: Interactive process control

  In order to test interactive command line applications
  As a developer using Cucumber
  I want to use the interactive session steps

  Scenario: Running ruby interactively
    Given a file named "echo.rb" with:
      """
      while res = gets.chomp
        break if res == "quit"
        puts res.reverse
      end
      """
    When I run `ruby echo.rb` interactively
    And I type "hello, world"
    And I type "quit"
    Then the output should contain:
      """
      dlrow ,olleh
      """

  Scenario: Running a native binary interactively
    When I run `bc -q` interactively
    And I type "4 + 3"
    And I type "quit"
    Then the output should contain:
      """
      7
      """

  Scenario: Stop processes before checking for filesystem changes 
    See: http://github.com/aslakhellesoy/aruba/issues#issue/17 for context

    Given a directory named "rename_me"
    When I run `mv rename_me renamed` interactively
    Then a directory named "renamed" should exist
    And a directory named "rename_me" should not exist

  Scenario: Stop a process under interaction
    When I run `ruby` interactively
    And I stop the running process
    Then the exit status should be 15
