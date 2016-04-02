module ModelStatistics

  def max_response_time
    payload_requests.maximum(:responded_in)
    # payload_requests.max_response_time
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def sort_response_times
    payload_requests.order(responded_in: :desc).pluck(:responded_in)
  end

  def avg_response_time
    payload_requests.average(:responded_in).to_f.round(2)
  end

  def all_request_types
    request_types.pluck(:request_type).uniq
  end

  def top_referrers
    referrers.group(:referred_by).count.sort_by{|k,v|v}.reverse.map{|pair| pair[0]}[0..2]
    # check order
  end

  def top_user_agents
    user_agent_strings.user_agent.group_by{|i|i}.sort_by{|k,v| v.count}.reverse.map{|pair| pair[0]}[0..2]
  end
end
