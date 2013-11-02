//
//  ABMyScene.m
//  AngryBirdClone
//
//  Created by gin0606 on 2013/11/02.
//  Copyright (c) 2013年 gin0606. All rights reserved.
//

#import "ABMyScene.h"

#define kShotPos CGPointMake(50, 50)

@interface ABMyScene ()
@property(nonatomic, strong) SKSpriteNode *bird;
@property(nonatomic, strong) SKNode *mouseNode;
@end

@implementation ABMyScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        SKLabelNode *helloSpriteKit = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
        helloSpriteKit.text = @"Hello SpriteKit!";
        helloSpriteKit.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:helloSpriteKit];

        SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:@"ground.png"];
        ground.position = CGPointMake(CGRectGetMidX(self.frame), 0);
        ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.frame.size];
        ground.physicsBody.dynamic = NO;
        [self addChild:ground];

        self.bird = [SKSpriteNode spriteNodeWithImageNamed:@"bird.png"];
        self.bird.position = CGPointMake(50, 50);
        self.bird.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.bird.frame.size];
        [self addChild:self.bird];

        SKNode *launchPad = [SKNode node];
        launchPad.position = self.bird.position;
        launchPad.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1, 1)];
        launchPad.physicsBody.dynamic = NO;
        [self addChild:launchPad];

        SKPhysicsJointPin *pin = [SKPhysicsJointPin jointWithBodyA:self.bird.physicsBody bodyB:launchPad.physicsBody anchor:launchPad.position];
        [self.physicsWorld addJoint:pin];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [touch locationInNode:self];

    if ([self.bird containsPoint:touchPos]) {
        // birdを空中に留めていたjointを外す
        [self.bird.physicsBody.joints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SKPhysicsJoint *joint = obj;
            [joint.bodyB.node removeFromParent];
            [self.physicsWorld removeJoint:joint];
        }];

        // タッチ地点とbirdをくっつける
        self.mouseNode = [SKNode node];
        self.mouseNode.position = touchPos;
        self.mouseNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(1, 1)];
        self.mouseNode.physicsBody.dynamic = NO;
        [self addChild:self.mouseNode];

        SKPhysicsJointFixed *fixed = [SKPhysicsJointFixed jointWithBodyA:self.bird.physicsBody bodyB:self.mouseNode.physicsBody anchor:self.mouseNode.position];
        [self.physicsWorld addJoint:fixed];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPos = [touch locationInNode:self];

    // 発射地点から一定以上離れないようにする
    CGPoint shotPoint = kShotPos;
    CGPoint point = CGPointMake(touchPos.x - shotPoint.x, touchPos.y - shotPoint.y);
    float diff = sqrtf(point.x * point.x + point.y * point.y);
    if (diff > 30.f) {
        float radians = atan2f(point.y, point.x);

        CGPoint p = CGPointMake(shotPoint.x + 30.f, shotPoint.y);
        CGPoint r = CGPointMake(p.x - shotPoint.x, p.y - shotPoint.y);
        float cosa = cosf(radians);
        float sina = sinf(radians);
        float t = r.x;
        r.x = t * cosa - r.y * sina + shotPoint.x;
        r.y = t * sina + r.y * cosa + shotPoint.y;

        self.mouseNode.position = r;
    } else {
        self.mouseNode.position = touchPos;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // タッチとbirdのjointを外してbirdを飛ばす
    [self.mouseNode.physicsBody.joints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.physicsWorld removeJoint:obj];
    }];
    [self.mouseNode removeFromParent];

    // 発射角度計算して飛ばす
    CGPoint p = CGPointMake(50 - self.mouseNode.position.x, 50 - self.mouseNode.position.y);
    float radians = atan2f(p.y, p.x);
    CGPoint angle = CGPointMake(cosf(radians), sinf(radians));

    [self.bird.physicsBody applyForce:CGVectorMake(angle.x * 5000, angle.y * 5000)];
}


@end
