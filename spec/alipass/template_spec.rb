require 'spec_helper'

describe Alipass::Template do
  before do
    FakeWeb.register_uri(:post, 'https://openapi.alipay.com/gateway.do', body: body)
  end

  it ".add" do
    params = {
      logo: 'http://dn-dev.qbox.me/test/alipass-logo-test.png',
      strip: '',
      icon: '',
      content: pass_json
    }

    response = Alipass::Template.add(tpl_content: params.to_json)
    result = response['alipay_pass_tpl_add_response']['result']
    result.must_be_kind_of String

    json = JSON.parse(result)
    json['tpl_id'].wont_be_empty
  end

  let(:body) do
    {
      alipay_pass_tpl_add_response: {
        result: '{"tpl_id":"tpl_id","tpl_params":["title", "begin_at"]}',
        error_code: "SUCCESS",
        success: true
      },
      sign: "sign"
    }.to_json
  end

  let(:pass_json) do
    {
      evoucherInfo: {
        title: "$title$",
        type: "eventTicket",
        product: "movie",
        startDate: "$begin_at$",
        endDate: "$end_at$",
        operation: [
          {
            format: "qrcode",
            message: "$qr_value$",
            messageEncoding: "utf-8",
            altText: "$qr_tips$"
          },
          {
            message: {
              android_appid: "com.youyanchu.android",
              android_launch: "schemes://com.youyanchu.android",
              android_download: "http://youyanchu.com/l/app/android",
              ios_appid: "com.youyanchu.iphone.showtime",
              ios_launch: "youyanchuiphone://",
              ios_download: "http://youyanchu.com/l/app/ios"
            },
            format: "app",
            messageEncoding: "utf-8",
            altText: "$app_tips$"
          },
          {
            format: "url",
            message: "$perf_url$",
            messageEncoding: "utf-8",
            altText: "$web_tips$"
          }
        ],
        einfo: {
          logoText: "$title$",
          headFields: [{ key: "begin_at_date", label: "日期", value: "$begin_at_date$", type: "text" }],
          primaryFields: [{ key: "begin_at_time", label: "演出时间", value: "$begin_at_time$", type: "text" }],
          secondaryFields: [{ key: "scene", label: "场地", value: "$scene$", type: "map" }],
          auxiliaryFields: [
            { key: "number", label: "票号", value: "$number$", type: "text" },
            { key: "price", label: "金额", value: "$price$", type: "text" }
          ],
          backFields: []
        },
        locations: [
          {
            altitude: "",
            longitude: "$longitude$",
            latitude: "$latitude$",
            tel: "$tel$",
            addr: "$address$",
            relevantText: "$scene_name$"
          }
        ]
      }, # evoucherInfo

      merchant: { mname: "xxx有限公司", mtel: "123456789", minfo: "" },
      platform: { channelID: "$channel_id$", webServiceUrl: "$web_service_url$" },
      style: { backgroundColor: "$background_color$" },

      fileInfo: { formatVersion: "2", canShare: false, canBuy: false, serialNumber: "$serial_number$" },

      appInfo: {
        app: {
          android_appid: "com.youyanchu.android",
          android_launch: "schemes://com.youyanchu.android",
          android_download: "http://youyanchu.com/l/app/android",
          ios_appid: "com.youyanchu.iphone.showtime",
          ios_launch: "youyanchuiphone://",
          ios_download: "http://youyanchu.com/l/app/ios"
        },
        label: "有演出",
        message: "音乐演出神器"
      },

      source: "alipassprod",
      alipayVerify: []
    }
  end

end
