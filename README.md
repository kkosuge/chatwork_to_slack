# ChatWorkToSlack

ChatWork（chatwork.com）のデータを Slack の Import CSV 形式に変換するツール

## Usage

CSV ファイルのテンプレートを作成

```
./bin/chatwork_to_slack --generate-template -k chatwork_api_key
```

ChatWork からデータをダウンロードして Slack 形式に変換

```
./bin/chatwork_to_slack -i example@example.co.jp -p your_password -x chatwork_room_id -c slack_channel_name
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kkosuge/chatwork_to_slack.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
