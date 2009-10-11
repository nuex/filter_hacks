module FilterHacks

  def self.included kls
    kls.send :extend, ClassMethods
  end

  module ClassMethods

    # Find a previously created filter and add
    # some more options to it.
    #
    # Usage:
    # <tt>append_filter_options :my_filter_method, :only => [:index]</tt>
    #
    def append_filter_options method, options
      filter = filter_chain.select{ |f| f.method == method }.first
      if filter
        current_options = filter.instance_variable_get('@options')
        options.each_key do |k|
          actions = options[k].to_a.map! { |o| o.to_s }
          current_options[k].merge(actions)
        end
      end
    end
  end

end
