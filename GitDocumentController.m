//
//  GitDocumentController.m
//  iGotGit
//
//  Created by John Smilanick on 11/2/08.
//  Copyright 2008 Professional Aptitude Council. All rights reserved.
//

#import "GitDocumentController.h"


@implementation GitDocumentController
- (NSString *)typeForContentsOfURL:(NSURL *)inAbsoluteURL error:(NSError **)outError {
  BOOL dir;
  if([[NSFileManager defaultManager] fileExistsAtPath:[inAbsoluteURL path] isDirectory: &dir] && dir)
    return @"GitRepo";
  else
    return [super typeForContentsOfURL:inAbsoluteURL error:outError];
}

- (IBAction)openDocument:(id)sender {
  //[[NSDocumentController sharedDocumentController] openDocument:self];
  //return;
  NSOpenPanel *open_panel = [NSOpenPanel openPanel];
  [open_panel setTitle:@"Open Git Repository"];
  [open_panel setCanChooseDirectories:YES];
  [open_panel setCanChooseFiles:NO];
  [open_panel setDelegate:self];
  int result = [open_panel runModal];
  if(result == NSOKButton) {
    NSError *error;
    NSDocument *doc = [self openDocumentWithContentsOfURL:[NSURL URLWithString:[[open_panel filenames] lastObject]] display:YES error:&error];
    if(!doc)
      return;
  }
}

/*- (IBAction)newDocument:(id)sender {
#  NSSavePanel *save_panel = [NSSavePanel savePanel];
#  [save_panel runModal];
#}*/
@end
