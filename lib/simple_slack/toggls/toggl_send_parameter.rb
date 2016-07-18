module TogglSendParameter
  def send_morning_message
    message = "おはようございます。"

    send_message_select(message)
  end

  def send_regular_message(current_time = Time.now)
    current_time_s = current_time.strftime("%Y年%m月%d日: %H時")
    message = "#{current_time_s}です。"

    send_message_select(message)
  end

  def send_noon_message
    if working_entry
      "お昼です。休憩をするなら作業内容を止めてください。\n■現在作業中の内容。\n#{entry_info(working_entry)}"
    end
  end

  def send_after_noon_message
    message = "お昼休み終了です。"
    send_message_select(message)
  end

  def send_night_message
    if working_entry
      message = "業務終了の時間です。残業がないなら作業内容を止めてください。\n■現在作業中の内容。\n#{entry_info(working_entry)}"
      "#{message}\n\nもし残業があるなら終了のリマインドを設定してください。\n\n```\n/remind me in 終了時間 to toggle stop\n```"
    end
  end

  def send_dailyreport_message(date = Date.today)
    date_s = date.strftime("%Y年%m月%d日")
    "#{date_s}の日報です\n\n#{dailyreport}"
  end

  private

  def send_message_select(message)
    if working_entry
      "#{message}\n■現在作業中の内容。\n#{entry_info(working_entry)}"
    else
      "#{message}\n■現在作業中の内容はありません。下記より設定してください。\n#{SimpleSlack::Toggl::TIMER_URL}"
    end
  end
end
