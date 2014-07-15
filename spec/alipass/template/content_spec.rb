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
      tpl_params: tpl_params.to_json,
      recognition_type: '1',
      recognition_info: %Q({"partner_id":"partner_id","out_trade_no":"out_trade_no"})
    }

    json = Alipass::Template::Content.add(params)
    json['alipay_pass_tpl_add_response']['biz_result']['result'].must_equal 'SUCCESS'
  end

  def tpl_params
    {
      title: 'xtitlexxxxxx',
      #startDate: '2014-07-16 20:20',
      #endDate: '2014-07-17 23:20',
      begin_at_date: "2014-07-15",
      begin_at_time: "20:20",
      scene: '场地名',
      number: '110',
      price: '0.02',
      longitude: '116.407413',
      latitude: '39.904214',
      tel: '123456',
      address: '场地名',
      scene_name: 'SD',
      qr_value: '123|321|123',
      qr_tips: '刷这里啊',
      app_tips: '启动 APP',
      perf_url: 'http://youyanchu.com',
      web_tips: '打开网页',
      serial_number: 'serial_number',
      channel_id: 'channel_id',
      web_service_url: 'http://youyanchu.com',
      background_color: 'rgb(165,22,40)'
    }
  end
end
