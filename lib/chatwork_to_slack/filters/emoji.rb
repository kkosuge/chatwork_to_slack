module ChatworkToSlack
  module Filters
    class Emoji
      TABLE = {
        ':)' => ':grinning:',
        ':(' => ':weary:',
        ':D' => ':smiley:',
        '8-)' => ':sunglasses:',
        ':o' => ':hushed:',
        ';)' => ':wink:',
        ';(' => ':cry:',
        '(sweat)' => ':sweat:',
        ':|' => ':neutral_face:',
        ':*' => ':kissing_heart:',
        ':p' => ':stuck_out_tongue_winking_eye:',
        '(blush)' => ':relaxed:',
        ':^)' => ':thinking_face:',
        '|-)' => ':sleeping:',
        '(inlove)' => ':heart_eyes:',
        ']:)' => ':triumph:',
        '(talk)' => ':open_mouth:',
        '(yawn)' => ':astonished:',
        '(puke)' => ':hankey:',
        '(emo)' => ':sunglasses:',
        '8-|' => ':nerd_face:',
        ':#)' => ':grin:',
        '(nod)' => ':grin::slightly_smiling_face:',
        '(shake)' => 'confused:',
        '(^^;)' => ':sweat:',
        '(whew)' => ':sweat:',
        '(clap)' => ':clap:',
        '(bow)' => ':bow:',
        '(roger)' => ':hand:',
        '(flex)' => ':muscle:',
        '(dance)' => ':raised_hands:',
        '(:/)' => ':spock-hand:',
        '(devil)' => ':smiling_imp:',
        '(*)' => ':star:',
        '(h)' => ':heart:',
        '(F)' => ':sunflower:',
        '(cracker)' => ':tada:',
        '(^)' => ':birthday:',
        '(coffee)' => ':coffee:',
        '(beer)' => ':beer:',
        '(handshake)' => ':spock-hand:',
        '(y)' => ':+1:',
      }

      def self.call(text, options)
        TABLE.each {|c, s| text.gsub!(c, s)}
        text
      end
    end
  end
end
