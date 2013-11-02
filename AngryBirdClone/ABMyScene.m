//
//  ABMyScene.m
//  AngryBirdClone
//
//  Created by gin0606 on 2013/11/02.
//  Copyright (c) 2013年 gin0606. All rights reserved.
//

#import "ABMyScene.h"

@implementation ABMyScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKLabelNode *helloSpriteKit = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
        helloSpriteKit.text = @"Hello SpriteKit!";
        helloSpriteKit.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:helloSpriteKit];

        SKLabelNode *helloPhysicsWorld = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
        helloPhysicsWorld.text = @"Hello physics world!";
        helloPhysicsWorld.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
        helloPhysicsWorld.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:helloPhysicsWorld.frame.size];
        [self addChild:helloPhysicsWorld];

        SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:@"ground.png"];
        ground.position = CGPointMake(CGRectGetMidX(self.frame), 0);
        ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.frame.size];
        ground.physicsBody.dynamic = NO;
        [self addChild:ground];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

@end
