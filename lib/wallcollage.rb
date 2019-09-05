def get_rnd_files(path, quantity)
  # jpg and png
  list = Dir[path + '/**{,/*/**}/*.[jJpP]*'].sample(quantity)
  return Magick::ImageList.new(*list)
end

def resize_images(image_list, width, height, gravity = Magick::NorthGravity)
  tmp_list = Magick::ImageList.new

  image_list.each do |image|
    tmp_list << image.resize_to_fill(width, height, gravity)
  end

  return tmp_list
end

def eval_quantity(quantity)
  if Prime.prime?(quantity)
    unless quantity < 6
      puts "quantity: #{quantity}, can't be prime"
      exit 1
    end
  end

  case quantity
    when 2..5
      rows = 1
    when 6..14
      rows = 2 if quantity % 2 == 0
    when 15..25
      rows = 3 if quantity % 3 == 0
    when 26..40
      rows = 4 if quantity % 4 == 0
    when 41..55
      rows = 5 if quantity % 5 == 0
    when 56..100
      rows = 6 if quantity % 6 == 0
  end

  if rows.nil?
    puts "quantity: #{quantity}, doesn't fit into rows"
    exit 1
  else
    return rows
  end
end

def create_collage(path, quantity, max_width, max_height, border, debug)
  multiplier  = eval_quantity quantity
  width       = max_width   / (quantity / multiplier)
  height      = max_height  / multiplier
  input_list  = get_rnd_files path, quantity
  output_list = resize_images input_list, width, height
  file_name   = "#{quantity}_#{SecureRandom.hex}"

  pp output_list if debug

  collage = output_list.montage do |mont|
    mont.geometry = "#{width}x#{height}+#{border}+#{border}"
    mont.tile = "#{quantity / multiplier}x#{multiplier}"
  end

  collage.write("#{Dir.pwd}/out/#{file_name}.jpg")
  puts "created ... #{Dir.pwd}/out/#{file_name}.jpg"
end
