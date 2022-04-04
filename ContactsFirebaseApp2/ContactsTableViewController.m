//
//  ContactsTableViewController.m
//  ContactsFirebaseApp1
//
//  Created by alex on 25/7/21.
//

#import "ContactsTableViewController.h"
#import "FirestoreService.h"
#import "Contact.h"
#import "ContactTableViewCell.h"
#import "ContactDetailsTableViewController.h"


@interface ContactsTableViewController ()
    @property Contact* selectedContact;
@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Get an instance of the Firestore database
    self.firestore = [FIRFirestore firestore];
    // Inintialize the contactsDictionary that will serve as a datasource for our tableViewController
    _contactsDictionary = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    //create an instance of the service, and pass firestore db instance
    FirestoreService* service = [[FirestoreService alloc] init];
    [service setFirestore:[self firestore]];
    
    //    [service query];
    /*
        Here we are using a completion block
        https://developer.apple.com/documentation/foundation/nsoperation/1408085-completionblock?language=objc
        More explanaition
        https://medium.com/@amyjoscelyn/blocks-and-closures-in-objective-c-2b763e9e0dc8
     */
    [service findAll:^(NSMutableDictionary * _Nonnull dictionary) {
        if(dictionary != nil){
            for (NSString* key in dictionary) {
                [[self contactsDictionary] setObject:[dictionary objectForKey:key] forKey:key];
            }
        }
        [[self contactsTableView] reloadData];//This is a trick needed to display data in the TableView
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self contactsDictionary] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"ContactCell";
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(cell == nil){
        cell = [[ContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
//    [[cell textLabel] setText:@"Test"];
    //get the value from the dictionary
    NSString *contactId = [[self contactsDictionary] allKeys][ [indexPath row] ] ;
    NSLog(@"contactId: %@", contactId);
    
    //contactsArray is an Array Containing a dictionary in each element
    NSArray* contactsArray = [[self contactsDictionary] allValues];
    
    //Obtain a dictionary with all data for a contact ( name, position, email etc )
    NSDictionary* contactDictionary = [contactsArray objectAtIndex:[indexPath row]];
    
    //fill the contact in the cell, @name, @position and @photo must match the property names in your
    //firebase collection
    [[cell nameLabel] setText:[contactDictionary objectForKey:@"name"]];
    [[cell positionLabel] setText:[contactDictionary objectForKey:@"position"]];
    [[cell photoImageView] setImage:[UIImage imageNamed:[contactDictionary objectForKey:@"photo"]]];
    
    return cell;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger selectedRow = [indexPath row];
    NSString* key = [[self contactsDictionary] allKeys][selectedRow];
    NSMutableDictionary* contactDictionary = [[self contactsDictionary] objectForKey:key];
    _selectedContact = [[Contact alloc] initWithDictionary:contactDictionary];
    
    NSLog(@"%@", [self selectedContact]);
    return indexPath;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue destinationViewController] isKindOfClass:[ContactDetailsTableViewController class]]){
        ContactDetailsTableViewController* contactDetailsTableViewController = [segue destinationViewController];
        [contactDetailsTableViewController setContact:[self selectedContact]];
    }
}


@end
