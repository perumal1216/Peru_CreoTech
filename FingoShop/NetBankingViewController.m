//
//  NetBankingViewController.m
//  FingoShop
//
//  Created by kushal mandala on 26/08/16.
//  Copyright © 2016 fis. All rights reserved.
//

#import "NetBankingViewController.h"
#import "NetBankingCell.h"

@interface NetBankingViewController ()
@property(strong,nonatomic)NSMutableArray *bankListArr;
@end

@implementation NetBankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewNetBanking.delegate = self;
    self.tableViewNetBanking.dataSource = self;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.insideView1 addGestureRecognizer:tap];

    // Do any additional setup after loading the view.
}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//
//#pragma mark - Tableview Delegate Methods
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return [_bankListArr count];
//}
//
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NetBankingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartCell"];
//    if (cell == nil)
//    {
//        cell = [[NetBankingCell alloc]initWithFrame:CGRectZero];
//        cell.layer.borderWidth = 10;
//        cell.layer.borderColor = [[UIColor redColor]CGColor];
//    }
//    
//    
//    NSDictionary *dict = [_bankListArr objectAtIndex:indexPath.section];
//    NSLog(@"Item is: %@",dict);
//
//    cell.lblBankName.text = [dict objectForKey:@"item_title"];
//    
//    
//    
//    return cell;
//}
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}



-(void)dismissKeyboard {
    [self.bankCodeForNetBanking resignFirstResponder];
    [self.paymentTypeForNetBanking resignFirstResponder];
}
-(void)keyboardHideShowMethod{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [self.view addGestureRecognizer:singleTap];
    [self registerForKeyboardNotifications];
    
}
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //    NSDictionary* info = [aNotification userInfo];
    //    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    //    self.view.contentInset = contentInsets;
    //    self.startScreenScrollView.scrollIndicatorInsets = contentInsets;
    //
    //    // If active text field is hidden by keyboard, scroll it so it's visible
    //    // Your application might not need or want this behavior.
    //    CGRect aRect = self.view.frame;
    //    aRect.size.height -= kbSize.height;
    //    //    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
    //    //        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
    //    //        [self.startScreenScrollView setContentOffset:scrollPoint animated:YES];
    //    //    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    //    self.startScreenScrollView.contentInset = contentInsets;
    //    self.startScreenScrollView.scrollIndicatorInsets = contentInsets;
}

-(void)handleSingleTap{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    //    self.bankCodeForNetBanking.text = @"AXIB";
    self.paymentTypeForNetBanking.text = PAYMENT_PG_NET_BANKING;
    
    
}


- (void)PaymentByNetBanking:(NSString *)bankcode {
    self.paymentParam.bankCode = bankcode;
    self.createRequest = [PayUCreateRequest new];
    [self.createRequest createRequestWithPaymentParam:self.paymentParam forPaymentType:PAYMENT_PG_NET_BANKING withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        if (error == nil) {
            PayUUIPaymentUIWebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_UIWEBVIEW];
            webView.paymentRequest = request;
            [self.navigationController pushViewController:webView animated:true];
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"ERROR" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            
        }
    }];
}



#pragma TableView DataSource and Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.paymentRelatedDetail.netBankingArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_NETBANKING];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_NETBANKING];
    }
    
    PayUModelNetBanking *modelNetBanking = [PayUModelNetBanking new];
    modelNetBanking = [self.paymentRelatedDetail.netBankingArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = modelNetBanking.title;
    cell.detailTextLabel.text = modelNetBanking.bankCode;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PayUModelNetBanking *modelNetBanking = [PayUModelNetBanking new];
    modelNetBanking = [self.paymentRelatedDetail.netBankingArray objectAtIndex:indexPath.row];
    
    selectedBank = modelNetBanking.bankCode;//@"bankcode";
    [self PaymentByNetBanking:selectedBank];
    
    //    self.paymentTypeForNetBanking.text = modelNetBanking.//[NSString stringWithFormat:@"%ld",(long)indexPath.row];//@"NB";
}

- (IBAction)checkVAS:(id)sender {
    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
    
    [respo getVASStatusForCardBinOrBankCode:self.bankCodeForNetBanking.text withCompletionBlock:^(id ResponseMessage, NSString *errorMessage, id extraParam) {
        //
        if (errorMessage == nil) {
            //
            if (ResponseMessage == nil) {
                PAYUALERT(@"Yeahh", @"Good to Go");
            }
            else{
                NSString * responseMessage = [NSString new];
                responseMessage = (NSString *) ResponseMessage;
                PAYUALERT(@"Down Time Message", responseMessage);
            }
        }
        else{
            PAYUALERT(@"Error", errorMessage);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
