#
#  GitController.rb
#  iGotGit
#
#  Created by John Smilanick on 11/1/08.
#  Copyright (c) 2008 Professional Aptitude Council. All rights reserved.
#

require 'osx/cocoa'

class GitController < OSX::NSObject
  
  ib_outlet :log
  ib_outlet :clone_window, :clone_source, :clone_target_path
  
  def awakeFromNib
    unless @first_nib
	  @first_nib = true
	  NSBundle.loadNibNamed_owner("Git",self)
	end
  end
  
  def applicationDidFinishLaunching(aNotification)
	# auto update
	# test for git
	log('applicationDidFinishLaunching')
  end
  
  ib_action :begin_clone
  def begin_clone(sender)
    log 'begin_clone'
	NSApp.runModalForWindow(@clone_window)
  end
  
  ib_action :browse_target_clone
  def browse_target_clone(sender)
    log 'browse_target_clone'
	
    save_panel = NSSavePanel.savePanel
    save_panel.setTitle("Clone Directory")
    save_panel.setCanCreateDirectories(true)
    save_panel.setDirectory(NSHomeDirectory())
    result = save_panel.runModal
    if result == NSOKButton
      log(save_panel.filenames.first)
      @clone_target_path.setStringValue(save_panel.filenames.first)
    end
  end
  
  ib_action :do_clone
  def do_clone(sender)
    log 'do_clone'
	
    NSApp.stopModalWithCode(NSOKButton)
	@clone_window.orderOut(self)
	begin
	  Git.clone(@clone_source.stringValue,@clone_target_path.stringValue)
	  unless result = NSDocumentController.sharedDocumentController.openDocumentWithContentsOfURL_display_error(@clone_target_path.stringValue,true,error)
	    log('failed to open')
	  end
	rescue Git::GitExecuteError => e
	  alert = NSAlert.alloc.init
	  alert.setMessageText(e.message)
	  alert.setInformativeText('info')
	  alert.runModal
	  NSApp.runModalForWindow(@clone_window)
	end
  end
  
  ib_action :clone_cancel
  def clone_cancel(sender)
    NSApp.stopModalWithCode(NSCancelButton)
	@clone_window.orderOut(self)
  end
  
  ib_action :do_init
  def do_init(sender)
    log 'do_init'
  end
  
  def log(message)
    @log.insertText(Time.now.to_s + "\n" + message + "\n\n")
  end
  
  ib_action :clear_log
  def clear_log(sender)
    @log.textStorage.setAttributedString(NSAttributedString.alloc.init)
  end
  
end
