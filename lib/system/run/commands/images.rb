module Oc::Run
  class Images < Base

    description "This method returns all the available images that can be accessed by your client ID. You will have access to all public images by default, and any snapshots or backups that you have created in your own account."
    syntax "co images"
    def run(*args)
      result = barge.image.all
        if !result.success?
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

          result.images.each do |image|
            rows << [
              image.id,
              image.name.to_s.red,
              image.distribution.to_s.red,
              image.public.to_s == "true" ? "True".green : "False".red,
              image.regions.join(",").yellow
            ]
          end
          table = Terminal::Table.new :rows => rows
          puts table
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
        result = barge.image.show(id)
        if !result.success?
          puts "#{result.message}".red
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

          image = result.image

          rows << [
            image.id,
            image.name.to_s.red,
            image.distribution.to_s.red,
            image.public.to_s == "true" ? "True".green : "False".red,
            image.regions.join(",").yellow
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
        result = barge.image.destroy(id)
        if !result.success?
          puts "#{result.message}".red
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
        result = barge.image.transfer(id, region: region_id)
        if !result.success?
          puts "#{result.message}".red
        else
          puts "Image transfered".green
        end
      end
    end

    def barge
      puts "I'm thinking, please wait..".blue
      Oc::Get.get_barge
    end

  end
end
