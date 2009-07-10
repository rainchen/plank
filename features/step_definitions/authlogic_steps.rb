# General

Then /^I should see error messages$/ do
  assert_match /error(s)? prohibited/m, response.body
end

# Database

Given /^no user exists with an email of "(.*)"$/ do |email|
  assert_nil User.find_by_email(email)
end

Given /^I signed up with "(.*)\/(.*)"$/ do |email, password|
  user = Factory :user,
    :email                 => email,
    :password              => password,
    :password_confirmation => password
end

Given /^I am signed up and confirmed as "(.*)\/(.*)"$/ do |email, password|
  user = Factory :user,
    :email                 => email,
    :password              => password,
    :password_confirmation => password,
    :active  => true
end

Given /^I am a confirmed user and signed in as "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  Given %{I am signed up and confirmed as "#{email}/#{password}"}
  And %{I sign in as "#{email}/#{password}"}
  @current_user ||= UserSession.find.user
end

# Session

Then /^I should be signed in$/ do
   UserSession.find.should_not be_nil
end

Then /^I should not be signed in$/ do
  UserSession.find.should be_nil
end

When /^session is cleared$/ do
 UserSession.find.try(:destroy)
end

# Emails

Then /^an activation "(.*)" message should be sent to "(.*)"$/ do |title,email|
  user = User.find_by_email(email)
  sent = ActionMailer::Base.deliveries.first
  assert_equal [user.email], sent.to
  sent.subject.should contain(title)
  sent.body.should contain(register_url(user.perishable_token))
end

When /^I follow the activation link sent to "(.*)"$/ do |email|
  user = User.find_by_email(email)
  visit register_url(user.perishable_token)
end

Then /^a password reset message "(.*)" should be sent to "(.*)"$/ do |subject, email|
  user = User.find_by_email(email)
  sent = ActionMailer::Base.deliveries.first
  assert_equal [user.email], sent.to
  sent.subject.should  contain(subject)
  sent.body.should contain(edit_password_reset_url(user.perishable_token))
end

When /^I follow the password reset link sent to "(.*)"$/ do |email|
  user = User.find_by_email(email)
  visit  edit_password_reset_url(user.perishable_token)
end

When /^I try to change the password of "(.*)" without token$/ do |email|
  user = User.find_by_email(email)
  visit edit_user_password_path(:user_id => user)
end

Then /^I should be forbidden$/ do
  assert_response :forbidden
end


# Actions

When /^I sign in( with "remember me")? as "(.*)\/(.*)"$/ do |remember, email, password|
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I check "user_session[remember_me]"} if remember
  And %{I press "Sign In"}
end

When /^I sign out$/ do
  visit logout_path
end

When /^I request password reset link to be sent to "(.*)"$/ do |email|
  When %{I go to the password reset request page}
  And %{I fill in "email" with "#{email}"}
  And %{I press "Reset my password"}
end

When /^I update my password with "(.*)\/(.*)"$/ do |password, confirmation|
  And %{I fill in "Password" with "#{password}"}
  And %{I fill in "Password confirmation" with "#{confirmation}"}
  And %{I press "Update my password and log me in"}
end

When /^I return next time$/ do
  When %{session is cleared}
  And %{I go to the homepage}
end
