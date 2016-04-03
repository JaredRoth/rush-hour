module ModelStatistics

  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def avg_response_time
    payload_requests.average(:responded_in).round(2)
  end

  def all_request_types
    request_types.pluck(:request_type).uniq
  end
end
