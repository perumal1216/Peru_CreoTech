//
//  CustomLoader.m
//  Ezeego
//
//  Created by Puneet on 28/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomLoader.h"
#import <QuartzCore/QuartzCore.h>
@implementation CustomLoader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc
{
    [self.layer removeAllAnimations];
    [UIView commitAnimations];
//    appDelegate=nil;
//    [super dealloc];
}


-(void)loadView
{
    //(320-imgRot.size.width)/2, 400
    
    self.backgroundColor=[UIColor clearColor];
    
    UIImageView *imgBackLoader=[[UIImageView alloc]initWithFrame:self.frame];
    imgBackLoader.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.1];
    [self addSubview:imgBackLoader];
    UIImageView *imgIndecator=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CustomLoader.png"]];
    imgIndecator.frame=CGRectMake(0, 0, imgIndecator.image.size.width, imgIndecator.image.size.height);
    
    
    UIView *vw_Loader=[[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width-imgIndecator.image.size.width)/2, ((self.frame.size.height-imgIndecator.image.size.height)/2)-10, imgIndecator.image.size.width, imgIndecator.image.size.height)];
    vw_Loader.backgroundColor=[UIColor clearColor];
    [self addSubview:vw_Loader];
    [vw_Loader addSubview:imgIndecator];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [imgIndecator.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    NSString *strLoaderImg;
//    if([[appDelegate.navigationController.viewControllers objectAtIndex:1] isMemberOfClass:NSClassFromString(@"BookFlightViewController")])
        strLoaderImg=@"flightLoader.png";
//    else if([[appDelegate.navigationController.viewControllers objectAtIndex:1] isMemberOfClass:NSClassFromString(@"Bookhotelviewcontroller")])
//         strLoaderImg=@"hotelLoader.png";
//    else
//         strLoaderImg=@"HolidayLoader.png";
    
    UIImageView  *imgCentere=[[UIImageView alloc]initWithImage:[UIImage imageNamed:strLoaderImg]];
    imgCentere.frame=CGRectMake(imgIndecator.frame.origin.x+14, imgIndecator.frame.origin.y+14, imgCentere.image.size.width, imgCentere.image.size.height);
    [vw_Loader addSubview:imgCentere];
    
    [self performSelector:@selector(callLoader:) withObject:imgCentere afterDelay:0.3];
    
     vw_Loader.transform = CGAffineTransformMakeScale(0.1, 1); 
    [UIView animateWithDuration:0.30f 
                          delay:0.0f 
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^(void){vw_Loader.transform = CGAffineTransformMakeScale(1, 1);}
                     completion:^(BOOL finished){
                         
                         //Bounce
                         [UIView animateWithDuration:0.30f 
                                               delay:0.0f 
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^(void){vw_Loader.transform = CGAffineTransformMakeScale(0.8, 1);}
                                          completion:^(BOOL finished){
                                              [UIView animateWithDuration:0.3f 
                                                                    delay:0.0f 
                                                                  options:UIViewAnimationOptionCurveEaseOut 
                                                               animations:^(void){vw_Loader.transform = CGAffineTransformMakeScale(1, 1);}
                                                               completion:^(BOOL finished){
                            }];
                        }];
                     }];
    imgCentere=nil;
    imgIndecator=nil;
    imgBackLoader=nil;
    strLoaderImg=nil;
}
-(void)loadViewForPresentViewControllers
{
    //(320-imgRot.size.width)/2, 400
    
    self.backgroundColor=[UIColor clearColor];
    
    UIImageView *imgBackLoader=[[UIImageView alloc]initWithFrame:self.frame];
    imgBackLoader.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.1];
    [self addSubview:imgBackLoader];
    UIImageView *imgIndecator=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CustomLoader.png"]];
    imgIndecator.frame=CGRectMake(0, -160, imgIndecator.image.size.width, imgIndecator.image.size.height);
    
    
    UIView *vw_Loader=[[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width-imgIndecator.image.size.width)/2, ((self.frame.size.height-imgIndecator.image.size.height)/2)-10, imgIndecator.image.size.width, imgIndecator.image.size.height)];
    vw_Loader.backgroundColor=[UIColor clearColor];
    [self addSubview:vw_Loader];
    [vw_Loader addSubview:imgIndecator];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [imgIndecator.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    NSString *strLoaderImg;
    //    if([[appDelegate.navigationController.viewControllers objectAtIndex:1] isMemberOfClass:NSClassFromString(@"BookFlightViewController")])
    strLoaderImg=@"flightLoader.png";
    //    else if([[appDelegate.navigationController.viewControllers objectAtIndex:1] isMemberOfClass:NSClassFromString(@"Bookhotelviewcontroller")])
    //         strLoaderImg=@"hotelLoader.png";
    //    else
    //         strLoaderImg=@"HolidayLoader.png";
    
    UIImageView  *imgCentere=[[UIImageView alloc]initWithImage:[UIImage imageNamed:strLoaderImg]];
    imgCentere.frame=CGRectMake(imgIndecator.frame.origin.x+14, imgIndecator.frame.origin.y+14, imgCentere.image.size.width, imgCentere.image.size.height);
    [vw_Loader addSubview:imgCentere];
    
    [self performSelector:@selector(callLoader:) withObject:imgCentere afterDelay:0.3];
    
    vw_Loader.transform = CGAffineTransformMakeScale(0.1, 1);
    [UIView animateWithDuration:0.30f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^(void){vw_Loader.transform = CGAffineTransformMakeScale(1, 1);}
                     completion:^(BOOL finished){
                         
                         //Bounce
                         [UIView animateWithDuration:0.30f
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^(void){vw_Loader.transform = CGAffineTransformMakeScale(0.8, 1);}
                                          completion:^(BOOL finished){
                                              [UIView animateWithDuration:0.3f
                                                                    delay:0.0f
                                                                  options:UIViewAnimationOptionCurveEaseOut
                                                               animations:^(void){vw_Loader.transform = CGAffineTransformMakeScale(1, 1);}
                                                               completion:^(BOOL finished){
                                                               }];
                                          }];
                     }];
    imgCentere=nil;
    imgIndecator=nil;
    imgBackLoader=nil;
    strLoaderImg=nil;
}

-(void)callLoader:(UIButton *)btnRotate
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationRepeatCount:HUGE_VALF];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:btnRotate cache:YES];
    [UIView commitAnimations];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
