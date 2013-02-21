//
//  ViewController.m
//  TouchTest
//
//  Created by Peter Sundqvist on 12/20/12.
//  Copyright (c) 2012 Peter Sundqvist. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	date = [[NSDate date] retain];
	[self loop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loop {
	double elapsed = -[date timeIntervalSinceNow];
	frames++;
	
	if (elapsed > 0.5) {
		[fpsLabel setText:[NSString stringWithFormat:@"%f", frames / elapsed]];
		
		[date release];
		date = [[NSDate date] retain];
		frames = 0;
	}
	
	[self performSelector:@selector(loop) withObject:nil afterDelay:0];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self updateTouches:touches withEvent:event name:@"touchesBegan"];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self updateTouches:touches withEvent:event name:@"touchesMoved"];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self updateTouches:touches withEvent:event name:@"touchesEnded"];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self updateTouches:touches withEvent:event name:@"touchesCancelled"];
}

-(void)updateTouches:(NSSet*)touches withEvent:(UIEvent*)event name:(NSString*)name {
	if (![[NSThread currentThread] isMainThread])
		NSLog(@"Fail!");
	
	for (UITouch* t in touches) {
		CGPoint p = [t locationInView:self.view];
		NSLog(@"%@: (%f,%f) total: %d touch: %p", name, p.x, p.y, [event allTouches].count, t);
	}
	
	BOOL leftSelected = NO;
	BOOL rightSelected = NO;
	
	for (UITouch* t in [event allTouches]) {
		if (t.phase == UITouchPhaseEnded ||
			t.phase == UITouchPhaseCancelled)
			continue;
		
		CGPoint p = [t locationInView:self.view];
		
		if (p.x < 568/2)
			leftSelected = YES;
		else
			rightSelected = YES;
	}
	
	left.backgroundColor = leftSelected ? [UIColor greenColor] : [UIColor redColor];
	right.backgroundColor = rightSelected ? [UIColor greenColor] : [UIColor redColor];
}

- (void)dealloc {
	[left release];
	[right release];
	[super dealloc];
}
@end
