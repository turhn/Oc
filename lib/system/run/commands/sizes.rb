module Oc::Run
  class Sizes < Base

      description "This method returns all the available sizes that can be used to create a droplet."
      syntax "oc sizes"
      def run
        result = barge.size.all
        if !result.success?
          puts "Error: #{result["error_message"]}".red
        else
          puts "Sizes".yellow
          rows = []

          rows << [
            'ID',
            'Memory',
            'Disk',
            'Cpu',
            'Price (Monthly)',
            'Price (Hourly)',
          ]

          result.sizes.each do |size|
            rows << [
              size.slug,
              size.memory.to_s + " MB",
              size.disk.to_s + " GB",
              size.vcpus,
              "$ " + size.price_monthly.to_s,
              "$ " + size.price_hourly.to_s
            ]
          end
          table = Terminal::Table.new :rows => rows
          puts table
        end
      end
    def barge
      puts "I'm thinking, please wait..".blue
      Oc::Get.get_barge
    end
  end
end
