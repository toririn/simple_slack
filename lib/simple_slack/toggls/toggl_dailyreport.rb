module TogglDailyreport
  def dailyreport
    today_entry_reports
  end

  def today_entry_reports
    _reports = []
    day_entries.each do |entry|
      _reports << entry_info_hash(entry)
    end

    report_group =
      _reports.group_by do |report|
        report.keys.first
      end

    reports =
      report_group.map do |discription, entrys|
        sum_time = entrys.inject(0){|sum, entry| sum + entry.values.first }
        "#{discription} \(#{(sum_time/60).round(1)}.h\)"
      end
    reports.join("\n")
  end

end
