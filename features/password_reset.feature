Feature: Password reset
  In order to sign in even if user forgot their password
  A user
  Should be able to reset it
  
    Scenario: User is not signed up
      Given no user exists with an email of "email@person.com"
      When I request password reset link to be sent to "email@person.com"
      Then I should see "No user was found with that email address"
  
    Scenario: User is signed up and requests password reset
      Given I signed up with "email@person.com/password"
      When I request password reset link to be sent to "email@person.com"
      Then I should see "Instructions to reset your password have been emailed to you"
      And a password reset message "Password Reset Instructions" should be sent to "email@person.com"
    
    Scenario: User is signed up updated his password and types wrong confirmation
      Given I signed up with "email@person.com/password"
      When I follow the password reset link sent to "email@person.com"
      And I update my password with "newpassword/wrongconfirmation"
      Then I should see error messages
      And I should not be signed in

    Scenario: User is signed up and updates his password
      Given I am signed up and confirmed as "email@person.com/password"
      When I follow the password reset link sent to "email@person.com"
      And I update my password with "newpassword/newpassword"
      Then I should be signed in
      When I sign out
      And I sign in as "email@person.com/newpassword"
      Then I should be signed in

    Scenario: User is signed up and reset password by following the password reset instructions
      Given I am signed up and confirmed as "email@person.com/password"
      When I sign out
      Then I should not be signed in
      When I go to the password reset request page
      And I fill in "email" with "email@person.com"
      And I press "Reset my password"
      When I open my email box with "email@person.com"
      Then I should receive an email
      When I open the email
      Then I should see "reset your password" in the email
      When I follow "reset" in the email
      Then I should see "Change My Password"
      And I fill in "Password" with "newpassword"
      And I fill in "Password Confirmation" with "newpassword"
      And I press "Update my password and log me in"
      Then I should see "Password successfully updated"
      Then I should be signed in