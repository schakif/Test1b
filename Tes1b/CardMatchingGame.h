//
//  CardMatchingGame.h
//  Tes1b
//
//  Created by Steve Chakif on 2/27/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) int score;
@property (nonatomic) NSUInteger matchCount;

- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck matchCount:(NSUInteger)matchCount;
- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
