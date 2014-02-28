//
//  Test1bViewController.m
//  Tes1b
//
//  Created by Steve Chakif on 2/27/14.
//  Copyright (c) 2014 Steve Chakif. All rights reserved.
//

#import "Test1bViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface Test1bViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) CardMatchingGame *game;

@end


@implementation Test1bViewController

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init] matchCount:2];
    }
    return _game;
}

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isChosen;
        cardButton.enabled = !card.isMatched;
        
        [cardButton setBackgroundImage:(cardButton.selected) ? [UIImage imageNamed:@"cardfront.png"] : [UIImage imageNamed:@"morback.png"] forState:UIControlStateNormal];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
}

- (IBAction)chooseCard:(UIButton *)sender {
    [self.game chooseCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
