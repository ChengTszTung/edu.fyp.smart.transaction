//
//  InvoiceTableViewController.m
//  Smart Transaction
//
//  Created by TszTung Cheng on 13/12/13.
//  Copyright (c) 2013 1314-114102-02. All rights reserved.
//

#import "InvoiceTableViewController.h"
#import "InvoiceDetailViewController.h"
#import "Transaction.h"

@interface InvoiceTableViewController ()
@property (strong, nonatomic) NSMutableData* receivedData;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* transactions;
@end

@implementation InvoiceTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _receivedData = [[NSMutableData alloc]init];
    _transactions = [[NSMutableArray alloc]init];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(updateData:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self updateData:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_transactions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [[_transactions objectAtIndex:indexPath.row] dateTime];
    NSString *dateTime = [formatter stringFromDate:date];
    
    [cell.textLabel setText:dateTime];
    [cell.detailTextLabel setText:dateTime];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    InvoiceDetailViewController* vc = [segue destinationViewController];
    [vc setTransaction:[_transactions objectAtIndex:[[self.tableView indexPathForSelectedRow]row]]];
}

- (void)updateData:(id)sender
{
    _receivedData = [[NSMutableData alloc]init];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://127.0.0.1:8888/fyp/getTransaction.php?userId=AAA@BBB.COM"]];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_receivedData appendData:data]; //this is a NSMutableData
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *err;
    NSMutableArray* receivedArray = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingAllowFragments error:&err];
    
    if(err!=nil)
    {
        NSLog(@"Error!");
    } else {
        
        NSMutableArray* temp = [[NSMutableArray alloc]init];
        for (NSDictionary* tranDict in receivedArray){
            
            NSString *beginDateString  = [tranDict valueForKey:@"dateTime"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *beginDate = [formatter dateFromString:beginDateString];
            NSArray *transactionItems =[tranDict valueForKey:@"products"];
            
            Transaction* tran = [[Transaction alloc]initWithTranId:[[tranDict valueForKey:@"tranId"] integerValue] dateTime:beginDate transactionItems:transactionItems];
            [temp addObject:tran];
        }
        _transactions = temp;
        
        [self.tableView reloadData];
        
    }
    
    [self.refreshControl endRefreshing];
    
}




@end
