# Poker-for-Beginners
Created as a project for ELE 470 - Mobile Computing
Created by Elizabeth Stevens and Marjorie Pickard

Poker for Beginners aims to help the beginning Poker player find the best possible hand and learn the different hands and 
their rankings. The application is designed to be an in-game aid for users currently playing a game of Texas Hold'em style 
Poker and accepts  as user input a player’s cards and the dealer’s cards. The application then evaluates each possible 
combination of a five card hand using both of the user’s cards and outputs the best possible hand, its name (e.g. Flush, Full 
House, Two Pair, etc.), and its ranking in terms of possible outcome. A short description of the best hand is displayed as 
well, and explains what cards are needed to make that hand and what wins in the case of a tie.

# Page Navigation
After initial research, it was decided that the navigation would be completed using a navigation controller with several 
segues. A tab bar was also utilized to allow users to close the results page and card selection page. These navigation buttons 
were implemented using unwind segues. A clear cards button was also implemented on the home page to reset the page. The unwind 
segues and modal segues used were also modified to allow data to be passed both forwards and backwards. 

# Home Page
The home page contains seven card buttons and two buttons. The first button is the “Clear Cards” button at the top left in the 
navigation bar, and clears the currently selected cards. The second button, labeled “Show Me the Money!”, validates the user 
input to ensure that they have selected enough cards, and brings the user to the Results page, where the hands are evaluated. 

The seven card buttons are split into two categories, player cards and dealer cards. When the card button is pressed, the user 
is brought to the card selection page. Once the user has selected a card, the user is returned to the home page and the the 
button image changes to display the selected card. The user must select the two Player’s Cards and at least three Dealer’s 
Cards

# Card Selection
When the user clicks on Card button on the home page, they are brought to a separate card selection page.  This page consists 
of a multicomponent picker.  The user is able to select the rank [2,3,4,5,6,7,8,9,10,J,Q,K,A] and the suit [Diamonds, Hearts, 
Clubs, Spades] of their card.  This is saved as an array in the card selection page.  There are two navigation bar buttons at 
the top of the page.  The left, “Cancel” returns the user to the home page but does not return a card value.  The button on 
the right, “Select” also returns the user to the home page but also returns the value of the card currently selected on the 
picker.  

# Verification
Once the “Show Me The Money” button is pressed on the home page, the controller does certain data verifications.  It first 
checks that the two players cards are selected.  It then checks that at least three dealer cars have been chosen.  This is 
because in the first round of poker the dealer puts down three community cards, the second round adds one community card, 
and the last round adds another.  This app lets the user input 3, 4, or 5 dealer cards.  Then the program checks that none 
of the cards are duplicates.  If the inputted hands fails any of these tests, an alert message is generated to inform the 
user that the cards they selected could not be analyzed.  If the cards pass all of the tests, they are sent to the results 
page controller.  

# Algorithm
When the results page controller receives the user’s cards, they are stored in an array.  The first step is to identify all 
the possible hands that can be created from those cards.  If the user enters only five cards, there is only one possible 
hand.  However if the user enters six cards, there are four possible hands and if seven cards are entered, there are ten 
possible combinations.  A function creates every possible hand then stores them in an array of possible hands.  Another 
function loops through each possible hand and gives the hand a value.  This value is based off of the algorithm developed by 
Shun Y. Cheung at Emory University.  It determines the type of hand and then gives it a numerical rating based on the 
tiebreaker.  For example, a two pair will be given a higher value than a high card.  However if there is a tie, such as 
having only high card hands, the algorithm returns a higher value to the best high card hand.  The algorithm was written in 
Java so it had to be translated into Swift for use with this app.  The hand with the highest hand value is declared the 
“best hand” and is displayed on the results page.  

# Results page
The results page contains five image views and 12 text labels. The image views change to show the cards for the calculated 
best hand. The text label under the best hand changes based on the hand being shown (Flush, Straight, etc.). The next text 
label contains information based on the type of hand, including what cards the hand is comprised of and what happens in case 
of a tie. The remaining 10 labels contain the different types of hands in a vertical column sorted best to worst. Depending 
on the best calculated hand, the current hand type is highlighted in red to emphasize its rank.

# Testing
Phase 1 testing consisted of developer unit testing and edge case testing. The developers worked to input unexpected data 
and perform unexpected actions in an effort to find possible errors in the application. All testing was done with the 
simulator as the developers did not have access to a physical device at the time. The testing did not find any major errors. 

Phase 2 testing involved two independent testers using the app during a live poker game. Each independent tester used the 
application on the development computer with the simulator during one of the test games and reported their opinion on the 
application. Their comments were then taken into consideration. A test device was not used because all development was done 
assuming an iPhone 7 Plus was used, and this was unavailable to the developers. The testers found the use of computer and mouse to be awkward and slow during the game but both agreed that it would be much 
quicker to use the app on a phone.  One of the users also said that they found the results page to be slightly confusing.  
They did not understand the section at the bottom where there was a list of types of hands with the current hand written in 
red.  This was taken into consideration and the UI was modified slightly to make the type of hand more obvious.  
