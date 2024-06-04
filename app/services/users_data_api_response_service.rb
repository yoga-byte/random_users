# frozen_string_literal: true

class UsersDataApiResponseService
  require 'net/http'
  def call
    http.use_ssl = true
    api_response
  end

  def api_response
    @api_response ||= http.get(url.request_uri)
  end

  def http
    @http ||= Net::HTTP.new(url.host, url.port)
  end

  def url
    @url ||= URI.parse('https://randomuser.me/api/?results=20')
  end
end
