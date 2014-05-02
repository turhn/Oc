module Oc
  class Config
    def self.get(key)
      config = Netrc.read("#{(ENV["HOME"] || "./")}/digitalocean.netrc")
      config = config["api.digitalocean.com"]
      options = {
        :client_id => config[0],
        :api_key => config[1]
      }
      return options[:"#{key}"]
    end
  end
end
