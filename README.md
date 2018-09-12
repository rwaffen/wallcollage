# Wallcollage

Pick randomly pictures from a directory path and join them to a 2560x1440 collage

# Installation

## Mac OS X

### Prerequisites

    brew install imagemagick
    brew install ghostscript
    gem install bundler

### Main installation

    bundle install --path vendor/gems

### if rmagic wont compile

    brew unlink imagemagick
    brew install imagemagick@6 && brew link imagemagick@6 --force

# Usage

## Command parameters

    Usage: wallcollage2.rb [-qp]
        -q, --quantity                   quantity to include in the collage.
        -p, --path                       The path to the picture folder.

## Example usage

    bundle exec ruby wallcollage2.rb -p /Users/Rob/Pictures/dump/ -q 19

    bundle exec ruby wallcollage2.rb -p /Users/Rob/Pictures/dump/ -q 55

    bundle exec ruby wallcollage2.rb -p /Users/Rob/Pictures/dump/ -q 5

    bundle exec ruby wallcollage2.rb -p /Users/Rob/Pictures/dump/ -q 22

The images will be resize to fill a sub-resolution of the whole collage.
This will conclude in a collage of 2560x1440.
Pick the images from the out/ directory

# Supported Units

## Image formats

Support for jpg and png only. Preferred picture format should be portrait style. (Best are images with width < height)

## Quantity of images from 1 to 55

    not supported quantity
    2
    3
    4
    5
    6
    7
    8
    9
    10
    not supported quantity
    12
    not supported quantity
    14
    15
    16
    not supported quantity
    18
    not supported quantity
    20
    21
    22
    not supported quantity
    24
    25
    not supported quantity
    27
    28
    not supported quantity
    30
    not supported quantity
    32
    33
    not supported quantity
    35
    36
    not supported quantity
    not supported quantity
    39
    40
    not supported quantity
    42
    not supported quantity
    44
    45
    not supported quantity
    not supported quantity
    48
    49
    50
    51
    52
    not supported quantity
    54
    55
