module Oc
  module Run
    autoload :Base, "system/run/base"

    attr_accessor :main

    def self.load_commands
      Dir[File.join(File.dirname(__FILE__), "commands", "*.rb")].each do |file|
        require file
      end
      self
    end

    def self.add(opts)
      commands[opts[:name]] = opts
    end


    def self.parse_command(ins = Commander::Runner::instance)

      commands.each_pair do |name, opts|
        name = Array(name)
        names = [name.reverse.join('-'), name.join(' ')] if name.length > 1
        name = name.join(" ")


        ins.command name do |c|
          c.description = opts[:options][:description]
          c.summary = opts[:options][:summary]
          c.syntax = opts[:options][:syntax]

          (options_metadata = Array(opts[:options][:meta])).each do |o|
            option_data = [o[:switches], o[:type], o[:description], o[:optional]].compact.flatten(1)
            c.option *option_data
            o[:arg] = Commander::Runner.switch_to_sym(Array(o[:switches]).last)

          end

          c.when_called do |args, options|
            object = opts[:class].new
            object.options = options
            run(object,opts[:method],args)
          end
        end

      end

    end

    protected
    def self.run(obj, method, args)
      obj.send(method, *args)
    end


    protected
    def self.hash_to_array(options)
      return_data = []
      options.each do |k,v|
        return_data[k] = v
      end
      return return_data
    end

    def self.commands
      @commands ||= {}
    end

  end
end
