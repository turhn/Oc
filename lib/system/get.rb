require "net/http"
require "json"
require "barge"
module Oc
  class Get
    def self.get_json path,filter=nil
      source = "https://api.digitalocean.com/#{path}/?client_id=#{Oc::Config.get("client_id")}&api_key=#{Oc::Config.get("api_key")}&filter=#{filter}"
      puts "I'm thinking, please wait..".blue
      response = Net::HTTP.get_response(URI.parse(source))
      data = response.body
      result = JSON.parse(data)
    end

    def self.get_barge
      barge = ::Barge::Client.new(access_token: Oc::Config.get(:api_key))
    end


    def self.get_json_parameter path, sub_path = nil ,parameters=[]
      url = "https://api.digitalocean.com/#{path}"

      unless sub_path.nil?
        url += "/#{sub_path}"
      end

      url += "?client_id=#{Oc::Config.get("client_id")}&api_key=#{Oc::Config.get("api_key")}"

      parameter = ""
      if parameters.length > 0
        parameters.each do |p,v|
          parameter += "&#{p}=#{v}"
        end
      end

      parameter = URI::escape(parameter)

      source = url + parameter

      puts "I'm thinking, please wait..".blue
      response = Net::HTTP.get_response(URI.parse(source))
      data = response.body
      result = JSON.parse(data)
    end


    def self.get_json_url url ,parameters=[]

      url += "?client_id=#{Oc::Config.get("client_id")}&api_key=#{Oc::Config.get("api_key")}"

      parameter = ""
      if parameters.length > 0
        parameters.each do |p,v|
          parameter += "&#{p}=#{v}"
        end
      end

      parameter = URI::escape(parameter)

      source = url + parameter

      puts "I'm thinking, please wait..".blue
      response = Net::HTTP.get_response(URI.parse(source))
      data = response.body
      result = JSON.parse(data)
    end

  end
end
