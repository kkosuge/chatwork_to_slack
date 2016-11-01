module ChatworkToSlack
  module Filters
    class Picon
      def self.call(text, options)
        return text unless options[:users]

        text.scan(/(\[piconname:([\w]+)\])/).each do |picon|
          user = options[:users].find {|cw| cw[:chatwork_account_id] == picon[1].to_i }
          next unless user
          member =
            if user[:slack_name]
              "#{user[:chatwork_name]} ( @#{user[:slack_name]} )"
            else
              user[:chatwork_name]
            end
          text.gsub!(picon[0], member)
        end

        text.scan(/(\[picon:([\w]+)\])/).each do |picon|
          text.gsub!(picon[0], '')
        end
        text
      end
    end
  end
end
