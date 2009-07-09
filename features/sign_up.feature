Feature: Sign up
  In order to get access to protected sections of the site
  A user
  Should be able to sign up
  
    Scenario: User signs up with invalid data
      When I go to the sign up page
      And I fill in "Email" with "invalidemail"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with ""
      And I press "Submit"
      Then I should see error messages
      
    Scenario: User signs up with valid data
      When I go to the sign up page
      And I fill in "Email" with "email@person.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I press "Submit"
      Then I should see "activation instructions"
      And an activation "Activation Instructions" message should be sent to "email@person.com"

    Scenario: User confirms his account
      Given I signed up with "email@person.com/password"
      When I follow the activation link sent to "email@person.com"
      Then I should see "Your account has been activated."
      And I should be signed in

    Scenario: User sigened up and confirms his account by following the activation email
      When I go to the sign up page
      And I fill in "Email" with "email@person.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I press "Submit"
      When I open my email box with "email@person.com"
      Then I should receive an email
      When I open the email
      Then I should see "to activate your account" in the email
      When I follow "register" in the email
      Then I should see "Your account has been activated."
      And I should be signed in
      When I open my email box with "email@person.com"
      Then I should receive an email
      When I open the email
      Then I should see "Your account has been activated."