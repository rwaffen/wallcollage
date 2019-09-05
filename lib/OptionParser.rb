=begin
@author     Robert Waffen <rwaffen@gmail.com>

This code takes the options from the command line and returns an array of these options.
=end


@options = {
  quantity: 10,
  width: 2560,
  height: 1440,
  border: 0,
}

OptionParser.new do |opts|
  opts.on("-p", "--path=PATH")             { |path|       @options[:path]       = path }
  opts.on("-q", "--quantity=QUANTITY")     { |quantity|   @options[:quantity]   = quantity.to_i }
  opts.on("-w", "--width=WIDTH")           { |width|      @options[:width]      = width.to_i }
  opts.on("-h", "--height=HEIGHT")         { |height|     @options[:height]     = height.to_i }
  opts.on("-b", "--border=BORDER")         { |border|     @options[:border]     = border.to_i }
  opts.on("-r", "--resolution=RESOLUTION") { |resolution| @options[:resolution] = resolution }
  opts.on("-d", "--debug")                 { |debug|      @options[:debug]      = debug }
end.parse!

case @options[:resolution]
when '4k'
  @options[:width]  = 3840
  @options[:height] = 2160
when 'mbp'
  # make it a little bit smaller, to have the borders on display
  @options[:width]  = 2559
  @options[:height] = 1599
when 'imac'
  @options[:width]  = 2560
  @options[:height] = 1440
when 'mbp_tb'
  @options[:width]  = 2880
  @options[:height] = 1800
end

pp @options if @options[:debug]
