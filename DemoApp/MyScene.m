const uint32_t GOOD_GUYS    = 0x1 << 0;
const uint32_t BAD_GUYS     = 0x1 << 1;
const uint32_t EDGE         = 0x1 << 2;

#import "MyScene.h"

@interface MyScene () <SKPhysicsContactDelegate>

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor whiteColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect: self.frame];
        self.physicsBody.categoryBitMask = EDGE;
        self.physicsWorld.contactDelegate = self;
        
        // Create two obejects
        SKSpriteNode *badGuy = [SKSpriteNode spriteNodeWithColor: [SKColor redColor]
                                                            size: CGSizeMake(50.0, 50.0)];
        badGuy.position = CGPointMake(self.size.width * 0.5 + 20.0, 150.0);
        badGuy.name = @"badGuy";
        [self addChild: badGuy];
        
        SKSpriteNode *goodGuy = [SKSpriteNode spriteNodeWithColor: [SKColor greenColor]
                                                             size: CGSizeMake(50.0, 50.0)];
        goodGuy.position = CGPointMake(self.size.width * 0.5, 250.0);
        goodGuy.name = @"goodGuy";
        [self addChild: goodGuy];
    }
    return self;
}


- (void)addSKPhysicsBody
{
    for (SKSpriteNode *node in self.children)
    {
        node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: node.size];
        
        if ([node.name isEqualToString: @"badGuy"])
        {
            node.physicsBody.categoryBitMask = BAD_GUYS;
            node.physicsBody.collisionBitMask = EDGE | GOOD_GUYS;
            node.physicsBody.contactTestBitMask = GOOD_GUYS;
        }
        
        if ([node.name isEqualToString: @"goodGuy"])
        {
            node.physicsBody.categoryBitMask = GOOD_GUYS;
            node.physicsBody.collisionBitMask = EDGE | BAD_GUYS;
            node.physicsBody.contactTestBitMask = BAD_GUYS;
        }
    }
}


- (void)invertGravity
{
    if (self.physicsWorld.gravity.dy > 0)
    {
        self.physicsWorld.gravity = CGVectorMake(0.0, -9.8);
    }
    else
    {
        self.physicsWorld.gravity = CGVectorMake(0.0, 9.8);
    }
}

#pragma mark - SKPhysicsContactDelegate


- (void)didBeginContact: (SKPhysicsContact *)contact
{
    uint32_t bitMaskA = contact.bodyA.categoryBitMask;
    uint32_t bitMaskB = contact.bodyB.categoryBitMask;
    
    if (((bitMaskA & GOOD_GUYS) != 0 && (bitMaskB & BAD_GUYS)) != 0 ||
        ((bitMaskB & GOOD_GUYS) != 0 && (bitMaskA & BAD_GUYS)) != 0)
    {
        SKNode *goodGuy;
        SKNode *badGuy;
        if ([contact.bodyA.node.name isEqualToString: @"goodGuy"])
        {
            goodGuy = contact.bodyA.node;
            badGuy = contact.bodyB.node;
        }
        else
        {
            badGuy = contact.bodyA.node;
            goodGuy = contact.bodyB.node;
        }
        
        [badGuy removeFromParent];
    }
}

@end
