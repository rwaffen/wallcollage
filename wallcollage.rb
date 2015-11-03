require 'mini_magick'
require 'pp'

def get_date
  year  = rand(2010..2015)
  month = format('%02d', rand(01..12))
  return year, month
end

def get_rnd_files(date_array)
  year = date_array[0]
  month= date_array[1]
  Dir["/Users/Rob/Dropbox/Bilder/random/#{year}/#{year}-#{month}/*.jpg"]
end

def fill_file_list(file_list)
  rnd_list = Array.new
  file_list.each do |file|
   tmp = MiniMagick::Image.open(file)
    unless tmp.height < tmp.width
      rnd_list << file
    end
  end
end

def extend_list(array)
  tmp_list = fill_file_list(get_rnd_files(get_date))
  array += tmp_list
end

directory = fill_file_list(get_rnd_files(get_date))

if directory.length < 10
  directory = extend_list(directory)
end

directory = directory.sample(10)

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
