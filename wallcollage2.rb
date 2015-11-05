require 'rmagick'
require 'pp'
require 'choice'

Choice.options do
  separator ''

  option :quantity, :required => true do
    short '-q'
    long  '--quantity'
    desc  'quantity to include in the collage.'
  end

  option :path , :required => true do
    short '-p'
    long  '--path'
    desc  'The path to the picture folder.'
  end
end

output_dir= 'out/'
Dir.mkdir(output_dir) unless File.exists?(output_dir)

def get_rnd_files(path, quantity)
  list = Dir[path + '/*.jpg']
  list += Dir[path + '/*.png']
  list.sample(quantity)
end

def resize_images(image_list, width, height)
  tmp_list = Magick::ImageList.new
  gravity = Magick::NorthGravity
  image_list.each do |image|
    tmp_image = image.resize_to_fill(width, height, gravity)
    tmp_list << tmp_image
  end
  tmp_list
end

def create_collage(path,quantity)
  if quantity == 40
    width = 256
    height = 360
    tile = '10x'
  elsif quantity == 10
    width = 512
    height = 720
    tile = '5x'
  end

  list = Magick::ImageList.new(*get_rnd_files(path,quantity))
  output_list = resize_images(list, width, height)

  collage = output_list.montage do |mont|
    mont.geometry = "#{width}x#{height}"
    mont.tile = tile
  end

  collage.write(Dir.pwd + "/out/#{SecureRandom.hex}.jpg")
end

create_collage Choice[:path], Choice[:quantity].to_i