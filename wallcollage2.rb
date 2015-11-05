require 'mini_magick'
require 'pp'

def get_rnd_files
  Dir["/Users/Rob/Dropbox/Bilder/dump/2015/*.jpg"]
end

directory = get_rnd_files.sample(10)

montage = MiniMagick::Tool::Montage.new
directory.each { |image| montage << image }
montage << '-background'
montage << 'none'
montage << '-geometry'
montage << '512x720'
montage << '-tile'
montage << '5x'
montage << Dir.pwd + "/out/#{SecureRandom.hex}.jpg"
montage.call
