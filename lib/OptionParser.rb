=begin
@author     Robert Waffen <rwaffen@gmail.com>

This code takes the options from the command line and returns an array of these options.
=end

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

  option :border, :required => false do
    short '-b'
    long '--border=BORDER'
    desc 'If there will be borders or not'
    cast Integer
    default 0
  end

  option :resolution, :required => false do
    short '-r'
    long '--resolution=RESOLUTION'
    desc 'Preset of resolutions.'
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
