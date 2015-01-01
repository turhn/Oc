require "net/http"
require "json"
require "barge"
module Oc
  class Get
    def self.get_barge
      barge = ::Barge::Client.new(access_token: Oc::Config.get(:api_key))
    end
  end
end
