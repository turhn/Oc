class Oc::Run::Base
  attr_writer :options, :config


  def self.method_added(method)
    return if self == Oc::Run::Base
    return if private_method_defined? method
    return if protected_method_defined? method

    prefix = self.get_object_name
    method_name = method.to_s == 'run' ? nil : method.to_s.gsub('_','-')
    name = [prefix, method_name].compact

    Oc::Run.add({
      :name => name,
      :class => self,
      :method => method,
      :options => options
      })
      @options = nil
    end

    def self.get_object_name(value=nil)
      @object_name ||= begin
        value ||= if self.name && !self.name.empty?
          self.name.split('::').last
        end
        value.to_s.split(/(?=[A-Z])/).join('-').downcase if value
      end
    end

    def self.syntax(value)
      options[:syntax] = value
    end

    def self.description(value)
      options[:description] = value
    end

    def self.summary(value)
      options[:summary] = value
    end

    def self.example(value)
      options[:example] = value
    end

    def self.option(switches, description=nil, options={})
      meta << {
        :switches => switches,
        :description => description,
        :type => options[:type].nil? ? "String" : options[:type],
        :default => options[:default],
        :optional => options[:optional]
      }
    end

    def self.options
      @options ||= {}
    end

    def self.meta
      options[:meta] ||=[]
    end
  end
