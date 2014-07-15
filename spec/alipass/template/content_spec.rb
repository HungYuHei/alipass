require 'spec_helper'

describe Alipass::Template::Content do
  it ".add" do
    params = {
      tpl_id: 'tpl_id',
      tpl_params: %Q({"title":"title","begin_at":"2014-11-11 00:11"}),
      recognition_type: '1',
      recognition_info: %Q({"partner_id":"partner_id","out_trade_no":"out_trade_no"})
    }

    json = Alipass::Template::Content.add(params)
    puts json
  end
end
