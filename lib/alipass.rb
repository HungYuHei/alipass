require "alipass/version"
require "alipass/template"
require "alipass/sign"

module Alipass
  class << self
    attr_accessor :app_id, :private_key_file
  end
end
