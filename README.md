# Alipass

支付宝卡券 https://alipass.alipay.com/index.htm  
[官方文档](https://openhome.alipay.com/doc/docIndex.htm?url=https://openhome.alipay.com/doc/viewKbDoc.htm?key=236698&type=cat)

## Installation

Add this line to your application's Gemfile:

    gem 'alipass'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alipass

## Usage

### Config

```ruby
Alipass.app_id           = 'APP_ID'
Alipass.private_key_file = '/PATH/TO/YOUR/RSA/PRIVATE_KEY_FILE'
```

### 新建模版

```ruby
Alipass::Template.add(
  tpl_content: "" # 支付宝pass模版内容
)
```

`tpl_content` 参数比较复杂，请参考 [测试代码](https://github.com/HungYuHei/alipass/blob/master/spec/alipass/template_spec.rb) 和 [数据格式说明](https://openhome.alipay.com/doc/docIndex.htm?url=https://openhome.alipay.com/doc/viewKbDoc.htm?key=236698_261970&type=info)

### 模版方式添加卡券

```ruby
Alipass::Template::Content.add(
  tpl_id: 'tpl_id',
  tpl_params: %Q({"title":"title","begin_at":"2014-11-11 00:11"}),
  recognition_type: '1',
  recognition_info: %Q({"partner_id":"partner_id","out_trade_no":"out_trade_no"})
)
```

### Run test

```
# Edit spec/spec_helper.rb
rake test
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
