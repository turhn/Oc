module Oc::Run
  class Info < Base

    def show
      puts "Client ID: #{Oc::Config.get("client_id")}".yellow
      puts "API Key: #{Oc::Config.get("api_key")}".yellow
    end

    description "Change your API information"
    def change(*args)
      config = Netrc.read("oc.netrc")
      client_id = [(print 'Digital Ocean Client ID: '), STDIN.gets.rstrip][1]
      api_key = [(print 'Digital Ocean API Key: '), STDIN.gets.rstrip][1]
      if client_id.empty? and api_key.empty?
        puts "Please fill all fields".red
      else
        puts "#{client_id} - #{api_key}"
        config["api.digitalocean.com"] = client_id, api_key
        config.save
        puts "Informations is changed".red
      end
    end

  end
end
