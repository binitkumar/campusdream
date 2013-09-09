module ApplicationHelper
  def columizer value
    if value.length > 23
      sub_value = value[0..23] + ".."
    else
      value
    end
  end

  def headline value
    if value.length > 75
      sub_value = value[0..75] + ".."
    else
      value
    end
  end

  def mail_status(conversation)
    conversation.receipts.map(&:is_read).each do |mail_status|
      return "Pending" unless mail_status
    end
    return "Viewed"
  end
end
