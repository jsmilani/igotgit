#
#  MyDocument.rb
#  iGotGit
#
#  Created by John Smilanick on 11/1/08.
#  Copyright (c) 2008 Professional Aptitude Council. All rights reserved.
#


require 'osx/cocoa'

class GitDoc < OSX::NSDocument
  ib_outlet :git_window, :branch_list
  ib_outlet :log
  
  attr_reader :modal_window

  def windowNibName
    return "GitDoc"
  end
  
  #def saveDocumentAs(sender)
  #  NSLog('savedoc')
  #end
  
  #def hasUnautosavedChanges
  #  false
  #end

  def windowControllerDidLoadNib(aController)
    log("Opened: #{@git.dir.path}")
	  @git_window.setTitle(@git.dir.path)
  end
  
  def writeToURL_ofType_error(absoluteURL, typeName, outError)
    return true
  end
  
  
  def readFromURL_ofType_error(absoluteURL, typeName, outError)
    p 'readFromURL_ofType_error'
    @git = Git::Base.new(:working_directory => absoluteURL.path.to_s)
    return true
  end
  
  ib_action :refresh
  def refresh(sender)
    @branch_list.reloadData
    @git.status
  end
  
  ib_action :git_commit
  def git_commit(sender)
    
  end
  
  ib_action :git_push
  def git_push(sender)
    
  end
  
  ib_action :git_pull
  def git_pull(sender)
    
  end
  
  ib_action :git_stash
  def git_stash(sender)
    
  end
  
  ib_action :git_rebase
  def git_commit(sender)
    
  end
  
  ib_action :git_diff
  def git_diff(sender)
    
  end
  
  def git
    @git
  end
  
  kvc_reader :local_branches
  def local_branches
    BranchProxy.from_array(@git.branches.local)
  end
  
  kvc_reader :remote_branches
  def remote_branches
    BranchProxy.from_array(@git.branches.remote)
  end
  
  def log(message)
    @log.insertText(Time.now.to_s + "\n" + message + "\n\n")
  end
  
  ib_action :clear_log
  def clear_log(sender)
    @log.textStorage.setAttributedString(NSAttributedString.alloc.init)
  end
end
