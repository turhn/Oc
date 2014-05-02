module Oc::Run
  class Images < Base

    description "This method returns all the available images that can be accessed by your client ID. You will have access to all public images by default, and any snapshots or backups that you have created in your own account."
    syntax "co images [FLAG true -> Show my images]"
    def run(*args)
      filter = args[0]
      if filter == "true"
        result = Oc::Get.get_json("images","my_images")
        if result["status"] == "ERROR"
          puts "Error: Please check your information".red
        else
          puts "Images".yellow
          rows = []

          rows << [
            'ID',
            'Name',
            'Distribution',
            'Public',
            'Regions'
          ]

          result["images"].each do |images|
            rows << [
              images["id"],
              images["name"].red,
              images["distribution"].red,
              images["public"] == true ? "True".green : "False".red,
              images["regions"].join(",").yellow
            ]
          end
          table = Terminal::Table.new :rows => rows
          puts table
        end
      else
        result = Oc::Get.get_json("images")
        if result["status"] == "ERROR"
          puts "Error: Please check your information".red
        else
          puts "Images".yellow
          rows = []

          rows << [
            'ID',
            'Name',
            'Distribution',
            'Public',
            'Regions'
          ]

          result["images"].each do |images|
            rows << [
              images["id"],
              images["name"].red,
              images["distribution"].red,
              images["public"] == true ? "True".green : "False".red,
              images["regions"].join(",").yellow
            ]
          end
          table = Terminal::Table.new :rows => rows
          puts table
        end
      end
    end

    description "This method displays the attributes of an image."
    syntax "oc images show [IMAGE_ID]"
    def show(*args)
      id = args[0]
      if id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc images show [IMAGE_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/

        url = "https://api.digitalocean.com/images/#{id}/"
        result = Oc::Get.get_json_url(url)
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Images".yellow
          rows = []

          rows << [
            'ID',
            'Name',
            'Distribution',
            'Public',
            'Regions'
          ]

          images = result["image"]

          rows << [
            images["id"],
            images["name"].red,
            images["distribution"].red,
            images["public"] == true ? "True".green : "False".red,
            images["regions"].join(",").yellow
          ]

          table = Terminal::Table.new :rows => rows
          puts table

        end
      end
    end


    description "This method allows you to destroy an image. There is no way to restore a deleted image so be careful and ensure your data is properly backed up."
    syntax "oc images destroy [IMAGE_ID]"

    def destroy(*args)
      id = args[0]
      if id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc images destroy [IMAGE_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        url = "https://api.digitalocean.com/images/#{id}/destroy/"
        result = Oc::Get.get_json_url(url)
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Image destroyed".green
        end
      end
    end

    description "This method allows you to transfer an image to a specified region."
    syntax "oc images transfer [IMAGE_ID] [REGION_ID]"
    def transfer(*args)
      id = args[0]
      region_id = args[1]
      if id.nil? or region_id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc images transfer [IMAGE_ID] [REGION_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        raise ArgumentError, "Argument Error - #{id}" unless region_id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        url = "https://api.digitalocean.com/images/#{id}/transfer/"
        result = Oc::Get.get_json_url(url,{ "region_id" => region_id })
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Image transfered".green
        end
      end
    end


  end
end
