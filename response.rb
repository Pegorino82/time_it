module Response
  def response(status, body)
    [status, {'Content-Type' => 'text/plain'}, ["#{body}\n"]]
  end
end
