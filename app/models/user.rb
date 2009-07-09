class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field :email
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end

  def active?
    active
  end

  # override Authlogic::ActsAsAuthentic::SessionMaintenance::Methods:update_sessions?
  # @update_sessions as a switch for forcing to update sessions
  def update_sessions?
    @update_sessions ||= false
    @update_sessions || super
  end

  def activate!
    self.active = true
    @update_sessions = true # auto logged in after activated
    save
  end
  
end  