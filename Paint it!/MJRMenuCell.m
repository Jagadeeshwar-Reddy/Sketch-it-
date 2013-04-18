//
//  MJRMenuCell.m
//  Paint it!
//
//  Created by Giriprasad Reddy on 18/04/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import "MJRMenuCell.h"

@implementation MJRMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
