module TogglDailyreport
  def dailyreport
    today_entry_reports
  end

  def today_entry_reports
    reports = []
    day_entries.each do |entry|
      reports << entry_info(entry)
    end

    reports.join("\n")
  end

end
