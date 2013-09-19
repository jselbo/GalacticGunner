//
//  ViewController.m
//  Galactic Gunner
//
//  Created by Josh on 9/11/13.
//  Copyright (c) 2013 3iD. All rights reserved.
//

#import "ViewController.h"

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

#import "HomeScene.h"
#import "GameScene.h"

@interface ViewController ()

@property (strong, nonatomic) HomeScene *homeScene;
@property (strong, nonatomic) GameScene *gameScene;

@property (strong, nonatomic) CMMotionManager *motionManager;

@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 1.0/60.0;
        
        [self enableGyroscrope];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fadeButtons:YES];
    
    SKView *view = (SKView *)self.view;
    view.showsFPS = YES;
    
    _homeScene = [[HomeScene alloc] initWithSize:view.bounds.size];
    [view presentScene:_homeScene];
    
    [UIView animateWithDuration:0.5 delay:1 options:kNilOptions animations:^{
        [self fadeButtons:NO];
    } completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// private method
- (void)fadeButtons:(BOOL)fadeOut {
    if (fadeOut) {
        [_optionsButton setAlpha:0];
        [_highScoreButton setAlpha:0];
        [_startButton setAlpha:0];
    } else { // fade in
        [_optionsButton setAlpha:1];
        [_highScoreButton setAlpha:1];
        [_startButton setAlpha:1];
    }
}

- (void)presentGameScene {
    _gameScene = [[GameScene alloc] initWithSize:self.view.bounds.size];
    _gameScene.motionManager = _motionManager;
    
    SKTransition *transition = [SKTransition moveInWithDirection:SKTransitionDirectionDown duration:0.6];
    [(SKView *)self.view presentScene:_gameScene transition:transition];
}

- (void)enableGyroscrope {
    if (_motionManager.deviceMotionAvailable) {
        [_motionManager startDeviceMotionUpdates];
    } else {
        NSLog(@"No gyroscope available!");
    }
}

- (void)disableGryoscope {
    [_motionManager stopDeviceMotionUpdates];
}

- (IBAction)startPressed:(id)sender {
    [UIView animateWithDuration:0.4 animations:^{
        [self fadeButtons:YES];
    } completion:^(BOOL finished) {
        [self presentGameScene];
    }];
}

- (IBAction)optionsPressed:(id)sender {
}

- (IBAction)highScorePressed:(id)sender {
}

@end
