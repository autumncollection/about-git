#!/usr/bin/env ruby
#encoding:utf-8
require 'net/http'
require 'json'
require 'uri'
require 'pp'

FACEBOOK_GRAPH_URL = 'http://graph.facebook.com/'
FACEBOOK_API_URL   = 'http://api.facebook.com/'
UNKNOWN, otpt      = 'neznámý', []

def send_request(base_url, tail='')
  url      = URI.join base_url, tail
  response = Net::HTTP.get_response url
  unless response.code == '200'
    pp "DOWNLOAD error for '#{url}': #{response.code} #{response.body}"
    return {}
  end
  JSON.parse response.body
end

ARGV.each { |url|
  base_domain = URI.parse(url).host.downcase =~ /(?:.*\.)?(\S+\.[a-z]{1,4})\z/ ?
    $1 : nil

  # EXTRA TASK 3

  response_domain = send_request FACEBOOK_GRAPH_URL, base_domain

  response_url = send_request(
    FACEBOOK_API_URL, "method/links.getStats?urls=#{url}&format=json")
  response_url = response_url.first if response_url.kind_of?(Array)

  # TASK 18
  # TASK 18
  # TASK 18
  # TASK 18
  # TASK 18
  # TASK 18

  # TASK 28
  # TASK 28
  # TASK 28
  # TASK 28
  # TASK 28
  # TASK 28
  # TASK 28


}

pp otpt
