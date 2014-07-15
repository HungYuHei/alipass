require "alipass/version"
require "alipass/template"
require "alipass/sign"

module Alipass
  class << self
    attr_accessor :app_id
    attr_accessor :private_key_file
  end
end
