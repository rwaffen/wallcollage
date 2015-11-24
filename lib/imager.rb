class Imager
  def create_blank_24
    f = Image.new(320, 480) { self.background_color = 'black' }

    12.times do
      f.write("tmp/#{SecureRandom.hex}.jpg")
    end

    list = Magick::ImageList.new(*Dir['tmp/*.jpg'])
    pp list

    collage = list.montage do |mont|
      mont.geometry = '1440x620+1+1'
      #mont.tile = '4x3'
      #mont.tile = '2x3'
    end

    collage.write('out/collage.jpg')

    Dir['tmp/*.jpg'].each do |file|
      File.delete file
    end
  end
end