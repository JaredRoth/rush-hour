class ClientLoader
  attr_accessor :status_name
  attr_reader :id, :root_url, :status, :body

  STATUSES = {
    missing_data:     {status: 400, body: ""},
    duplicate_client: {status: 403, body: ""},
    valid:            {status: 200, body: {identifier: nil}}
  }

  def initializer(params)
    @id = params["identifier"]
    @root_url = params["rootUrl"]
    @client = Client.new(id, root_url)
  end

  def create!
    if valid?
      status_name = :valid if Client.create(identifier: id, rootUrl: root_url)
    end
  end

  def valid?
    if missing_data?
      status = STATUSES[:missing_data]
      return false
    elsif Client.exists?(identifier: id)
      status = STATUSES[:duplicate_client]
      return false
    end
    true
  end

  def missing_data?
    id.nil? || root_url.nil?
  end

  def status
    STATUSES[:]
  end
  def save_client
  end
end
