//
//  GameScene.m
//  Galactic Gunner
//
//  Created by Josh on 9/11/13.
//  Copyright (c) 2013 3iD. All rights reserved.
//

#import "GameScene.h"

#import <CoreMotion/CoreMotion.h>

// in radians
#define ROLL_RANGE 0.3

@interface GameScene ()

@property (nonatomic) BOOL contentLoaded;

@property (strong, nonatomic) SKSpriteNode *shipSprite;
@property (strong, nonatomic) SKSpriteNode *bgSprite;

@property (strong, nonatomic) NSMutableArray *bulletSprites;

@property (nonatomic) BOOL touch;

@end

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    if (!_contentLoaded) {
        [self loadContents];
        _contentLoaded = YES;
    }
}

// private method
- (void)loadContents {
    self.backgroundColor = [SKColor whiteColor];
    self.physicsWorld.gravity = CGPointMake(0, 0);
    
    _bulletSprites = [NSMutableArray array];
    
    SKTexture *texture = [SKTexture textureWithImageNamed:@"lava_texture.jpg"];
    _bgSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    [self addChild:_bgSprite];
    
    _shipSprite = [SKSpriteNode spriteNodeWithImageNamed:@"ship_001.png"];
    _shipSprite.position = CGPointMake(CGRectGetMidX(self.frame), _shipSprite.size.height/2+8);
    [self addChild:_shipSprite];
}

- (void)updateShipPosition {
    CMAttitude *attitude = _motionManager.deviceMotion.attitude;
    double roll = attitude.roll;
    
    if (roll > ROLL_RANGE)
        roll = ROLL_RANGE;
    else if (roll < -ROLL_RANGE)
        roll = -ROLL_RANGE;
    
    double ratio = roll/ROLL_RANGE;
    
    // allowed range to scroll to left or right
    CGFloat midX = self.size.width/2;
    CGFloat xRange = (self.size.width - _shipSprite.size.width)/2;
    
    CGFloat destX = midX + (xRange*ratio);
    
    CGPoint pos = _shipSprite.position;
    pos.x = destX;
    _shipSprite.position = pos;
}

- (SKSpriteNode *)newBulletSprite {
    SKColor *color = [SKColor whiteColor];
    CGSize size = CGSizeMake(3, 8);
    SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithColor:color size:size];
    bullet.position = CGPointMake(_shipSprite.position.x, _shipSprite.position.y+_shipSprite.size.height/2);
    
    CGFloat speed = 600;
    SKPhysicsBody *physics = [SKPhysicsBody bodyWithRectangleOfSize:size];
    physics.velocity = CGVectorMake(0, speed);
    bullet.physicsBody = physics;
    
    return bullet;
}

- (void)processTouches {
    if (_touch) {
        SKSpriteNode *bullet = [self newBulletSprite];
        [self addChild:bullet];
        [_bulletSprites addObject:bullet];
        
        _touch = NO;
    }
}

- (void)cleanGarbage {
    NSMutableIndexSet *discards = [NSMutableIndexSet indexSet];
    
    NSUInteger index = 0;
    for (SKSpriteNode *bullet in _bulletSprites) {
        if (bullet.position.y > self.size.height+bullet.size.height) {
            [bullet removeFromParent];
            [discards addIndex:index]; // marked to be removed from array
        }
        index++;
    }
    
    [_bulletSprites removeObjectsAtIndexes:discards];
}

- (void)update:(NSTimeInterval)currentTime {
    [self updateShipPosition];
    
    [self processTouches];
    
    [self cleanGarbage];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    _touch = YES;
}

@end
