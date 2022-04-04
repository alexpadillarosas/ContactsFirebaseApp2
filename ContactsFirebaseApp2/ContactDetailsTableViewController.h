//
//  ContactDetailsTableViewController.h
//  ContactsFirebaseApp2
//
//  Created by alex on 5/4/2022.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactDetailsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;

@property Contact* contact;

@end

NS_ASSUME_NONNULL_END
