//
//  CardMatchingGame.m
//  Tes1b
//
//  Created by Steve Chakif on 2/27/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@end


@implementation CardMatchingGame

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck matchCount:(NSUInteger)matchCount{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
        self.matchCount = matchCount;
    }
    return self;
}

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}



- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (!card.isChosen) {
            NSMutableString *cardsString = nil;
            NSMutableArray *cardsToMatch = nil;
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    if (!cardsToMatch) {
                        cardsToMatch = [[NSMutableArray alloc] init];
                        [cardsToMatch addObject:card];
                        cardsString = [NSMutableString stringWithFormat: @"%@", card.contents];
                    }
                    
                    [cardsToMatch addObject:otherCard];
                    [cardsString appendFormat:@" %@", otherCard.contents];
                    
                    if (cardsToMatch.count == self.matchCount) {
                        break;
                    }
                }
            }
            
            if (cardsToMatch.count == self.matchCount) {
                int matchScore = 0;
                
                
                for (int i = 0; i < cardsToMatch.count; i++) {
                    NSRange range;
                    range.location = i + 1;
                    range.length = cardsToMatch.count - (i + 1);
                    matchScore += [[cardsToMatch objectAtIndex:i] match:[cardsToMatch subarrayWithRange:range]];
                }
                
                if (matchScore) {
                    for (Card *otherCard in cardsToMatch) {
                        otherCard.matched = YES;
                    }
                    
                    int points = matchScore * MATCH_BONUS;
                    self.score += points;
                    
                } else {
                    for (Card *otherCard in cardsToMatch) {
                        otherCard.chosen = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                }
            }
            self.score -= FLIP_COST;
        }
        card.chosen = !card.isChosen;
    }
}
 
 
- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}


@end
