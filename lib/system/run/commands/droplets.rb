module Oc::Run
  class Droplets < Base

    def initialize
      config(Netrc.read)
    end

    description "Show Droplets"
    syntax "oc show"
    def show
      result = Oc::Get.get_json("droplets")
      if result["status"] == "ERROR"
        puts "Error: Please check your information".red
      else
        puts "Your Droplets".yellow
        droplets = []

        droplets << [
          'ID',
          'Name',
          'IP Address',
          'Private Ip Address',
          'Status',
          'Created At'
        ]

        result["droplets"].each do |droplet|
          droplets << [
            droplet["id"],
            droplet["name"].red,
            droplet["ip_address"].red,
            droplet["private_ip_address"].nil? ? "Null".red : droplet["private_ip_address"],
            droplet["status"] == "active" ? "Active".green : "Deactive".red,
            droplet["created_at"]
          ]
        end
        table = Terminal::Table.new :rows => droplets
        puts table
      end
    end


    description "Create new droplet"
    syntax "oc droplets new [DROPLET_NAME] [SIZE_ID] [IMAGE_ID] [REGION_ID]"

    def new(*args)
      name = args[0]
      size = args[1]
      image_id = args[2]
      region_id = args[3]
      if name.nil? or size.nil? or image_id.nil? or region_id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets new [DROPLET_NAME] [SIZE_ID] [IMAGE_ID] [REGION_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{size}" unless size =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        raise ArgumentError, "Argument Error - #{image_id}" unless image_id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/

        url = "https://api.digitalocean.com/droplets/new"
        result = Oc::Get.get_json_url(url,{"name" => name, "size_id" => size, "image_id" => image_id, "region_id" => region_id})
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Droplet created".green
        end
      end
    end


    description "Reboot droplet"
    syntax "oc droplets reboot [DROPLET_ID]"
    def reboot(*args)
      id = args[0]
      if id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets reboot [DROPLET_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        url = "https://api.digitalocean.com/droplets/#{id}/reboot"
        result = Oc::Get.get_json_url(url)
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Droplet rebooted".green
        end
      end
    end

    description "This method allows you to power cycle a droplet. This will turn off the droplet and then turn it back on."
    syntax "oc droplets cycle [DROPLET_ID]"
    def cycle(*args)
      id = args[0]
      if id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets cycle [DROPLET_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        url = "https://api.digitalocean.com/droplets/#{id}/power_cycle"
        result = Oc::Get.get_json_url(url)
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Power cycle has been successful".green
        end
      end
    end


    description "This method allows you to shutdown a running droplet. The droplet will remain in your account."
    syntax "oc droplets down [DROPLET_ID]"
    def down(*args)
      id = args[0]
      if id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets down [DROPLET_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        url = "https://api.digitalocean.com/droplets/#{id}/shutdown"
        result = Oc::Get.get_json_url(url)
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Shut down has been successful".green
        end
      end
    end


    description "This method allows you to poweroff a running droplet. The droplet will remain in your account."
    syntax "oc droplets off [DROPLET_ID]"
    def off(*args)
      id = args[0]
      if id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets off [DROPLET_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        url = "https://api.digitalocean.com/droplets/#{id}/power_off"
        result = Oc::Get.get_json_url(url)
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Power off has been successful".green
        end
      end
    end


    description "This method allows you to poweron a powered off droplet."
    syntax "oc droplets on [DROPLET_ID]"
    def on(*args)
      id = args[0]
      if id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets on [DROPLET_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        url = "https://api.digitalocean.com/droplets/#{id}/power_on"
        result = Oc::Get.get_json_url(url)
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Power on has been successful".green
        end
      end
    end


    description "This method will reset the root password for a droplet. Please be aware that this will reboot the droplet to allow resetting the password."
    syntax "oc droplets reset_password [DROPLET_ID]"

    def reset_password(*args)
      id = args[0]
      if id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets reset_password [DROPLET_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        url = "https://api.digitalocean.com/droplets/#{id}/password_reset"
        result = Oc::Get.get_json_url(url)
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Password restored. Please check your email".green
        end
      end
    end

    description "This method allows you to resize a specific droplet to a different size. This will affect the number of processors and memory allocated to the droplet."
    syntax "oc droplets resize [DROPLET_ID] [SIZE_ID]"
    def resize(*args)
      id = args[0]
      size_id = args[1]

      if id.nil? or size_id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets resize [DROPLET_ID] [SIZE_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        raise ArgumentError, "Argument Error - #{id}" unless size_id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        url = "https://api.digitalocean.com/droplets/#{id}/resize/"
        result = Oc::Get.get_json_url(url,{ "size" => size_id })
        if result["status"] == "ERROR"
          puts "#{result["error_message"]}".red
        else
          puts "Droplet resized".green
        end
      end
    end

    description "This method allows you to take a snapshot of the droplet once it has been powered off, which can later be restored or used to create a new droplet from the same image. Please be aware this may cause a reboot."
    syntax "oc droplets snaphot [DROPLET_ID] [SNAPSHOT_NAME]"
    def snapshot(*args)
      id = args[0]
      name = args[1]
      if id.nil? or name.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets snaphot [DROPLET_ID] [SNAPSHOT_NAME]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        url = "https://api.digitalocean.com/droplets/#{id}/snapshot"
        result = Oc::Get.get_json_url(url, {"name" => name})
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Snapshot generated.".green
        end
      end
    end

    description "This method allows you to restore a droplet with a previous image or snapshot. This will be a mirror copy of the image or snapshot to your droplet. Be sure you have backed up any necessary information prior to restore."
    syntax "oc droplets restore [DROPLET_ID] [IMAGE_ID]"

    def restore(*args)
      id = args[0]
      image_id = args[1]
      if id.nil? or image_id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets restore [DROPLET_ID] [IMAGE_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        raise ArgumentError, "Argument Error - #{image_id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/

        url = "https://api.digitalocean.com/droplets/#{id}/restore"
        result = Oc::Get.get_json_url(url, {"image_id" => image_id})
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Droplets restored.".green
        end
      end
    end

    description "This method allows you to reinstall a droplet with a default image. This is useful if you want to start again but retain the same IP address for your droplet."
    syntax "oc droplets rebuild [DROPLET_ID] [IMAGE_ID]"

    def rebuild(*args)
      id = args[0]
      image_id = args[1]
      if id.nil? or image_id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets rebuild [DROPLET_ID] [IMAGE_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        raise ArgumentError, "Argument Error - #{image_id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/

        url = "https://api.digitalocean.com/droplets/#{id}/rebuild"
        result = Oc::Get.get_json_url(url, {"image_id" => image_id})
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Droplets rebuilded.".green
        end
      end
    end

    description "This method renames the droplet to the specified name."
    syntax "oc droplets rename [DROPLET_ID] [NEW_NAME]"
    def rename(*args)
      id = args[0]
      name = args[1]
      if id.nil? or name.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc droplets rename [DROPLET_ID] [NEW_NAME]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/

        url = "https://api.digitalocean.com/droplets/#{id}/rename"
        result = Oc::Get.get_json_url(url, {"name" => name})
        if result["status"] == "ERROR"
          puts "#{result["message"]}".red
        else
          puts "Droplets renamed.".green
        end
      end
    end


    private
    def config(value)
      @config ||= value
    end

  end
end
