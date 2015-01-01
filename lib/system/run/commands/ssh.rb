module Oc::Run
  class Ssh < Base
    def initialize
      config(Netrc.read)
    end


    description "This method lists all the available public SSH keys in your account that can be added to a droplet."
    syntax "oc ssh keys"
    def keys
      result = barge.key.all
      if !result.success?
        puts "Error: Please check your information".red
      else
        puts "Your SSH Keys".yellow
        rows = []

        rows << [
          'ID',
          'Name'
        ]

        result.ssh_keys.each do |key|
          rows << [
            key["id"],
            key["name"].red,
          ]
        end
        table = Terminal::Table.new :rows => rows
        puts table
      end
    end

    description "This method allows you to add a new public SSH key to your account."
    syntax "oc ssh add [KEY_NAME] [KEY_EMAIL] [KEY_PUB]"

    def add(*args)
      name = args[0]
      pub_key = args[1]
      if name.nil? or pub_key.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc ssh add [KEY_NAME] [KEY_PUB]".yellow
      else
        result = barge.key.create({
          :name => name,
          :public_key => pub_key
          })
        if !result.success?
          puts "#{result.message}".red
        else
          puts "SSH Key Added".green
        end
      end
    end

    description "This method shows a specific public SSH key in your account that can be added to a droplet."
    syntax "oc ssh show [KEY_ID]"
    def show(*args)
      id = args[0]
      if id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc ssh show [KEY_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        result = barge.key.show(id)
        if !result.success?
          puts "#{result.message}".red
        else
          puts "SSH Keys".yellow
          rows = []

          rows << [
            'ID',
            'Name'
          ]

          key = result.ssh_key
          rows << [
            key.id,
            key.name.to_s.red
          ]

          table = Terminal::Table.new :rows => rows
          puts table

        end
      end
    end

    description "This method allows you to modify an existing public SSH key in your account."
    syntax "oc ssh edit [KEY_ID] [KEY_NAME] [KEY_PUB]"

    def update(*args)
      id = args[0]
      name = args[1]
      pub_key = args[2]

      if id.nil? or name.nil? or pub_key.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc ssh edit [KEY_ID] [KEY_NAME] [KEY_PUB]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        result = barge.key.update(id, {
          :name => name,
          :public_key => pub_key
          })
        if !result.success?
          puts "#{result.message}".red
        else
          puts "SSH Key Edited".green
        end
      end
    end

    description "This method will delete the SSH key from your account."
    syntax "oc ssh destroy [KEY_ID]"

    def destroy(*args)
      id = args[0]
      if id.nil?
        puts "Argument Error".red
        puts "Usage".yellow
        puts "$ oc ssh destroy [KEY_ID]".yellow
      else
        raise ArgumentError, "Argument Error - #{id}" unless id =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
        result = barge.key.destroy(id)
        if !result.success?
          puts "#{result.message}".red
        else
          puts "SSH Key Deleted".green
        end
      end
    end

    private
    def config(value)
      @config ||=value
    end

    def barge
      puts "I'm thinking, please wait..".blue
      Oc::Get.get_barge
    end

    def new_key_request name, pub_key

    end

  end
end
