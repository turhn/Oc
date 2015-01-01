module Oc::Run
  class Regions < Base
    description "This method will return all the available regions within the DigitalOcean cloud."
    syntax "oc regions"
    def run
      result = barge.region.all
      if !result.success?
        puts "Error: Please check your information".red
      else
        puts "Regions".yellow
        droplets = []

        droplets << [
          'ID',
          'Name'
        ]

        result.regions.each do |region|
          droplets << [
            region.slug,
            region.name.to_s.red,
          ]
        end
        table = Terminal::Table.new :rows => droplets
        puts table
      end
    end
    def barge
      puts "I'm thinking, please wait..".blue
      Oc::Get.get_barge
    end
  end
end
