module Oc::Run
  class Regions < Base
    description "This method will return all the available regions within the DigitalOcean cloud."
    syntax "oc regions"
    def run
      result = Oc::Get.get_json("regions")
      if result["status"] == "ERROR"
        puts "Error: Please check your information".red
      else
        puts "Regions".yellow
        droplets = []

        droplets << [
          'ID',
          'Name'
        ]

        result["regions"].each do |droplet|
          droplets << [
            droplet["id"],
            droplet["name"].red,
          ]
        end
        table = Terminal::Table.new :rows => droplets
        puts table
      end
    end
  end
end
