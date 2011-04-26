require 'rubygems'
require 'net/http'
require 'uri'
require 'json'

if ARGV.size < 3
  puts "Usage: #{File.basename(__FILE__)} login password email1 email2 ..."
  exit 1
end

login, password, *emails = ARGV

url = URI.parse("http://isuppress.net/api/v1/lists/update")

h = Net::HTTP.start(url.host, url.port)
request = Net::HTTP::Post.new(url.path)
request.basic_auth login, password
request.set_form_data :emails => emails.join("\n")

response = h.request request

if response.is_a? Net::HTTPSuccess
  j = JSON.parse response.body
  puts j.inspect
else
  puts "ERROR: #{response.code}, #{response.body}"
end
