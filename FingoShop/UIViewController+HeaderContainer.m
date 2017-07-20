//
//  UIViewController+HeaderContainer.m
//  FingoShop
//
//  Created by Perumal on 11/06/17.
//  Copyright © 2017 Perumal. All rights reserved.
//

#import "UIViewController+HeaderContainer.h"

@implementation UIViewController (HeaderContainer)
-(void)displayContentController:(UIViewController *)content
{
    [self addChildViewController:content];
  [content.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
    
}
-(void)hideContentController:(UIViewController *)content
{
    
    [content willMoveToParentViewController:nil];
    [content.view removeFromSuperview];

    [content removeFromParentViewController];
}
@end
/*
 // For Navigation Menu
 func displayContentController(content:UIViewController)
 {
 self.addChildViewController(content)
 content.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 64)
 self.view.addSubview(content.view)
 
 //        self.constrainViewEqual1(content.view)
 content.didMoveToParentViewController(self)
 
 }
 
 // Hide Controller
 func hideContentController(content:UIViewController)
 {
 
 content.willMoveToParentViewController(nil)
 content.view.removeFromSuperview()
 content.view.sendSubviewToBack(self.view)
 content.removeFromParentViewController()
 
 }
 
 
 */
