require 'json'
require 'rest_client'

module Alipass
  module Template
    module Content

      # REQUIRED_PARAMS = [
      #   :method, :timestamp, :app_id, :version, :sign, :sign_type,
      #   :tpl_id, :tpl_params, :recognition_type, :recognition_info
      # ]

      def self.add(params)
        gateway = 'https://openapi.alipay.com/gateway.do'
        params = {
          method: 'alipay.pass.tpl.content.add',
          timestamp: Time.now.strftime('%F %T'),
          format: 'json',
          app_id: Alipass.app_id,
          sign_type: 'RSA',
          version: '1.0'
        }.merge(params)

        params[:tpl_params].encode!('GBK', { invalid: :replace, undef: :replace, replace: '' })

        sign = Sign.generate(params)
        params.merge!(sign: sign)

        RestClient.post(gateway, params) do |response|
          JSON.parse(response.body)
        end
      end

    end
  end
end
