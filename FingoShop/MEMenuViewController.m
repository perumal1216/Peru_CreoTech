// MEMenuViewController.m
// TransitionFun
//
// Copyright (c) 2013, Michael Enriquez (http://enriquez.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MEMenuViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "menuCell.h"
#import "ServiceConnection.h"
#import "SVProgressHUD.h"
#import "YUTableView.h"
#import "ComplexItem.h"
#include <stdlib.h>
#import "Constants.h"
#import "RATreeView.h"
#import "RADataObject.h"
#import "RATableViewCell.h"
#import "AppDelegate.h"

@interface MEMenuViewController ()<YUTableViewDelegate,RATreeViewDelegate, RATreeViewDataSource>


{
    NSInteger sectionVal,prevBtnVal;
    NSMutableArray *boolArray;
    NSArray *electronicsArr,*womenFashionArr,*menFashionArr,*artsArr,*babyKidsArr,*homeArr,*sportsArr,*booksArr,*offerArr;
    BOOL isLast;
}
@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) RATreeView *treeView;

@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *MenuIcons;
@property (weak, nonatomic) IBOutlet UITableView *tblMenu;
@property (nonatomic, strong) UINavigationController *transitionsNavigationController;
- (IBAction)btnHomeClicked:(id)sender;

@end

@implementation MEMenuViewController
AppDelegate *apdl_menu;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *cView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 200)];
    cView.backgroundColor = [UIColor redColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text = @"Perumal";
    [cView addSubview:label];
    
    apdl_menu=(AppDelegate *)[[UIApplication sharedApplication] delegate];

    [self loaddatafromURL];
    
    RATreeView *treeView = [[RATreeView alloc] initWithFrame:self.view.bounds];
    
    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.treeFooterView = [UIView new];
    treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
    
    
    [treeView reloadData];
    
    
    self.treeView = treeView;
    self.treeView.frame = self.view.bounds;
    self.treeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:treeView atIndex:0];
 
    [self.treeView registerNib:[UINib nibWithNibName:NSStringFromClass([RATableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([RATableViewCell class])];


    self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
    
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
}



/*RATreeView implementation */

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    int systemVersion = [[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue];
    if (systemVersion >= 7 && systemVersion < 8) {
        CGRect statusBarViewRect = [[UIApplication sharedApplication] statusBarFrame];
        float heightPadding = statusBarViewRect.size.height+self.navigationController.navigationBar.frame.size.height;
        self.treeView.scrollView.contentInset = UIEdgeInsetsMake(heightPadding, 0.0, 0.0, 0.0);
        self.treeView.scrollView.contentOffset = CGPointMake(0.0, -heightPadding);
    }
    
    self.treeView.frame = self.view.bounds;
    self.treeView.frame=CGRectMake(0, 66, self.view.frame.size.width-20, self.view.frame.size.height-65);
        
}




#pragma mark TreeView Delegate methods

- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item
{
    return 44;
}


- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item
{
    RATableViewCell *cell = (RATableViewCell *)[treeView cellForItem:item];
//    [cell setAdditionButtonHidden:NO animated:YES];
         [cell.additionButton  setSelected:YES];
    
}
- (void)setTreeFooterView:(UIView *)treeFooterView
{
    
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 200)];
    view.backgroundColor = [UIColor redColor];
    
    
    
}

- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item
{
    RATableViewCell *cell = (RATableViewCell *)[treeView cellForItem:item];
    [cell.additionButton  setSelected:NO];
//    [cell setAdditionButtonHidden:YES animated:YES];
}
- (void)treeView:(RATreeView *)treeView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowForItem:(id)item
{
    if (editingStyle != UITableViewCellEditingStyleDelete) {
        return;
    }
    
    RADataObject *parent = [self.treeView parentForItem:item];
    NSInteger index = 0;
    
    if (parent == nil) {
        index = [self.data indexOfObject:item];
        NSMutableArray *children = [self.data mutableCopy];
        [children removeObject:item];
        self.data = [children copy];
        
    } else {
        index = [parent.children indexOfObject:item];
        [parent removeChild:item];
    }
    
    [self.treeView deleteItemsAtIndexes:[NSIndexSet indexSetWithIndex:index] inParent:parent withAnimation:RATreeViewRowAnimationRight];
    if (parent) {
        [self.treeView reloadRowsForItems:@[parent] withRowAnimation:RATreeViewRowAnimationNone];
    }
}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item
{
    
    RADataObject *dataObject = item;
    
    NSInteger level = [self.treeView levelForCellForItem:item];
    NSInteger numberOfChildren = [dataObject.children count];
   // NSString *detailText = [NSString localizedStringWithFormat:@"Number of children %@", [@(numberOfChildren) stringValue]];
//    BOOL expanded = [self.treeView isCellForItemExpanded:item];
    
    RATableViewCell *cell = [self.treeView dequeueReusableCellWithIdentifier:NSStringFromClass([RATableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    NSString* catnameID = dataObject.name;
    
    NSArray *items = [catnameID componentsSeparatedByString:@"-"];   //take the one array for split the string
    
    NSString *categoryname=[items objectAtIndex:0];   //shows Description
    
    if ([categoryname isEqualToString:@"Home"] || [dataObject.children count]==0) {
        [cell setupWithTitle:categoryname detailText:@"" level:level additionButtonHidden:YES];
        
    }
    else {
        [cell setupWithTitle:categoryname detailText:@"" level:level additionButtonHidden:NO];
    }
    
    
    
    
    __weak typeof(self) weakSelf = self;
    cell.additionButtonTapAction = ^(id sender){
        if (![weakSelf.treeView isCellForItemExpanded:dataObject] || weakSelf.treeView.isEditing) {
            return;
        }
        RADataObject *newDataObject = [[RADataObject alloc] initWithName:@"Added value" children:@[]];
        [dataObject addChild:newDataObject];
        [weakSelf.treeView insertItemsAtIndexes:[NSIndexSet indexSetWithIndex:0] inParent:dataObject withAnimation:RATreeViewRowAnimationLeft];
        [weakSelf.treeView reloadRowsForItems:@[dataObject] withRowAnimation:RATreeViewRowAnimationNone];
    };
    
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.data count];
        
    }
    
        RADataObject *data = item;
        return [data.children count];
    
    
    
    
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    RADataObject *data = item;
    if (item == nil) {
        return [self.data objectAtIndex:index];
    }
    
    return data.children[index];
}


//[raobjectwithname:name childrens:[self chiderenwith:name]]

//
//subarraydict
//
//{
//    RADataObject,RADataObject
//
//
//}


//childarraywithdict
//
//example
//
//Kids
//{
//    raobject,raobject
//}



#pragma mark - Helpers


- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item
{
    RADataObject *dataObject=item;
    
//    [treeView deselectRowForItem:item animated:YES];

    NSLog(@"%@ item",dataObject.children);
    
    //BOOL expanded = [self.treeView isCellForItemExpanded:item];
    
    if([dataObject.name isEqualToString:@"Home"])
    {
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeTabBarController"];
        [self.slidingViewController resetTopViewAnimated:YES];

    }
        
    else if (dataObject.children.count>0) {
        
       
    }
    else
    {
        
        NSString* catnameID = dataObject.name;
        
        NSArray *items = [catnameID componentsSeparatedByString:@"-"];   //take the one array for split the string
        
        NSLog(@"name %@",[items objectAtIndex:0]);
        NSLog(@"Id %@",[items objectAtIndex:1]);
        NSLog(@"id %@", catnameID);
        
        
        if ([[items objectAtIndex:1] isEqual: @" Shirts & Polos"]){
            _WSConstSelectedCategoryID=[items objectAtIndex:2];
        }
        else{
            _WSConstSelectedCategoryID=[items objectAtIndex:1];
        }
        
       // _WSConstSelectedCategoryID=[items objectAtIndex:1];
        _WSConstScreenValue = @"SlideMenu";
//        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailNavigationController"];
//        [self.slidingViewController resetTopViewAnimated:YES];


        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeTabBarController"];
        [self.slidingViewController resetTopViewAnimated:YES];
        
    }
    
}

-(void)loaddatafromURL
{
    if(apdl_menu.net == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:apdl_menu.alertTTL message:apdl_menu.alertMSG delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    
    NSString *sessionid=[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"];

    

    
    NSString *url_str1=[NSString stringWithFormat:@"https://www.fingoshop.com/restconnect/index/categoriesmenu?SID=%@",sessionid];
    
    NSString *url_str = [url_str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:url_str];
    
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSMutableDictionary *Dic = [[NSMutableDictionary alloc] init];
    NSError *error;
    if (data) {
        Dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FINGOSHOP" message:@"Please check your Internet connection " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    
    //NSArray *arr=[Dic allKeys];
    NSArray *arrs=[Dic allValues];
    
    
    NSMutableDictionary *ddd1=[[NSMutableDictionary alloc]init];
    
    for (int h=0; h<arrs.count; h++) {
        
        NSMutableDictionary *mdict=[arrs objectAtIndex:h];
        
        NSMutableDictionary *chidrendict=[mdict objectForKey:@"children"];
        
        NSArray *childrenvalues=[chidrendict allValues];
        NSMutableArray *childrenMain=[[NSMutableArray alloc] init];
        
        
        
        for (int k=0; k<childrenvalues.count; k++) {
            
            
            NSMutableDictionary *ckdict=[childrenvalues objectAtIndex:k];
            
            
            if ([ckdict objectForKey:@"children"]) {
                
                NSMutableDictionary *kdict=[ckdict objectForKey:@"children"];
                
                if (kdict.count==0) {
                    // contains key
                    NSLog(@"dd");
                    
                }
                else
                {
                    NSArray *ssdarr=[kdict allValues];
                    NSMutableArray *sdict=[[NSMutableArray alloc] init];
                    
                    for (int j=0; j< ssdarr.count; j++) {
                        NSMutableDictionary *sdsdsdict=[ssdarr objectAtIndex:j];
                        NSString *str=[NSString stringWithFormat:@"%@-%@",[sdsdsdict objectForKey:@"name"],[sdsdsdict objectForKey:@"id"]];
                        
                        RADataObject *object = [RADataObject dataObjectWithName:str children:nil];
                        [sdict addObject:object];
                        
                    }
                    
                    [ddd1 setObject:sdict forKey:[NSString stringWithFormat:@"%@-%@",[ckdict objectForKey:@"name"],[ckdict objectForKey:@"id"]]];
                }
                
            }
            
        }
        
    }
    
    NSLog(@"%@",ddd1);
    
   // [ddd1 removeObjectForKey:];
    _childCatArr=[ddd1 mutableCopy];
    
    
    NSMutableDictionary *ddd=[[NSMutableDictionary alloc]init];
    
    
    for (int k=0; k<arrs.count; k++) {
        
        NSMutableDictionary *mdict=[arrs objectAtIndex:k];
        
        NSMutableDictionary *chidrendict=[mdict objectForKey:@"children"];
        
    
        
        NSArray *childrenvalues=[chidrendict allValues];
        NSLog(@"childrenValues :%@", childrenvalues);
        NSMutableArray *childrenMain=[[NSMutableArray alloc] init];
        
        
        for (int i=0; i<childrenvalues.count; i++) {
            
            
            NSMutableDictionary *cdict=[childrenvalues objectAtIndex:i];
            
            NSString *str=[NSString stringWithFormat:@"%@-%@",[cdict objectForKey:@"name"],[cdict objectForKey:@"id"]];
            
            NSArray *items = [str componentsSeparatedByString:@"-"];   //take the one array for split the string
            
//            NSString *str1=[items objectAtIndex:0];   //shows Description
//            if ([[items objectAtIndex:0]  isEqual: @"Girl Clothing"]){
//                [cdict removeObjectForKey:@"id"];
//            }
            
            RADataObject *object = [RADataObject dataObjectWithName:str children:[self childArr:str]];

            [childrenMain addObject:object];
            
        }
        
        NSLog(@"%@",childrenMain);
        
        [ddd setObject:childrenMain forKey:[NSString stringWithFormat:@"%@-%@",[mdict objectForKey:@"name"],[mdict objectForKey:@"id"]]];
        
        
      //  [mdict removeObjectForKey:@"578"];
        
    }
    
    
    NSLog(@"%@",ddd);
    
    
    _subCatArr=[ddd mutableCopy];
    
    
    
    NSMutableArray *arraymain=[[NSMutableArray alloc] init];
    
    RADataObject *object = [RADataObject dataObjectWithName:@"Home" children:nil];

    [arraymain addObject:object];

    
    for (int i=0; i<arrs.count; i++) {
        
        NSMutableDictionary *dict=[arrs objectAtIndex:i];
        
        NSString *str=[NSString stringWithFormat:@"%@-%@",[dict objectForKey:@"name"],[dict objectForKey:@"id"]];
        
        
        NSArray *items = [str componentsSeparatedByString:@"-"];   //take the one array for split the string
        
        NSString *str1=[items objectAtIndex:0];   //shows Description
        
        
        RADataObject *object = [RADataObject dataObjectWithName:str children:[self subCatArr:str]];
        
        
        [arraymain addObject:object];
        
        
    }
    
    NSLog(@"%@",arraymain);
    
    
    _mainCatArr=[arraymain mutableCopy];
    
    
    
    
    NSLog(@"%@",_mainCatArr);
    NSLog(@"%@",_subCatArr);
    NSLog(@"%@",_childCatArr);
    
    
    self.data=_mainCatArr;
    
}


-(NSArray *)childArr:(NSString *)str
{
    NSArray *childarr;
    
    if ([_childCatArr objectForKey:str]) {
        childarr=[_childCatArr objectForKey:str];
        
    }else
    {
        childarr=nil;
    }
    
    return childarr;
}

-(NSArray *)subCatArr:(NSString *)str
{
    NSArray *subCatArr;
    if ([_subCatArr objectForKey:str]) {
        subCatArr=[_subCatArr objectForKey:str];
        
    }else
    {
        subCatArr=nil;
    }
    
    return subCatArr;
}



@end
