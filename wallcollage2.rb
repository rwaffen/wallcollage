require 'rmagick'
require 'pp'
require 'choice'

Choice.options do
  header ''
  header 'Specific options:'

  option :path, :required => true do
    short '-p'
    long '--path=PATH'
    desc 'The path to the picture folder.'
  end

  separator ''
  separator 'Common options: '

  option :quantity, :required => false do
    short '-q'
    long '--quantity=QUANTITY'
    desc 'The quantity of pictures to include in the collage.'
    cast Integer
    default 10
  end

  option :width, :required => false do
    short '-w'
    long '--width=WIDTH'
    desc 'The width of the collage. Defaults to 2560.'
    cast Integer
    default 2560
  end

  option :height, :required => false do
    short '-h'
    long '--height=HEIGHT'
    desc 'The height of the collage. Defaults to 1440.'
    cast Integer
    default 1440
  end

  option :name, :required => false do
    short '-n'
    long '--name=NAME'
    desc 'The name and path for output file'
  end

  option :debug, :required => false do
    short '-d'
    long '--debug'
    desc 'Activate to get some debug information.'
  end
end

def get_rnd_files(path, quantity)
  list = Dir[path + '/*.j*g']
  list += Dir[path + '/*.png']
  list.sample(quantity)
end

def resize_images(image_list, width, height, gravity = Magick::NorthGravity)
  tmp_list = Magick::ImageList.new
  image_list.each do |image|
    tmp_image = image.resize_to_fill(width, height, gravity)
    tmp_list << tmp_image
  end
  tmp_list
end

def get_opts(quantity, multiplier, max_width, max_height)
  #max_width = max_width - ((quantity / multiplier) * 2)
  #max_height = max_height - (multiplier * 2)
  {
      :width => max_width / (quantity / multiplier),
      :height => max_height / multiplier,
      :tile => "#{quantity / multiplier}x#{multiplier}",
  }
end

def create_collage(path, quantity, max_width, max_height, file_name)

  #opts = get_opts 10, 2, 2560, 1440

  case quantity
    when 2..7, 9
      opts = get_opts quantity, 1, max_width, max_height
    when 8, 10, 12, 14, 16, 20, 22
      opts = get_opts quantity, 2, max_width, max_height
    when 15, 18, 21, 24, 27, 30, 33, 39, 42, 51
      opts = get_opts quantity, 3, max_width, max_height
    when 24, 28, 32, 36, 40, 44, 48, 52
      opts = get_opts quantity, 4, max_width, max_height
    when 25, 35, 45, 50, 55
      opts = get_opts quantity, 5, max_width, max_height
    when 54
      opts = get_opts quantity, 6, max_width, max_height
    when 49
      opts = get_opts quantity, 7, max_width, max_height
    else
      puts 'not supported quantity'
      exit 1
  end

  list = Magick::ImageList.new(*get_rnd_files(path, quantity))
  output_list = resize_images(list, opts[:width], opts[:height])

  pp output_list if Choice[:debug]

  collage = output_list.montage do |mont|
    mont.geometry = "#{opts[:width]}x#{opts[:height]}+1+1"
    mont.tile = opts[:tile]
  end

  if file_name
    collage.write(file_name)
  else
    output_dir= 'out'
    Dir.mkdir(output_dir) unless File.exists?(output_dir)
    collage.write(Dir.pwd + "/#{output_dir}/#{quantity}_#{SecureRandom.hex}.jpg")
  end
end

pp Choice.choices if Choice[:debug]

create_collage(
    Choice[:path],
    Choice[:quantity],
    Choice[:width],
    Choice[:height],
    Choice[:name]
)