#
#  BranchProxy.rb
#  iGotGit
#
#  Created by John Smilanick on 11/4/08.
#  Copyright (c) 2008 Professional Aptitude Council. All rights reserved.
#

class BranchProxy < NSObject
  def self.from_array(branches)
    branches.collect{|b| bp = self.alloc.initWithBranch(b)}.to_ns
  end

  kvc_reader :name
  def initWithBranch(branch)
    if init
      @name = branch.name.to_ns
      return self
    end
  end
end
