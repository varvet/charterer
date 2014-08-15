require 'json'
require 'openssl'
require 'base64'
require 'net/http'
require "uri"

class Feed

  def initialize(user, ip)
    @user = user
    @ip = ip
  end

  def header
    digest = OpenSSL::Digest::Digest.new('sha256')
    signature  = OpenSSL::HMAC.hexdigest(digest, Devise.omniauth_configs[:instagram].strategy.client_secret, @ip)
    header = [@ip, signature].join('|')
  end

  def get_last_20(last_image)
    return JSON.parse( Net::HTTP.get(URI.parse("https://api.instagram.com/v1/users/self/feed?access_token=#{@user.token}&max_id=#{last_image.remote_id}&count=20")), symbolize_names: true )
  end
end
