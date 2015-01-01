module Oc
  class Config
    def self.get(key)
      config = Netrc.read("#{(ENV["HOME"] || "./")}/oc.netrc")
      config = config["api.digitalocean.com"]
      options = {
        :api_key => config[0]
      }
      return options[:"#{key}"]
    end
  end
end
