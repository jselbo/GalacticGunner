//
//  HomeScene.m
//  Galactic Gunner
//
//  Created by Josh on 9/11/13.
//  Copyright (c) 2013 3iD. All rights reserved.
//

#import "HomeScene.h"

@interface HomeScene ()

@property (nonatomic) BOOL contentLoaded;

@property (strong, nonatomic) SKLabelNode *titleNode;

@end

@implementation HomeScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    if (!_contentLoaded) {
        [self loadContent];
        _contentLoaded = YES;
    }
    
    [self performSelector:@selector(animateIntro) withObject:nil afterDelay:0.4];
}

// private method
- (void)loadContent {
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    _titleNode = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    _titleNode.fontColor = [SKColor whiteColor];
    _titleNode.fontSize = 48.0f;
    _titleNode.text = @"Galactic Gunner";
    
    _titleNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) + 200);
    
    [self addChild:_titleNode];
}

// private method
- (void)animateIntro {
    SKAction *moveDown = [SKAction moveByX: 0 y:-350 duration: 0.6];
    moveDown.timingMode = SKActionTimingEaseOut;
    
    [_titleNode runAction:moveDown];
}

@end
