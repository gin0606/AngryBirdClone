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

        SKSpriteNode *bird = [SKSpriteNode spriteNodeWithImageNamed:@"bird.png"];
        bird.position = CGPointMake(50, 50);
        bird.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bird.frame.size];
        [self addChild:bird];

        SKNode *launchPad = [SKNode node];
        launchPad.position = bird.position;
        launchPad.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1, 1)];
        launchPad.physicsBody.dynamic = NO;
        [self addChild:launchPad];

        SKPhysicsJointPin *pin = [SKPhysicsJointPin jointWithBodyA:bird.physicsBody bodyB:launchPad.physicsBody anchor:launchPad.position];
        [self.physicsWorld addJoint:pin];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

@end
