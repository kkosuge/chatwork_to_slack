require 'chatwork'

module ChatworkToSlack
  class Importer
    attr_reader :room_id, :channel, :workdir, :export_files, :gcw, :c2s, :users, :chatwork_api_key
    def initialize(gcw, args)
      @room_id = args[:room_id]
      @channel = args[:channel]
      @workdir = args[:workdir]
      @export_files = args[:export_files]
      @users = args[:users]
      @chatwork_api_key = args[:chatwork_api_key]
      @gcw = gcw

      gcw.login

      if !room_id || !channel
        chatwork_list
      else
        create_workdir
        export
        convert
      end
    end

    def chatwork_list
      puts gcw.room_list.map { |i| i.join(' ') }
    end

    def create_workdir
      unless File.exists?(workdir)
        gcw.info "mkdir #{workdir}"
        FileUtils.mkdir_p(workdir)
      end
    end

    def export
      if export_files
        gcw.export_csv(room_id, chatwork_csv_path, { include_file: true, dir: chatwork_files_path })
      else
        gcw.export_csv(room_id, chatwork_csv_path)
      end
    end

    def chatwork_csv_path
      File.join(workdir, "#{room_id}.csv")
    end

    def chatwork_files_path
      File.join(workdir, "#{room_id}_files")
    end

    def slack_csv_path
      File.join(workdir, "#{channel}.csv")
    end

    def convert
      gcw.info "create #{slack_csv_path}"
      File.write(slack_csv_path, c2s.to_csv)
    end

    def c2s
      @c2s ||= ChatworkToSlack::Client.new(
        room_id: room_id,
        channel: channel,
        workdir: workdir,
        users: users,
        chatwork_csv_path: chatwork_csv_path,
        chatwork_api_key: chatwork_api_key
      )
    end
  end
end
