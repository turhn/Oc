module Oc::Run
  class Sizes < Base

      description "This method returns all the available sizes that can be used to create a droplet."
      syntax "oc sizes"
      def run
        url = "https://api.digitalocean.com/sizes"
        result = Oc::Get.get_json_url(url)
        if result["status"] == "ERROR"
          puts "Error: #{result["error_message"]}".red
        else
          puts "Sizes".yellow
          rows = []

          rows << [
            'ID',
            'Name'
          ]

          result["sizes"].each do |key|
            rows << [
              key["id"],
              key["name"].red,
            ]
          end
          table = Terminal::Table.new :rows => rows
          puts table
        end
      end
  end
end
