require 'alipass/template/content'

module Alipass
  module Template

    # REQUIRED_PARAMS = [
    #   :method, :timestamp, :app_id, :version, :sign, :sign_type,
    #   :tpl_content, :unique_id
    # ]

    def self.add(params)
      gateway = 'https://openapi.alipay.com/gateway.do'
      params = {
        method: 'alipay.pass.tpl.add',
        timestamp: Time.now.strftime('%F %T'),
        format: 'json',
        app_id: Alipass.app_id,
        version: '1.0',
        unique_id: SecureRandom.hex,
        sign_type: 'RSA'
      }.merge(params)

      params[:tpl_content].encode!('GBK', { invalid: :replace, undef: :replace, replace: '' })

      sign = Sign.generate(params)
      params.merge!(sign: sign)

      RestClient.post(gateway, params) do |response|
        JSON.parse(response.body)
      end
    end

  end
end
