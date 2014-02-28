//
//  PlayingCard.h
//  Practice1
//
//  Created by Steve Chakif on 2/16/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card {
    
}

@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;
+ (NSArray *)validSuits;
+ (NSArray *)rankStrings;
+ (NSUInteger)maxRank;

@end
