require 'base64'

module Alipass
  module Sign
    def self.generate(params)
      private_key = OpenSSL::PKey::RSA.new(File.read(Alipass.private_key_file))
      digest = OpenSSL::Digest::SHA1.new
      to_sign = params.sort.map { |item| item.join('=') }.join('&')
      Base64.encode64(private_key.sign(digest, to_sign))
    end
  end
end
