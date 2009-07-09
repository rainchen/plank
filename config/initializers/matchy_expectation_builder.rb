if defined?(Matchy)
  module Matchy
    module ExpectationBuilder
      def self.build_expectation(match, exp, obj)
        return Matchy::Expectations::OperatorExpectation.new(obj, match) unless exp
        # bug fixed for wokring with rspec 1.2.6
        if !exp.nil? && exp.respond_to?(:matches?)
          return exp.matches?(obj).should == match
        else
            (exp.matches?(obj) != match) ? exp.fail!(match) : exp.pass!(match)
        end
      end
    end
  end

  # add RSpec matchers
   require 'simple_matcher'

  #   nil.should be_nil            # pass
  class ActiveSupport::TestCase
    custom_matcher :be_nil do |receiver, matcher, args|
      matcher.positive_failure_message = "Expected #{receiver} to be nil but it wasn't"
      matcher.negative_failure_message = "Expected #{receiver} not to be nil but it was"
      receiver.nil?
    end

    #  simple_matcher makes it easy for you to create your own custom matchers in just a few lines of code when you don’t need all the power of a completely custom matcher object. 
    # @link http://rspec.rubyforge.org/rspec/1.2.6/classes/Spec/Matchers.html#M000443
    def simple_matcher(description=nil, &match_block)
      SimpleMatcher.new(description, &match_block)
    end
  end

end
