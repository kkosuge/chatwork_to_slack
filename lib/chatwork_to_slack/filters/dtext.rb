module ChatworkToSlack
  module Filters
    class Dtext
      TEMPLATE = {
        task_added: "タスク追加",
        file_uploaded: "ファイルアップロード",
        chatroom_chat_edited: "チャット変更",
        chatroom_member_is: "メンバー ",
        chatroom_priv_changed: " を管理者にしました",
        chatroom_added: " が入室しました",
        chatroom_deleted: " が退室しました",
        chatroom_leaved: " が退室しました",
        chatroom_chatname_is: "チャット名を ",
        chatroom_description_is: "説明文を ",
        chatroom_changed: " に変更しました",
        chatroom_set: " に設定しました",
        chatroom_groupchat_created: "チャット作成",
        task_done: "タスク終了",
        nickname_suffix: " さん",
        chatroom_over_groupchatnum: " は，制限により入室できません"
      }

      def self.call(text, options)
        text.scan(/(\[dtext:([\w]+)\])/).each do |dtext|
          if t = TEMPLATE[dtext[1].to_sym]
            text.gsub!(dtext[0], t)
          end
        end
        text
      end
    end
  end
end
