require 'alipass/template/content'

module Alipass
  module Template
    # REQUIRED_PARAMS = [ :method, :timestamp, :app_id, :version, :sign, :sign_type, :tpl_content]

    def self.add(params)
      gateway = 'https://openapi.alipay.com/gateway.do'
      params = {
        method: 'alipay.pass.tpl.add',
        timestamp: Time.now.strftime('%F %T'),
        format: 'json',
        app_id: Alipass.app_id,
        version: '1.0',
        sign_type: 'RSA'
      }.merge(params)

      params[:tpl_content] = params[:tpl_content].encode('GBK') if params[:tpl_content]

      sign = Sign.generate(params)
      params.merge!(sign: sign)

      RestClient.post(gateway, params) do |response|
        JSON.parse(response.body)
      end
    end

  end
end
