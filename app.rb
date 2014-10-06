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
  base_domain = URI.parse(url).host
  otpt << {'url' => url}
  unless base_domain
    otpt.last.merge!({'error' => "BAD URI"})
    next
  end

  # EXTRA TASK 3
  base_domain = base_domain.downcase =~ /(?:.*\.)?(\S+\.[a-z]{1,4})\z/ ? $1 : nil

  response_domain = send_request FACEBOOK_GRAPH_URL, base_domain

  response_url = send_request(
    FACEBOOK_API_URL, "method/links.getStats?urls=#{url}&format=json")
  response_url = response_url.first if response_url.kind_of?(Array)

  # TASK 1 + 2 HERE
  otpt.last.merge!({
    'host'                      => base_domain,
    'Facebook ID'               => response_domain['id']       || UNKNOWN,
    'Počet likes stránky na FB' => response_domain['likes']    || UNKNOWN,
    'Počet likes článku'        => response_url['like_count']  || UNKNOWN,
    'Počet sdílení článku'      => response_url['share_count'] || UNKNOWN,
  })

}

pp otpt
