# Wallcollage

Pick randomly pictures from a directory path and join them to a 2560x1440 collage

# Installation

## Mac OS X

    brew install imagemagick
    brew install ghostscript
    gem install bundler
    bundle install --path vendor/gems

# Usage

    Usage: wallcollage2.rb [-qp]
        -q, --quantity                   quantity to include in the collage.
        -p, --path                       The path to the picture folder.


    bundle exec ruby wallcollage2.rb -q 10 -p /Users/Rob/Dropbox/Bilder/dump/2015

At the moment there are only standard values for a quantity of 10 and 40.
The images will be resized to fill a sub-resolution of the whole collage.
Best are images with width < height
This will conclude in a collage of 2560x1440. Pick the images from the out/ directory
