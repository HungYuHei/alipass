require 'spec_helper'

describe Alipass::Template::Content do
  let(:body) do
    %Q({"alipay_pass_tpl_add_response":{"success":"T","error_code":"SUCCESS","biz_result":{"serialNumber":"123555123","passId":"32770","result":"SUCCESS"}}})
  end

  before do
    FakeWeb.register_uri(:post, 'https://openapi.alipay.com/gateway.do', body: body)
  end

  it ".add" do
    params = {
      tpl_id: 'tpl_id',
      tpl_params: %Q({"title":"title","begin_at":"2014-11-11 00:11"}),
      recognition_type: '1',
      recognition_info: %Q({"partner_id":"partner_id","out_trade_no":"out_trade_no"})
    }

    json = Alipass::Template::Content.add(params)
    json['alipay_pass_tpl_add_response']['biz_result']['result'].must_equal 'SUCCESS'
  end
end
