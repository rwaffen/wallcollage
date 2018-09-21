class Wallcollage
  def get_rnd_files(path, quantity)
    list  = Dir[path + '/*.j*g']
    list += Dir[path + '/*.png']
    list.sample(quantity)
  end

  def resize_images(image_list, width, height, gravity = Magick::NorthGravity)
    tmp_list = Magick::ImageList.new
    image_list.each do |image|
      tmp_image = image.resize_to_fill(width, height, gravity)
      pp tmp_image if Choice[:debug]
      tmp_list << tmp_image
    end
    return tmp_list
  end

  def get_opts(quantity, multiplier, max_width, max_height)
    hash = {
        :width => max_width / (quantity / multiplier),
        :height => max_height / multiplier,
        :tile => "#{quantity / multiplier}x#{multiplier}",
    }

    puts "tile info: #{hash.to_s}" if Choice[:debug]

    return hash
  end

  def eval_quantity(quantity)
    if ( quantity < 10 )
      rows = 1
    else
      if Prime.prime?(quantity)
        puts "quantity: #{quantity}, can't be prime"
        exit 1
      end

      if ( quantity.between?(10,16) && quantity % 2 == 0 )
        rows = 2
      end

      if ( quantity.between?(20,41) && quantity % 4 == 0 )
        rows = 4
      else
        puts "quantity: #{quantity}, can't be divided by 4" if Choice[:debug]
      end

      if ( quantity.between?(13,33) && quantity % 3 == 0 )
        rows = 3
      else
        puts "quantity: #{quantity}, can't be divided by 3" if Choice[:debug]
      end

      if ( quantity.between?(41,55) && quantity % 5 == 0 )
        rows = 5
      else
        puts "quantity: #{quantity}, can't be divided by 5" if Choice[:debug]
      end

      if ( quantity.between?(41,60) && quantity % 6 == 0 )
        rows = 6
      else
        puts "quantity: #{quantity}, can't be divided by 6" if Choice[:debug]
      end
    end

    if rows.nil?
      puts "quantity: #{quantity}, doesn't fit into rows"
      exit 1
    else
      return rows
    end
  end

  def create_collage(path, quantity, max_width, max_height, file_name)
    opts = get_opts(quantity, eval_quantity(quantity), max_width, max_height)
    list = Magick::ImageList.new(*get_rnd_files(path, quantity))
    output_list = resize_images(list, opts[:width], opts[:height])

    collage = output_list.montage do |mont|
      mont.geometry = "#{opts[:width] - 2}x#{opts[:height] - 2}+1+1"
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
