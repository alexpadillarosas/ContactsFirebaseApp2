//
//  Contact.m
//  ContactsFirebaseApp1
//
//  Created by alex on 24/7/21.
//

#import "Contact.h"

@implementation Contact

- (instancetype)initWithName: (NSString*) name
                       email: (NSString*) email
                       phone: (NSString*) phone
                    position: (NSString*) position
                       photo: (NSString*) photo
                      autoId: (NSString*) autoId
{
    self = [super init];
    if (self) {
        _name = name;
        _email = email;
        _phone = phone;
        _position = position;
        _photo = [UIImage imageNamed: photo];
        _autoId = autoId;
    }
    return self;
}


- (instancetype)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    if (self) {
        _autoId = dictionary[@"autoId"];
        _name = dictionary[@"name"];
        _email = dictionary[@"email"];
        _phone = dictionary[@"phone"];
        _position = dictionary[@"position"];
        _photo = [UIImage imageNamed:dictionary[@"photo"]];
    }
    return self;
}

/** Method created to print out the content of a contact object */
-(NSString*) description{
    return  [NSString stringWithFormat:@"name: %@ email: %@ phone: %@ position: %@  photo: %@", _name, _email, _phone, _position, _photo] ;
}

@end
