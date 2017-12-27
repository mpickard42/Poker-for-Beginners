//
//  ResultsViewController.swift
//  Poker for Beginners
//
//  Created by Marjorie Pickard on 10/26/17.
//  Copyright © 2017 E&M. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    var cards : Array<Card>?
    var winningHand : Array<Card>?
    var winningValue = 0

    let STRAIGHT_FLUSH = 8000000 // + valueHighCard()
    let FOUR_OF_A_KIND = 7000000 // + Quads Card Rank
    let FULL_HOUSE = 6000000 // + SET card rank
    let FLUSH = 5000000 // + valueHighCard()
    let STRAIGHT = 4000000 // + valueHighCard()
    let SET = 3000000 // + Set card value
    let TWO_PAIRS = 2000000 // + High2*14^4+ Low2*14^2 + card
    let ONE_PAIR = 1000000 // + high*14^2 + high2*14^1 + low

    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var royalFlushLabel: UILabel!
    @IBOutlet weak var straightFlushLabel: UILabel!
    @IBOutlet weak var fourOfAKindLabel: UILabel!
    @IBOutlet weak var fullHouseLabel: UILabel!
    @IBOutlet weak var flushLabel: UILabel!
    @IBOutlet weak var straightLabel: UILabel!
    @IBOutlet weak var threeOfAKindLabel: UILabel!
    @IBOutlet weak var twoPairLabel: UILabel!
    @IBOutlet weak var onePairLabel: UILabel!
    @IBOutlet weak var highCardLabel: UILabel!
    @IBOutlet weak var probabilityLabel: UILabel!
    
    
    @IBOutlet weak var iv0: UIImageView!
    @IBOutlet weak var iv1: UIImageView!
    @IBOutlet weak var iv2: UIImageView!
    @IBOutlet weak var iv3: UIImageView!
    @IBOutlet weak var iv4: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        for card in cards! {
//            NSLog(String(card.cardValue))
//        }
        createHands()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createHands() {
        //Find all combinations of dealer cards
        var subCards = cards?.dropFirst()
        subCards = subCards?.dropFirst()
        let subHands = combinations(source: Array(subCards!), takenBy: 3)
        
        //Make array of possible combinations with pc0 and pc1 in the first two slots
        var hands : Array<Array<Card>> = []
        var k : Array<Card> = []
        for i in subHands {
            k = []
            k.append((cards?[0])!)
            k.append((cards?[1])!)
            for j in i{
                k.append(j)
            }
            hands.append(k)
        }
        
        findWinningHand(hands : hands)
    }
    
    func findWinningHand(hands : Array<Array<Card>>) {
        var tempValue = 0
        for hand in hands {
            tempValue = getValue(h: hand)
            if tempValue > winningValue {
                winningValue = tempValue
                winningHand = hand
            }
        }
        NSLog(String(winningValue))
        for i in winningHand! {
            NSLog(String(i.cardValue))
        }
        
        if(winningValue == 8576012){
            resultsLabel.text = "Best Hand: Royal Flush"
            royalFlushLabel.textColor = UIColor.red
            probabilityLabel.text = "The best possible straight flush which consists of the ace, king, queen, jack and ten of a suit. A royal flush is an unbeatable hand."
        }else if(winningValue >= 8000000) {
            resultsLabel.text = "Best Hand: Straight Flush"
            straightFlushLabel.textColor = UIColor.red
            probabilityLabel.text = "Five cards in numerical order, all of identical suits. In the event of a tie: Highest rank at the top of the sequence wins."
        }else if(winningValue >= 7000000) {
            resultsLabel.text = "Best Hand: Four of a Kind"
            fourOfAKindLabel.textColor = UIColor.red
            probabilityLabel.text = "Four cards of the same rank, and one side card or ‘kicker’. In the event of a tie: Highest four of a kind wins."
        }else if(winningValue >= 6000000) {
            resultsLabel.text = "Best Hand: Full House"
            fullHouseLabel.textColor = UIColor.red
            probabilityLabel.text = "Three cards of the same rank, and two cards of a different, matching rank. In the event of a tie: Highest three matching cards wins the pot."
        }else if(winningValue >= 5000000) {
            resultsLabel.text = "Best Hand: Flush"
            flushLabel.textColor = UIColor.red
            probabilityLabel.text = "Five cards of the same suit. In the event of a tie: The player holding the highest ranked card wins. If necessary, the second-highest, third-highest, fourth-highest, and fifth-highest cards can be used to break the tie. If all five cards are the same ranks, the pot is split."
        }else if(winningValue >= 4000000) {
            resultsLabel.text = "Best Hand: Straight"
            straightLabel.textColor = UIColor.red
            probabilityLabel.text = "Five cards in sequence. In the event of a tie: Highest ranking card at the top of the sequence wins."
        }else if(winningValue >= 3000000) {
            resultsLabel.text = "Best Hand: Three of a Kind"
            threeOfAKindLabel.textColor = UIColor.red
            probabilityLabel.text = "Three cards of the same rank, and two unrelated side cards. In the event of a tie: Highest ranking three of a kind wins."
        }else if(winningValue >= 2000000) {
            resultsLabel.text = "Best Hand: Two Pair"
            twoPairLabel.textColor = UIColor.red
            probabilityLabel.text = "Two cards of a matching rank, another two cards of a different matching rank, and one side card. In the event of a tie: Highest pair wins. If players have the same highest pair, highest second pair wins. If both players have two identical pairs, highest side card wins."
        }else if(winningValue >= 1000000) {
            resultsLabel.text = "Best Hand: One Pair"
            onePairLabel.textColor = UIColor.red
            probabilityLabel.text = "Two cards of a matching rank, and three unrelated side cards. In the event of a tie: Highest pair wins. If players have the same pair, the highest side card wins, and if necessary, the second-highest and third-highest side card can be used to break the tie."
        }else {
            resultsLabel.text = "Best Hand: High Card"
            highCardLabel.textColor = UIColor.red
            probabilityLabel.text = "Any hand that does not qualify under another category. In the event of a tie: Highest card wins, and if necessary, the second-highest, third-highest, fourth-highest and smallest card can be used to break the tie."
        }
        
        displayImages(winningHand:winningHand!)
    }
    
    func displayImages(winningHand : Array<Card>){
        let suits = ["*","D", "C", "H", "S"]
        let imageViews = [iv0, iv1, iv2, iv3, iv4]
        var imageName : String
        for i in 0..<winningHand.count {
            if (winningHand[i].rank == 14){
                imageName = ("A")
            }else if (winningHand[i].rank == 13){
                imageName = ("K")
            }else if (winningHand[i].rank == 12){
                imageName = ("Q")
            }else if (winningHand[i].rank == 11){
                imageName = ("J")
            }else{
                imageName = (String(winningHand[i].rank))
            }

            imageName.append(suits[winningHand[i].suit])
            
                        NSLog(imageName)
            imageViews[i]?.image = UIImage(named: imageName)
        }
    }
    
    func combinations<T>(source: [T], takenBy : Int) -> [[T]] {
        if(source.count == takenBy) {
            return [source]
        }
        
        if(source.isEmpty) {
            return []
        }
        
        if(takenBy == 0) {
            return []
        }
        
        if(takenBy == 1) {
            return source.map { [$0] }
        }
        
        var result : [[T]] = []
        
        let rest = Array(source.suffix(from: 1))
        let sub_combos = combinations(source: rest, takenBy: takenBy - 1)
        result += sub_combos.map { [source[0]] + $0 }
        
        result += combinations(source: rest, takenBy: takenBy)
        
        return result
    }
    
    func getValue(h : Array<Card>) ->  Int{
        if ( isFlush(h : h) && isStraight(h : h) ){
            return valueStraightFlush(h: h)
        }else if ( is4s(h : h) ) {
            return valueFourOfAKind(h : h)
        }else if ( isFullHouse(h : h) ){
            return valueFullHouse(h : h)
        }else if ( isFlush(h : h) ){
            return valueFlush(h : h)
        }else if ( isStraight(h:h) ){
            return valueStraight(h:h)
        }else if ( is3s(h:h) ) {
            return valueSet(h:h)
        }else if ( is22s(h:h) ) {
            return valueTwoPairs(h:h)
        }else if ( is2s(h:h) ){
            return valueOnePair(h:h)
        }else {
            return valueHighCard(h: h)
        }
    }
    
    /* -----------------------------------------------------
     valueStraightFlush(): return value of a Straight Flush hand
     
     value = STRAIGHT_FLUSH + valueHighCard()
     ----------------------------------------------------- */
    func valueStraightFlush( h : Array<Card> ) -> Int
    {
        NSLog("Straight Flush")
        return STRAIGHT_FLUSH + valueHighCard(h: h)
    }
    
    /* ---------------------------------------------
     isFlush(): true if h has a flush
     false otherwise
     --------------------------------------------- */
    func isFlush( h : Array<Card>) -> Bool
    {
        if h.count != 5  {
            return false
        }
        
        var h1 = sortBySuit(h : h)
        
        return h1[0].suit == h1[4].suit    // All cards has same suit
    }
    
    /* ---------------------------------------------
     isStraight(): true if h is a Straight
     false otherwise
     --------------------------------------------- */
    func isStraight( h : Array<Card> ) -> Bool {
        var testRank : Int
        
        if h.count != 5 {
            return false
        }
        
        var h1 = sortByRank(h : h)
        
        /* ===========================
         Check if hand has an Ace
         =========================== */
        if ( h1[4].rank == 14 ){
            /* =================================
             Check straight using an Ace
             ================================= */
            let a = h1[0].rank == 2 && h1[1].rank == 3 && h1[2].rank == 4 && h1[3].rank == 5
            let b = h1[0].rank == 10 && h1[1].rank == 11 && h1[2].rank == 12 && h1[3].rank == 13
            
            return ( a || b )
        }
        else{
            /* ===========================================
             General case: check for increasing values
             =========================================== */
            testRank = h1[0].rank + 1
            
            for i in 1 ..< 5 {
                if ( h1[i].rank != testRank ) {
                    return(false) // Straight failed...
                }
                
                testRank += 1
            }
            
            return true       // Straight found !
        }
    }
    
    /* ---------------------------------------------
     is4s(): true if h has 4 of a kind
     false otherwise
     --------------------------------------------- */
    func is4s( h : Array<Card> ) -> Bool
    {
        var a1 : Bool
        var a2 : Bool
        var h1 = h
        
        if h1.count != 5 {
            return false
        }
        
        
        h1 = sortByRank(h : h1);
        
        a1 = h1[0].rank == h1[1].rank && h1[1].rank == h1[2].rank && h1[2].rank == h1[3].rank
        
        a2 = h1[1].rank == h1[2].rank && h1[2].rank == h1[3].rank && h1[3].rank == h1[4].rank
        
        return a1 || a2
    }
    
    /* ---------------------------------------------------------
     valueFourOfAKind(): return value of a 4 of a kind hand
     
     value = FOUR_OF_A_KIND + 4sCardRank
     
     Trick: card h[2] is always a card that is part of
     the 4-of-a-kind hand
     There is ONLY ONE hand with a quads of a given rank.
     --------------------------------------------------------- */
    func valueFourOfAKind( h : Array<Card> ) -> Int
    {
        var h1 = sortByRank(h: h)
        NSLog("Four of A Kind")
        return FOUR_OF_A_KIND + h1[2].rank
    }

    
    func valueHighCard(h: Array<Card>) -> Int{
        var val : Int
        let h1 = sortByRank(h: h)
        val = h1[0].rank + 14*h1[1].rank + 14*14*h1[2].rank + 14*14*14*h1[3].rank + 14*14*14*14*h1[4].rank
        return val
    }
    
    /* ----------------------------------------------------
     isFullHouse(): true if h has Full House
     false otherwise
     ---------------------------------------------------- */
    func isFullHouse( h : Array<Card> ) -> Bool
    {
        var a1 : Bool
        var a2 : Bool
        var h1 = h
        
        if h.count != 5 {
            return false
        }
        
        h1 = sortByRank(h : h)
        
        //  x x x y y
        a1 = h1[0].rank == h1[1].rank && h1[1].rank == h1[2].rank && h1[3].rank == h1[4].rank
        
        //  x x y y y
        a2 = h1[0].rank == h1[1].rank && h1[2].rank == h1[3].rank && h[3].rank == h1[4].rank
        
        return a1 || a2
    }

    /* -----------------------------------------------------------
     valueFullHouse(): return value of a Full House hand
     
     value = FULL_HOUSE + SetCardRank
     
     Trick: card h[2] is always a card that is part of
     the 3-of-a-kind in the full house hand
     There is ONLY ONE hand with a FH of a given set.
     ----------------------------------------------------------- */
    func valueFullHouse( h : Array<Card> ) -> Int
    {
        var h1 = sortByRank(h : h)
        NSLog("Full House")
        return FULL_HOUSE + h1[2].rank
    }
    
    /* -----------------------------------------------------
     valueFlush(): return value of a Flush hand
     
     value = FLUSH + valueHighCard()
     ----------------------------------------------------- */
    func valueFlush( h : Array<Card> ) -> Int
    {
        NSLog("Flush")
        return FLUSH + valueHighCard(h : h)
    }

    /* -----------------------------------------------------
     valueStraight(): return value of a Straight hand
     
     value = STRAIGHT + valueHighCard()
     ----------------------------------------------------- */
    func valueStraight( h : Array<Card> ) -> Int
    {
        NSLog("Straight");
        return STRAIGHT + valueHighCard(h: h);
    }
    
    /* ----------------------------------------------------
     is3s(): true if h has 3 of a kind
     false otherwise
     
     **** Note: use is3s() ONLY if you know the hand
     does not have 4 of a kind
     ---------------------------------------------------- */
    func is3s( h : Array<Card>) -> Bool
    {
        var a1 : Bool
        var a2 : Bool
        var a3 : Bool
        var h1 = h
        
        if h1.count != 5 {
            return false
        }
        
        if ( is4s(h: h) || isFullHouse(h : h) ) {
            return false
        }       // The hand is not 3 of a kind (but better)
        
        /* ----------------------------------------------------------
         Now we know the hand is not 4 of a kind or a full house !
         ---------------------------------------------------------- */
        h1 = sortByRank(h: h);
        
        a1 = h1[0].rank == h1[1].rank && h1[1].rank == h1[2].rank
        
        a2 = h1[1].rank == h1[2].rank && h1[2].rank == h1[3].rank
        
        a3 = h1[2].rank == h1[3].rank && h1[3].rank == h1[4].rank
        
        return( a1 || a2 || a3 );
    }

    /* ---------------------------------------------------------------
     valueSet(): return value of a Set hand
     
     value = SET + SetCardRank
     
     Trick: card h[2] is always a card that is part of the set hand
     There is ONLY ONE hand with a set of a given rank.
     --------------------------------------------------------------- */
    func valueSet( h : Array<Card> ) -> Int
    {
        var h1 = sortByRank(h:h);
        NSLog("Three of a Kind");
        return SET + h1[2].rank
    }

    /* -----------------------------------------------------
     is22s(): true if h has 2 pairs
     false otherwise
     
     **** Note: use is22s() ONLY if you know the hand
     does not have 3 of a kind or better
     ----------------------------------------------------- */
    func is22s( h : Array<Card> ) -> Bool
    {
        var a1 : Bool
        var a2 : Bool
        var a3 : Bool
        var h1 = h
        
        if h.count != 5{
            return false
        }
        
        if ( is4s(h:h) || isFullHouse(h:h) || is3s(h:h) ){
            return false       // The hand is not 2 pairs (but better)
        }
        
        
        h1 = sortByRank(h:h)
        
        a1 = h1[0].rank == h1[1].rank && h1[2].rank == h1[3].rank
        
        a2 = h1[0].rank == h1[1].rank && h1[3].rank == h1[4].rank
        
        a3 = h1[1].rank == h1[2].rank && h1[3].rank == h1[4].rank
        
        return( a1 || a2 || a3 );
    }
    
    /* -----------------------------------------------------
     valueTwoPairs(): return value of a Two-Pairs hand
     
     value = TWO_PAIRS
     + 14*14*HighPairCard
     + 14*LowPairCard
     + UnmatchedCard
     ----------------------------------------------------- */
    func valueTwoPairs( h : Array<Card> ) -> Int
    {
        var val = 0;
        
        var h1 = sortByRank(h:h);
        
        if ( h1[0].rank == h1[1].rank && h1[2].rank == h1[3].rank ) {
            val = 14*14*h1[2].rank + 14*h1[0].rank + h1[4].rank
        }else if ( h1[0].rank == h1[1].rank && h1[3].rank == h1[4].rank ){
            val = 14*14*h1[3].rank + 14*h1[0].rank + h1[2].rank
        }else{
            val = 14*14*h1[3].rank + 14*h1[1].rank + h1[0].rank
        }
        
        NSLog("Two Pairs")
        return TWO_PAIRS + val
    }
    
    /* -----------------------------------------------------
     is2s(): true if h has one pair
     false otherwise
     
     **** Note: use is22s() ONLY if you know the hand
     does not have 2 pairs or better
     ----------------------------------------------------- */
    func is2s( h : Array<Card> ) -> Bool
    {
        var a1 : Bool
        var a2 : Bool
        var a3 : Bool
        var a4 : Bool
        var h1 = h
        
        if h.count != 5 {
            return false
        }
        
        if ( is4s(h:h) || isFullHouse(h:h) || is3s(h:h) || is22s(h:h) ){
            return false       // The hand is not one pair (but better)
        }
        
        
        h1 = sortByRank(h:h)
        
        a1 = h1[0].rank == h1[1].rank
        a2 = h1[1].rank == h1[2].rank
        a3 = h1[2].rank == h1[3].rank
        a4 = h1[3].rank == h1[4].rank
        
        return( a1 || a2 || a3 || a4 );
    }


    /* -----------------------------------------------------
     valueOnePair(): return value of a One-Pair hand
     
     value = ONE_PAIR
     + 14^3*PairCard
     + 14^2*HighestCard
     + 14*MiddleCard
     + LowestCard
     ----------------------------------------------------- */
    func valueOnePair( h : Array<Card> ) -> Int
    {
        var val = 0
        
        var h1 = sortByRank(h:h)
        
        if ( h1[0].rank == h1[1].rank ){
            val = 14*14*14*h1[0].rank + h1[2].rank + 14*h1[3].rank + 14*14*h1[4].rank
            
        }else if ( h1[1].rank == h1[2].rank ){
            val = 14*14*14*h1[1].rank + h1[0].rank + 14*h1[3].rank + 14*14*h1[4].rank
        }else if ( h1[2].rank == h1[3].rank ){
            val = 14*14*14*h1[2].rank + h1[0].rank + 14*h1[1].rank + 14*14*h1[4].rank
        }else{
            val = 14*14*14*h1[3].rank + h1[0].rank + 14*h1[1].rank + 14*14*h1[2].rank
        }
        
        NSLog("One Pair")
        return ONE_PAIR + val;
    }

    
    /* ===========================================================
     Helper functions
     =========================================================== */
    
    /* ---------------------------------------------
     Sort hand by rank:
     
     smallest ranked card first ....
     
     (Finding a straight is eaiser that way)
     --------------------------------------------- */

    func sortByRank(h : Array<Card>) -> Array<Card> {
        var min_j : Int
        var hmutable = h
        
        /* ---------------------------------------------------
         The selection sort algorithm
         --------------------------------------------------- */
        for i in 0 ..< hmutable.count {
            /* ---------------------------------------------------
             Find array element with min. value among
             h[i], h[i+1], ..., h[n-1]
             --------------------------------------------------- */
            min_j = i // Assume elem i (h[i]) is the minimum
            
            for j in i+1 ..< h.count {
                if hmutable[j].rank < hmutable[min_j].rank {
                    min_j = j // We found a smaller minimum, update min_j
                }
            }
            /* ---------------------------------------------------
             Swap a[i] and a[min_j]
             --------------------------------------------------- */
            let help = hmutable[i]
            hmutable[i] = hmutable[min_j]
            hmutable[min_j] = help
        }
        return hmutable
    }
    
    /* ---------------------------------------------
     Sort hand by suit:
     
     smallest suit card first ....
     
     (Finding a flush is eaiser that way)
     --------------------------------------------- */
    func sortBySuit( h : Array<Card> ) -> Array<Card>
    {
        var min_j : Int
        var hmutable = h
        
        /* ---------------------------------------------------
         The selection sort algorithm
         --------------------------------------------------- */
        for i in 0 ..< hmutable.count{
            /* ---------------------------------------------------
             Find array element with min. value among
             h[i], h[i+1], ..., h[n-1]
             --------------------------------------------------- */
            min_j = i;   // Assume elem i (h[i]) is the minimum
            
            for j in i+1 ..< hmutable.count{
                if hmutable[j].suit < hmutable[min_j].suit{
                    min_j = j;    // We found a smaller minimum, update min_j
                }
            }
            
            /* ---------------------------------------------------
             Swap a[i] and a[min_j]
             --------------------------------------------------- */
            let help = hmutable[i];
            hmutable[i] = hmutable[min_j];
            hmutable[min_j] = help;
        }
        return hmutable
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
