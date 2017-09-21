//
//  Item.m
//  SearchImageApp
//
//  Created by DELL7447 on 9/20/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import "Item.h"

@implementation Item


- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}



- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.textInput = [decoder decodeObjectForKey: @"text_input"];
        self.urlImage = [decoder decodeObjectForKey: @"url_image"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.textInput forKey: @"text_input"];
    [encoder encodeObject:self.urlImage  forKey: @"url_image"];
}


@end
