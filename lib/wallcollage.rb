class Wallcollage
  def get_rnd_files(path, quantity)
    # jpg and png
    tmp_list = Dir[path + '/**{,/*/**}/*.[jJpP]*']
    list = tmp_list.sample(quantity)
    Magick::ImageList.new(*list)
  end

  def resize_images(image_list, width, height, gravity = Magick::NorthGravity)
    tmp_list = Magick::ImageList.new

    image_list.each do |image|
      tmp_list << image.resize_to_fill(width, height, gravity)
    end

    pp tmp_list if Choice[:debug]
    return tmp_list
  end

  def get_opts(quantity, multiplier, max_width, max_height)
    hash = {
        :width  => max_width   / (quantity / multiplier),
        :height => max_height  / multiplier,
        :tile   => "#{quantity / multiplier}x#{multiplier}",
        :border => Choice[:border],
    }

    puts "tile info: #{hash.to_s}" if Choice[:debug]

    return hash
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

  def create_collage(path, quantity, max_width, max_height, file_name)
    opts        = get_opts(quantity, eval_quantity(quantity), max_width, max_height)
    input_list  = get_rnd_files(path, quantity)
    output_list = resize_images(input_list, opts[:width], opts[:height])

    collage = output_list.montage do |mont|
      mont.geometry = "#{opts[:width]}x#{opts[:height]}+#{opts[:border]}+#{opts[:border]}"
      mont.tile = opts[:tile]
    end

    if file_name
      collage.write(file_name)
    else
      output_dir = 'out'
      file_name  = "#{quantity}_#{SecureRandom.hex}"
      Dir.mkdir(output_dir) unless File.exists?(output_dir)
      collage.write(Dir.pwd + "/#{output_dir}/#{file_name}.jpg")
      puts "created ... #{Dir.pwd}/#{output_dir}/#{file_name}.jpg"
    end
  end
end
