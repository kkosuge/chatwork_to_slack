module ChatWorkToSlack
  module Filters
    class Pre
      def self.call(text, options)
        title_regexp = /(\[info\](\[title\]([\p{Hiragana}\p{Katakana}\p{Han}。、\w\s　]+)\[\/title\]))/
        text.scan(title_regexp).each do |title|
          text.gsub!(title[0], "*#{title[2]}*\n#{title[0]}")
          text.gsub!(title[1], '')
        end
        text
          .gsub(/\[code\]/, "```")
          .gsub(/\[\/code\]/, "```")
          .gsub(/\[info\]/, "```\n")
          .gsub(/\[\/info\]/, "\n```")
      end
    end
  end
end
