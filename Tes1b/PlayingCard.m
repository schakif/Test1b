//
//  PlayingCard.m
//  Practice1
//
//  Created by Steve Chakif on 2/16/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (id otherCard in otherCards) {
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *) otherCard;
            score += [self matchPlayingCard:otherPlayingCard];
        }
    }
    
    return score;
}

- (int)matchPlayingCard:(PlayingCard *)otherPlayingCard {
    int score = 0;
    
    if ([otherPlayingCard.suit isEqualToString:self.suit]) {
        score = 1;
    } else if (otherPlayingCard.rank == self.rank) {
        score = 4;
    }
    
    return score;
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard  rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSUInteger) maxRank {
    return [[self rankStrings] count] - 1 ;
}

+ (NSArray *)validSuits {
    return @[@"♥️",@"♣️",@"♠️",@"♦️"];
}
- (NSString *)suit {
    return _suit ? _suit : @"?";
}


@end
