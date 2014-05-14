#import "ViewController.h"
#import "MyScene.h"

@interface ViewController ()

@property (nonatomic, strong) MyScene *myScene;

@end

@implementation ViewController

- (void)viewDidLayoutSubviews
{
    [super viewDidLoad];

    if (!self.myScene)
    {
        // Configure the view.
        SKView * skView = (SKView *)self.view;
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        MyScene * scene = [MyScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        self.myScene = scene;
        
        // Present the scene.
        [skView presentScene:scene];
    }
        
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)addSKPhysicsBody
{
    [self.myScene addSKPhysicsBody];
}

- (IBAction)invertGravity
{
    [self.myScene invertGravity];
}
@end
