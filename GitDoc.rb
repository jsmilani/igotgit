#
#  MyDocument.rb
#  iGotGit
#
#  Created by John Smilanick on 11/1/08.
#  Copyright (c) 2008 Professional Aptitude Council. All rights reserved.
#


require 'osx/cocoa'

class GitDoc < OSX::NSDocument
  ib_outlet :branch_list
  ib_outlet :log
  
  ib_outlet :modal_window

  def windowNibName
    return "GitDoc"
  end
  
  def saveDocumentAs(sender)
    log('savedoc')
  end
  
  def hasUnautosavedChanges
    false
  end

  def windowControllerDidLoadNib(aController)
    super_windowControllerDidLoadNib(aController)
	  @window.setTitle(@git.dir.path)
  end
  
  def fileWrapperRepresentationOfType(aType)
    return nil
  end
  
  
  def readFromURL_ofType_error(absoluteURL, typeName, outError)
    @git = Git::Base.new(absoluteURL.path.to_s)
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
  
  def log(message)
    @log.insertText(Time.now.to_s + "\n" + message + "\n\n")
  end
  
  ib_action :clear_log
  def clear_log(sender)
    @log.textStorage.setAttributedString(NSAttributedString.alloc.init)
  end
end
