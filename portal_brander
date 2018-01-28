#!/usr/bin/env ruby

# This script modified an rXg custom portal according to args.
#
# Example:

# get parsing, open3
require 'optparse'
require 'open3'

# args
puts ARGV.join('::')
active_color = '989898'
text_color = '989898'
background_color = '989898'
delete_screen = false
OptionParser.new do |opt|
  opt.on('-a', '--active-color [COLOR]', 'Active and hover color') {
    |o| active_color = o[0] == '#' ? o : '#' + o
  }
  opt.on('-t', '--text-color [COLOR]', 'Text color') {
    |o| text_color = o[0] == '#' ? o : '#' + o
  }
  opt.on('-b', '--background-color [COLOR]', 'Background color') {
    |o| background_color = o[0] == '#' ? o : '#' + o
  }
  opt.on('-d', '--[no-]delete-screendoor', 'Remove screendoor effect') {
    |o| delete_screen = o
  }
end.parse!
puts ARGV.join('::')
target = ARGV.pop
raise "Need to specify the target portal..." unless target

# var dict
target = target.chomp('/').rpartition('/')
puts target.join(':')
portal_path = (target[1].empty? ? '.' + (target[2] == '.' ? '' : '/' + target[2]) : target[0] + '/' + target[2]) + '/'
portal_name = (target[2] == '.' ? File.basename(Dir.getwd) : target[2])

# build and add stylesheet
stylesheet = <<-TXT
.uk-navbar-brand.uk-hidden-small img {
  height: 110%;
  width: auto;
  margin-top: .3em;
}
TXT

if text_color
  stylesheet += <<-TXT
.uk-navbar-toggle {
  color: #{text_color};
}

ul.rg-navbar-nav li > a {
  color: #{text_color} !important;
}
  TXT
end

if active_color
  stylesheet += <<-TXT
ul.rg-navbar-nav li > a:hover {
  color: #{active_color};
}

.rg-navbar-nav > li.uk-active > a {
  color: #{active_color} !important;
}

#rg-offcanvas ul > li > a:hover {
  color: #{active_color};
}
  TXT
end

if text_color
  stylesheet += <<-TXT
.uk-navbar-toggle {
  color: #{text_color};
}

ul.rg-navbar-nav li > a {
  color: #{text_color} !important;
}
  TXT
end

if background_color
  stylesheet += <<-TXT
.rg-navbar {
  background-color: #{background_color} !important;
}
  TXT
end

if delete_screen
  stylesheet += <<-TXT
.rg-cover-object {
  background-image: none;
}
  TXT
end

File.write(portal_path + 'stylesheets/portal_brand.css', stylesheet)
