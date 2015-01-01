module Oc::Run
  class Info < Base

    description "Show your API information"
    def show
      puts "Access Tokens: #{Oc::Config.get("api_key")}".yellow
    end

    description "Change your API information"
    def change(*args)
      config = Netrc.read("#{(ENV["HOME"] || "./")}/oc.netrc")
      api_key = [(print 'Access Tokens: '), STDIN.gets.rstrip][1]
      client_id = "empty"
      if api_key.empty?
        puts "Please fill all fields".red
      else
        config["api.digitalocean.com"] = api_key, client_id
        config.save
        puts "Informations is changed".red
      end
    end

  end
end
