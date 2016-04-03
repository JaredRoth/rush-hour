module ModelStatistics

  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def sort_response_times
    payload_requests.order(responded_in: :desc).pluck(:responded_in)
  end

  def avg_response_time
    payload_requests.average(:responded_in).round(2)
  end

  def all_request_types
    request_types.pluck(:request_type).uniq
  end

  def top_referrers
    referrers.group(:referred_by).order("count_all desc").count.keys
  end

  def top_user_agents
    user_agent_strings.group(:user_agent_browser, :user_agent_os).order("count_all desc").limit(3).count.keys
    # user_agent_strings.user_agent.group_by{|i|i}.sort_by{|k,v| v.count}.reverse.map{|pair| pair[0]}[0..2]
  end
end
