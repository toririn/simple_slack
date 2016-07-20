module TogglEntriesParameter

  def entries
    @entries ||= toggl_client.my_time_entries
  end

  def day_entries(day = Time.now.to_date)
    entries.select do |entry|
      start_date = Time.parse(entry["start"]).getlocal("+09:00").to_date
      start_date == day
    end
  end

  def latest_entry
    entries.sort_by{ |entry| entry["start"] }.last
  end

  def working_entry
    if latest_entry["stop"].nil?
      latest_entry
    end
  end

  def entry_info(entry = latest_entry)
    # 現在作業中（終了時間がない）であれば現在日時を終了時間として取得
    stop_time_org  = entry["stop"].nil? ? Time.now : Time.parse(entry["stop"])

    start_time = Time.parse(entry["start"]).getlocal("+09:00")
    stop_time  = stop_time_org.getlocal("+09:00")
    diff_time  = (stop_time - start_time)/3600

    # 0.1h 以下の表示になるようであれば 分表示に変更する
    if diff_time >= 0.1
      work_time = "#{diff_time.round(2)}h"
    else
      work_time = "#{(diff_time * 60).round(2)}m"
    end

    tag = entry["tags"].join(" ") unless entry["tags"].nil?
    description = entry["description"]

    "#{tag} #{description} \(#{work_time}\)"
  end

  def entry_info_hash(entry = latest_entry)
    # 現在作業中（終了時間がない）であれば現在日時を終了時間として取得
    stop_time_org  = entry["stop"].nil? ? Time.now : Time.parse(entry["stop"])

    start_time = Time.parse(entry["start"]).getlocal("+09:00")
    stop_time  = stop_time_org.getlocal("+09:00")
    diff_time  = (stop_time - start_time)/60

    work_time = diff_time.round(2)

    tag = entry["tags"].join(" ") unless entry["tags"].nil?
    description = entry["description"]

    { "#{tag} #{description}" => work_time }
  end

end
