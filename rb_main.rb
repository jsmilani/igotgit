#
#  rb_main.rb
#  iGotGit
#
#  Created by John Smilanick on 11/1/08.
#  Copyright (c) 2008 Professional Aptitude Council. All rights reserved.
#

require 'osx/cocoa'
include OSX
ENV['PATH'] += ':/usr/local/git/bin'

# Add our lib directory to ruby search path

def rb_main_init
  path = OSX::NSBundle.mainBundle.resourcePath.fileSystemRepresentation
  rbfiles = Dir.entries(path).select {|x| /\.rb\z/ =~ x}
  rbfiles -= [ File.basename(__FILE__) ]
  rbfiles.each do |path|
    require( File.basename(path) )
  end
end

if $0 == __FILE__ then
  rb_main_init
  OSX.NSApplicationMain(0, nil)
end
