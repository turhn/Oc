require 'commander'
require 'commander/command'
require 'commander/import'
module Oc
  class Runner
    def self.start

      program :name, 'Digital Ocean Client'
      program :version, Oc::VERSION
      program :description, 'Digital Ocean Command Line Tools'

      Oc::Run.load_commands.parse_command

    end
  end
end
