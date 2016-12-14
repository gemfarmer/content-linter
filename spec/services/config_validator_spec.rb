require 'rails_helper'

describe ConfigValidator do
  context 'config file is an invalid format' do
    it "raises an error if the first key is not 'config'" do
      rules = { "something" => "wrong" }

      expect { ConfigValidator.new(rules).validate }.
        to raise_error RuntimeError, "Invalid config. Top level config key missing"
    end

    it "raises an error if the value of 'config' is not an Array" do
      rules = { "config" => "wrong" }

      expect { ConfigValidator.new(rules).validate }.
        to raise_error RuntimeError, "Invalid config. Value of 'config' should be an Array"
    end

    it "raises an error if the 'config' Array does not has rules" do
      rules = { "config" => [] }

      expect { ConfigValidator.new(rules).validate }.
        to raise_error RuntimeError, "Invalid config. Their are no rules in the configuration"
    end

    it "does not raise an error if the config is valid" do
      rules = {
        "config" => [
          {
            "18F-er" => {
              "replace" => ["18F team members", "18F staffers"],
              "reason" => "'F-er' can imply profanity"
            }
          }
        ]
      }

      expect { ConfigValidator.new(rules).validate }.to_not raise_error
    end
  end
end
