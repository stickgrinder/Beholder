# Script to watch a directory for any changes to a haml file
# and compile it.
#
# USAGE: ruby haml_watch.rb <directory_to_watch>
#
require 'rubygems'
require 'fssm'
require 'rainbow'

in_dir = ARGV.shift
out_dir = ARGV.shift

FSSM.monitor do

  path in_dir do
    glob '**/*.scss' 
    update do |base, relative|
      input = "#{base}/#{relative}"
      output = "#{out_dir}/#{relative.gsub!('.scss', '.css')}"
      command = "sass #{input} #{output}"
      %x{#{command}}
      puts "Regenerated SASS file #{input} to #{output}".foreground('#E600FF')
    end
  end

  path in_dir do 
    glob '**/*.haml'
    update do |base, relative|
      input = "#{base}/#{relative}"
      output = "#{out_dir}/#{relative.gsub!('.haml', '.html')}"
      command = "haml #{input} #{output}"
      %x{#{command}}
      puts "Regenerated HAML file #{input} to #{output}"
    end
  end
end
