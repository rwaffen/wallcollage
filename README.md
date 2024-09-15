# Wallcollage

Pick randomly pictures from a directory path and join them to a 2560x1440 collage

# Installation

## Mac OS X

### Prerequisites

    brew install imagemagick
    brew install ghostscript
    gem install bundler

### Main installation

    bundle config set path 'vendor'
    bundle config set with 'development'
    bundle install

### if rmagic wont compile

    brew unlink imagemagick
    brew install imagemagick@6 && brew link imagemagick@6 --force

## Arch Linux

sudo pacman -S imagemagick ghostscript
bundle config set path 'vendor'
bundle config set with 'development'
bundle install

# Usage

## Command parameters

    Usage: wallcollage2.rb [-qp]
        -q, --quantity    # The quantity to include in the collage.
        -p, --path        # The path to the picture folder.
        -w, --width       # The width of the collage. Defaults to 2560.
        -h, --height      # The height of the collage. Defaults to 1440.
        -r, --resolution  # Preset of resolutions.
        -d, --debug       # Activate to get some debug information.

The path cannot inlcude spaces in folder names!

## Example usage

    bundle exec ruby wallcollage2.rb -p /Users/Rob/Pictures/dump/ -q 19

    bundle exec ruby wallcollage2.rb -p /Users/Rob/Pictures/dump/ -q 10 -r 4k

    bundle exec ruby wallcollage2.rb -p /Users/Rob/Pictures/dump/ -q 10 -r mbp -d

    bundle exec ruby wallcollage2.rb -p /Users/Rob/Pictures/dump/ -q 10 -w 1024 -h 768

The images will be resize to fill a sub-resolution of the whole collage.
This will conclude in a collage of 2560x1440.
Pick the images from the out/ directory

# Supported Units

## Image formats

Support for jpg and png only. Preferred picture format should be portrait style. (Best are images with width < height)
