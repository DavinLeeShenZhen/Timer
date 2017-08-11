//
//  WindowsController.m
//  Timer
//
//  Created by lidapeng on 2017/8/10.
//  Copyright © 2017年 lidapeng. All rights reserved.
//

#import "WindowsController.h"

static NSInteger kTimeFontSize = 18;
static NSInteger kTimeFieldWidth = 90;

@interface WindowsController ()

@property NSTextField *timeField;
@property NSTimer *timer;

@end

@implementation WindowsController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    NSRect rc = NSMakeRect(0, 0, kTimeFieldWidth, kTimeFontSize);
    NSUInteger uiStyle = NSWindowStyleMaskBorderless | NSWindowStyleMaskResizable | NSWindowStyleMaskClosable;
    NSBackingStoreType backingStoreStyle = NSBackingStoreBuffered;
    NSWindow* win = [[NSWindow alloc] initWithContentRect:rc styleMask:uiStyle backing:backingStoreStyle defer:NO];
    [win setOpaque:NO];
    NSColor *semiTransparent = [NSColor colorWithWhite:1 alpha:0];
    [win setBackgroundColor:semiTransparent];
    win.titleVisibility = NSWindowTitleHidden;
    win.titlebarAppearsTransparent = YES;
    [win makeKeyAndOrderFront:win];
    [win setLevel:NSStatusWindowLevel];
    [win setCollectionBehavior: NSWindowCollectionBehaviorCanJoinAllSpaces];
    
    self.window = win;
    NSTextField *timeField = [[NSTextField alloc] initWithFrame:CGRectMake(0, 0, kTimeFieldWidth, kTimeFontSize)];
    timeField.selectable = NO;
    timeField.font = [NSFont systemFontOfSize:kTimeFontSize];
    timeField.alignment = NSTextAlignmentRight;
    
    timeField.bezeled         = NO;
    timeField.backgroundColor = [NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:0];
    
    self.timeField = timeField;
    
    [win.contentView addSubview:timeField];
    
    __weak typeof(self) ws = self;
    
    NSPoint pos;
    pos.x = [[NSScreen mainScreen] frame].size.width - [ws.window frame].size.width;
    pos.y = [[NSScreen mainScreen] frame].size.height - [ws.window frame].size.height;
    [ws.window setFrame:CGRectMake(pos.x, pos.y, [ws.window frame].size.width , [ws.window frame].size.height) display:YES];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSDate *date = [NSDate date];
        NSString *time = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];

        ws.timeField.stringValue = time;
        
        
    }];
    [self.timer fire];
    [NSApp run];
}

@end
