module ChatworkToSlack
  module Filters
    class Quote
      attr_reader :users, :chatwork_users
      def initialize(users)
        @users = users
      end

      def self.call(text, options)
        new(options[:users]).call(text)
      end

      def call(text)
        qts = text.scan(/(\[qt\].+\[\/qt\])/m)
        return text if qts.empty?

        quotes =
          if text.scan(/\[qt\]/m).size > 1
            text.split(/\[\/qt\]/).map{|t| "#{t}[/qt]".scan(/(\[qt\].+\[\/qt\])/m)[0]}.compact.map(&:first)
          else
            qts.first
          end

        result = text
        quotes.each do |quote|
          result.gsub!(quote,qtmeta(quote).split("\n").map{|t| ">#{t}"}.join("\n").gsub(/\[\/?qt\]/,''))
        end
        result
      end

      private

      def qtmeta(text)
        q = text.scan(/\[qtmeta.+\]/).first
        qh = q.scan(/([\w]+)=([\d]+)/).to_h
        time = Time.at(qh['time'].to_i)
        user = users.find {|cw| cw[:chatwork_account_id] == qh['aid'].to_i }
        return text unless user
        text.gsub(q, "@#{user[:slack_name]}: #{time}\n")
      end
    end
  end
end
