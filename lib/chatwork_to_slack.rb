require "chatwork_to_slack/version"
require "chatwork_to_slack/message"
require "chatwork_to_slack/importer"
require "find"
require "csv"

module ChatworkToSlack
  class Client
    attr_reader :room_id, :channel, :workdir, :chatwork_csv_path, :users, :chatwork_api_key

    def initialize(args)
      @room_id = args[:room_id]
      @channel = args[:channel]
      @workdir = args[:workdir]
      @users = args[:users]
      @chatwork_csv_path = args[:chatwork_csv_path]
      @chatwork_api_key = args[:chatwork_api_key]
    end

    def to_csv
      invalid_users.each do |name|
        puts "[WARN] #{name} is not valid slack username"
      end

      CSV.generate do |csv|
        slack_messages.each do |slack_message|
          csv << slack_message
        end
      end
    end

    def generate_template
      CSV.generate do |csv|
        csv << ['chatwork_account_id', 'chatwork_name', 'slack_name']
        chatwork_users.each do |u|
          csv << [u['account_id'], u['name'], u['chatwork_id']]
        end
      end
    end

    private

    def chatwork_users
      @chatwork_users ||= ->{
        return [] unless chatwork_api_key
        ChatWork.api_key = chatwork_api_key
        ChatWork::Contacts.get.push(ChatWork::Me.get)
      }.call
    end

    def channel
      @channel
    end

    def chatwork_messages
      CSV.read(chatwork_csv_path)
    end

    def invalid_users
      slack_messages.map{|m| m[2]}.uniq.reject{|u| u.gsub(/[0-9]/,'').match(/[\w\.\-]+/)}
    end

    def valid_messages
      chatwork_messages.reject do |message|
        message[2] == '[deleted]'
      end
    end

    def messages
      valid_messages.map do |message|
        Message.new(
          message: message,
          users: users,
          channel: channel
        ).to_slack
      end
    end

    def slack_messages
      messages.sort{|a, b| a[0] <=> b[0]}
    end
  end
end
