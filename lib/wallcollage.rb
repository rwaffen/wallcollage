class Wallcollage
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
    hash = {
        :width => max_width / (quantity / multiplier),
        :height => max_height / multiplier,
        :tile => "#{quantity / multiplier}x#{multiplier}",
    }
    if Choice[:debug]
      pp "tile info: #{hash.to_s}"
    end
    hash
  end

  def create_collage(path, quantity, max_width, max_height, file_name)

    if ( quantity < 10 )
      opts = get_opts quantity, 1, max_width, max_height
    end

    if ( quantity.between?(10,54) && quantity % 2 == 0 )
      if quantity < 23
        opts = get_opts quantity, 2, max_width, max_height
      elsif quantity < 55
        opts = get_opts quantity, 4, max_width, max_height
      end
    end

    if ( quantity.between?(13,40) && quantity % 3 == 0 )
      opts = get_opts quantity, 3, max_width, max_height
    end

    # if ( quantity.between?(25,55) && quantity % 5 == 0 )
    #   opts = get_opts quantity, 5, max_width, max_height
    # end

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
      output_dir = 'out'
      file_name  = "#{quantity}_#{SecureRandom.hex}"
      Dir.mkdir(output_dir) unless File.exists?(output_dir)
      collage.write(Dir.pwd + "/#{output_dir}/#{file_name}.jpg")
      puts "created ... #{Dir.pwd}/#{output_dir}/#{file_name}.jpg"
    end
  end
end
