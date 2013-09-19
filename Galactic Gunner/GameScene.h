//
//  GameScene.h
//  Galactic Gunner
//
//  Created by Josh on 9/11/13.
//  Copyright (c) 2013 3iD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class CMMotionManager;

@interface GameScene : SKScene

@property (strong, nonatomic) CMMotionManager *motionManager;

@end
