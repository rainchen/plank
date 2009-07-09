# SimpleMatcher from Spec::Matchers::SimpleMatcher
# @link http://rspec.rubyforge.org/rspec/1.2.6/classes/Spec/Matchers/SimpleMatcher.html
class SimpleMatcher
  attr_writer :failure_message, :negative_failure_message, :description

  def initialize(description, &match_block)
    @description = description
    @match_block = match_block
    @failure_message = @negative_failure_message = nil
  end

  def matches?(given)
    @given = given
    case @match_block.arity
    when 2
      @match_block.call(@given, self)
    else
      @match_block.call(@given)
    end
  end

  def description
    @description || explanation
  end

  def failure_message_for_should
    @failure_message || (@description.nil? ? explanation : %[expected #{@description.inspect} but got #{@given.inspect}])
  end

  def failure_message_for_should_not
    @negative_failure_message || (@description.nil? ? explanation : %[expected not to get #{@description.inspect}, but got #{@given.inspect}])
  end

  def explanation
    "No description provided. See RDoc for simple_matcher()"
  end
end
