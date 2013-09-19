//
//  ViewController.h
//  Galactic Gunner
//
//  Created by Josh on 9/11/13.
//  Copyright (c) 2013 3iD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *highScoreButton;
@property (weak, nonatomic) IBOutlet UIButton *optionsButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)startPressed:(id)sender;
- (IBAction)optionsPressed:(id)sender;
- (IBAction)highScorePressed:(id)sender;

@end
