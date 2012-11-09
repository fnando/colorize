module Colorize
  extend self

  COLORS = {
    :black   => "30",
    :blue    => "34",
    :cyan    => "36",
    :gray    => "30",
    :green   => "32",
    :purple  => "35",
    :red     => "31",
    :white   => "37",
    :yellow  => "33"
  }

  Colorize::COLORS.keys.each do |name|
    String.class_eval <<-RUBY, __FILE__, __LINE__
      def to_#{name}(options = {})                                # def to_white(options = {})
        Colorize.apply(self, options.merge(:color => :#{name}))   #   Colorize.apply(self, options.merge(:color => :white))
      end                                                         # end
    RUBY
  end

  BGCOLORS = {
    :black   => "40",
    :blue    => "44",
    :cyan    => "46",
    :gray    => "47",
    :green   => "42",
    :purple  => "45",
    :red     => "41",
    :white   => "47",
    :yellow  => "43"
  }

  STYLES = {
    :highlight  => "1",
    :blink      => "5",
    :underscore => "4"
  }

  def puts(string, options = {})
    Kernel.puts apply(string, options)
  end

  def apply(string, options = {})
    if ENV["COLORIZE"] == "0"
      string
    else
      options = {
        :style => []
      }.merge(options)

      options[:style] = [options[:style]].flatten

      colors = []

      options[:color] = options[:color].to_sym if options[:color]
      options[:bgcolor] = options[:bgcolor].to_sym if options[:bgcolor]

      colors << COLORS[options[:color]] if options[:color]
      colors << BGCOLORS[options[:bgcolor]] if options[:bgcolor]

      options[:style] << :highlight if [options[:color], options[:bgcolor]].include?(:white)

      options[:style].each do |option|
        colors << STYLES[option.to_sym]
      end

      colors.uniq!
      colors.compact!

      %(\e[#{colors.join(";")}m#{string}\e[0m)
    end
  end

  # Allow to colorize strings using color names.
  #
  #   Colorize.red "Error!"
  #   Colorize.red "Error!", :style => :blink
  #
  def method_missing(color_name, *args)
    if COLORS.keys.include?(color_name.to_sym)
      string = args.shift
      options = args.pop || {}
      apply string, {:color => color_name}.merge(options)
    else
      super
    end
  end

  def respond_to?(method, include_private = false)
    return true if COLORS.keys.include?(color_name.to_sym)
    super
  end
end
