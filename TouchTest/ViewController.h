//
//  ViewController.h
//  TouchTest
//
//  Created by Peter Sundqvist on 12/20/12.
//  Copyright (c) 2012 Peter Sundqvist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
	IBOutlet UIView *left;
	IBOutlet UIView *right;
	IBOutlet UILabel *fpsLabel;
	NSDate* date;
	int frames;
}
@end
