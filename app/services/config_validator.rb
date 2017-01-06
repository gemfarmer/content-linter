require 'pry'
require 'yaml'
require 'json'

class ConfigValidator

  def initialize(rules)
    @rules = rules
  end

  def validate
    validate_rules_config
    validate_rules_config_array
    validate_rules_config_array_contents
  end

  private

  def validate_rules_config
    raise "Invalid config. Top level config key missing" unless rules['config']
  end

  def validate_rules_config_array
    raise "Invalid config. Value of 'config' should be an Array" unless rules['config'].is_a? Array
  end

  def validate_rules_config_array_contents
    raise "Invalid config. Their are no rules in the configuration" unless rules['config'].any?
  end

  attr_reader :rules
end
