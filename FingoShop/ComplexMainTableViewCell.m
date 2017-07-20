//
//  ComplexMainTableViewCell.m
//  YUTableViewDemo
//
//  Created by Yücel Uzun on 04/02/14.
//  Copyright (c) 2014 Yücel Uzun. All rights reserved.
//

#import "ComplexMainTableViewCell.h"
#import "ComplexItem.h"
@implementation ComplexMainTableViewCell

- (void) setCellContentsFromItem: (YUTableViewItem *) item
{
    ComplexItem * data  = (ComplexItem *) item.itemData;
    self.title.text     = data.name1;
    self.label.text     = data.explenation;
    
    if (item.status == YUTableViewItemStatusSubmenuOpened)
        self.title.font=[UIFont boldSystemFontOfSize:17];
    else
        self.title.font=[UIFont boldSystemFontOfSize:17];
}

@end
