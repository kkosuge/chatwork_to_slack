module ChatWorkToSlack
  module Filters
    class Reply
      attr_reader :users
      def initialize(users)
        @users = users
      end

      def self.call(text, options)
        new(options[:users]).call(text)
      end

      def call(text)
        replace_reply(replace_to(text))
      end

      def replace_to(text)
        if data = text.match(/(\[To:([\d]+)\](?:[\w\s]+さん)?)/)
          to_text = data[0]
          account_id = data[2]
          user = users.find {|cw| cw[:chatwork_account_id] == account_id.to_i }

          if !user || !user[:slack_name]
            return replace_to(text.gsub(to_text, to_text.gsub(/\[/, '(').gsub(/\]/, ')')))
          end

          replace_to(text.gsub(to_text, "@#{user[:slack_name]}"))
        else
          text
        end
      end

      def replace_reply(text)
        if data = text.match(/\[rp[\s\w\-=]+\](?:[\w\s]+さん)?/)
          to_text = data[0]
          account_id = to_text.match(/aid=([\d]+)/)[1]
          user = users.find {|cw| cw[:chatwork_account_id] == account_id.to_i }

          if !user || !user[:slack_name]
            return replace_reply(text.gsub(to_text, to_text.gsub(/\[/, '(').gsub(/\]/, ')')))
          end

          replace_reply(text.gsub(to_text, "@#{user[:slack_name]}"))
        else
          text
        end
      end
    end
  end
end
