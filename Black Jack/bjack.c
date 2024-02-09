#include "video.h"
#include "input.h"
#include "math.h"
#include "time.h"
#include "misc.h"
#include "string.h"

/*
NOTE:
Press X to get another card
Press Z to stand and see dealers hand

For the probability function, it calculates the chance you still have
of getting 21 so if it says you have a 100% chance of getting 21 it means
you still can get 21 not that the next card will give you 21. For example,
if your first two cards are 2 and 8 you still have a 100% chance of getting 21.
But if your first 2 cards were 10 and 2 than the chance of you getting 21
is slimmer because you could pull a card with value 10 and you would bust.
*/

// Texture Definitions in Cartridge
#define deck 0

// Regions in texture
#define card 1
#define back 60

struct cardnode
{
    bool Active;
    int Rcard;         // Card id to call for displaying
    int value;         // Value for each card
    cardnode* next;    // Pointer to the next card node
    cardnode* prev;    // Pointer to the previous card node
};

cardnode* currentCard = NULL; // Pointer to the currently displayed card
cardnode* [52]cards; // Deck of cards


// Function that adds new card node when called
cardnode* addCard(cardnode* current)
{
    // Dedicate memory for new card node
    cardnode* newCard = (cardnode*)malloc(sizeof(cardnode));

    //Initialize properties of card
    newCard->Active = true;
    newCard->next = NULL;
    newCard->prev = current;

    // Checks if current card has a next card
    if (current->next != NULL) {
        current->next->prev = newCard;
        newCard->next = current->next;
    }

    // Points to new card
    current->next = newCard;

    // Pointer to new card node is returned
    return newCard;
}

// Displays current player card
void displaycardPlayer(cardnode* current, int index)
{
    select_region(current->Rcard);

    // Sets the scale of cards
    set_drawing_scale(3, 3);

    // Where card is placed on X axis
    int X = 20 + index * 100;

    // Draws card at certain point on the screen
    draw_region_zoomed_at(X, 200);
}

// Displays current dealer card
void displaycardDealer(cardnode* current, int index)
{
    select_region(current->Rcard);

    // Sets the scale of cards
    set_drawing_scale(3, 3);

    // Where card is placed on X axis
    int X = 20 + index * 100;

    // Draws card at certain point on the screen
    draw_region_zoomed_at(X, 10);
}

// Function to calculate the probability of getting 21 for a given hand
int calculate21Probability(int currentIndex, int total)
{
    int remainingAces = 0; // Number of aces left in the deck that can help get hand to 21
    int remainingCards = 0; // Number of cards left in the deck that can help get hand to 21
    int targetValue = 21 - total; // needed value to get to 21

    // Adds 1 to either remainingace or card if the card can help the hand get 21
    for (int i = currentIndex + 1; i < 52; i++) {
        if (cards[i]->value == 11) {
            if (total + 11 <= 21 || total + 1 <= 21) {
                remainingAces++;
            }
        } else if (cards[i]->value <= targetValue) {
            remainingCards++;
        }
    }

    // Total number of cards that can make 21
    int totalPossibleCards = remainingAces + remainingCards;

    // Calculate the probability of getting 21 as a percentage
    int probabilityPercentage = (totalPossibleCards * 100) / (52 - currentIndex - 1);

    // Returns chance of getting 21 as percentage
    return probabilityPercentage;
}

// Start of main function
void main(void)
{
    // Setting up textures for deck and game
    select_texture(deck);

    int width = 32;  // Width of cards
    int height = 47; // Height of cards

    // Loop that selects card and defines their regions based on location in .png file
    for (int i = 1; i <= 52; i++) {
        select_region(i);

        define_region_topleft((i-1) * width,0, (i * width) - 1, height);
        if (i >= 14 && i <= 26)
        {
            define_region_topleft(((i-1) - 13) * width,48, ((i - 13) * width) - 1, height+48);
        }

        else if (i >= 17 && i <= 39)
        {
            define_region_topleft(((i-1) - 26) * width,96, ((i - 26) * width) - 1, height+96);
        }

        else if (i >= 30 && i <= 52)
        {
            define_region_topleft(((i-1) - 39) * width,144, ((i - 39) * width) - 1, height+144);
        }
    }

    srand(get_time()); // Seeds random number generator

    select_region(60); // Upside down card
    define_region_topleft(32,192, 64,241); // Location of upside down card in texture file


    // Values to be assigned to each card
    int[52] cardValues = {2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11,
                          2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11,
                          2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11,
                          2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11};


    // All cards before they are randomized
    int[52] cardOrder = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
                        16,17,18,19,20,21,22,23,24,25,26,27,28,
                        29,30,31,32,33,34,35,36,37,38,39,40,41,
                        42,43,44,45,46,47,48,49,50,51,52};


    // Fisher-Yates shuffle algorithm
    for (int i = 51; i > 0; i--) {
        // Generate a random index between 0 and i
        int j = rand() % (i + 1);

        // Swaps cardOrder[i] and cardOrder[j], cardValues[i] and cardValues[j]
        int temp = cardOrder[i];
        int temp2 = cardValues[i];
        cardOrder[i] = cardOrder[j];
        cardValues[i] = cardValues[j];
        cardOrder[j] = temp;
        cardValues[j] = temp2;
    }

    // Initialize the doubly linked list with the first card
    cardnode* firstCard = (cardnode*)malloc(sizeof(cardnode));
    firstCard->Active = true;
    firstCard->Rcard = cardOrder[0];
    firstCard->value = cardValues[0];
    firstCard->next = NULL;
    firstCard->prev = NULL;
    cards[0] = firstCard;
    currentCard = firstCard;


    // Add more cards and assign Rcard values
    for (int i = 1; i <= 51; i++) {
        currentCard = addCard(currentCard); // Adds new card node
        currentCard->Rcard = cardOrder[i];  // Assign the Rcard value
        currentCard->value = cardValues[i]; // Assign the card's value
        cards[i] = currentCard; // Adds currentCard to cards array
    }

    // Selects keyboard as gamepad to use for input
    select_gamepad(0);

    int Cindex = 0;    // Card index for player
    int Cindex2 = 0;   // Card index for dealer
    int Pscore = 0;    // Player score
    int Dscore = 0;    // Dealer score
    bool Dtemp = true; // Used in dealer logic
    int foundAce = 0;  // Number of aces for player
    int foundAce2 = 0; // Number of aces for dealer
    bool displayscore = false; // Used to display score at the end
    bool startscreen = true; // Used to start game

    bool changeView = false; // Enables underHood view

    // Adds value of shown cards to Pscore
    Pscore += cards[0]->value;
    Pscore += cards[1]->value;

    // If there are any aces shown for the first two cards than add 1 to foundAce
    if (cards[0]->value == 11 || cards[1]->value == 11)
    {
        foundAce++;
    }

    // Adds value of shown card to Dscore
    Dscore += cards[20]->value;

    // If there is an ace shown for the first card than add 1 to foundAce2
    if (cards[20]->value == 11)
    {
        foundAce2++;
    }

    // Start of game loop
    while (true)
    {
        // Background
        clear_screen(make_color_rgb(123, 172, 200));

        // Buttons for saying next card or stop
        bool hit = (gamepad_button_a() == 1);
        bool stand = (gamepad_button_b() == 1);

	// Button to go down to see logic
	bool underHood = (gamepad_down() == 1);

	// Takes you back to the game
	bool closeHood = (gamepad_up() == 1);

        //Button to start game
        bool StartGame = (gamepad_button_start() == 1);

        // If Enter is pressed than startscreen in nolonger displayed
        if (StartGame)
        {
            startscreen = false;
        }

        // If X is pressed than next card is shown and the value of that card is added to Pscore
        if (hit) {
            if (Cindex < 52)
            {
                 Pscore += cards[Cindex+2]->value; // Random card that is displayed is added to Pscore

                 // Logic for handling what value ace should be. if it should be 1 or 11
                 if (cards[Cindex+2]->value == 11)
                 {
                     foundAce++;
                 }
                 Cindex++;

                 if (Pscore > 21 && foundAce > 0)
                 {
                     Pscore -= 10;
                     foundAce --;
                 }
            }
        }

        // If Z is pressed than player is done and dealer goes
        if (stand)
        {
            // Loop continues till any of the bottom if cases are valid
            while (Dtemp)
            {
                if (Cindex2 < 51)
                {
                    Dscore += cards[Cindex2+21]->value; // Random card that is displayed is added to Dscore

                    // Logic for handling what value ace should be. if it should be 1 or 11
                    if (cards[Cindex2 + 21]->value == 11)
                    {
                        foundAce2++;
                    }
                    Cindex2++;

                    if (Dscore > 21 && foundAce2 > 0)
                    {
                        Dscore -= 10;
                        foundAce2--;
                    }
                }

                // Dealer stops drawing from deck if any of the cases are valid
                if (Dscore > Pscore || Dscore >= 21 || Pscore > 21)
                {
                    Dtemp = false;
                }

                displayscore = true;
            }
        }

	if (underHood)
	{
	    changeView = true;
	}

	if (closeHood)
	{
	    changeView = false;
	}

        // First two cards are displayed for player
        displaycardPlayer(cards[0], 0);
        displaycardPlayer(cards[1], 1);

        // Displays players card everytime Cindex increases. Means that player wants another card
        for (int i = 0; i <= Cindex; i++)
        {
            displaycardPlayer(cards[i+1], i+1); // Player card displayed
        }

        // Upside down card is displayed
        select_region(60);
        set_drawing_scale(3, 3);
        draw_region_zoomed_at(120, 10);

        // First card is displayed for dealer
        displaycardDealer(cards[20], 0);

        // Displays dealers card everytime Cindex2 increases. Means that dealer wants another card
        for (int i = 0; i <= Cindex2; i++)
        {
            displaycardDealer(cards[i+20], i); // Dealer card displayed
        }

        // Calling probability fuction for dealer and player
        int player21Probability = calculate21Probability(Cindex+2, Pscore);
        int dealer21Probability = calculate21Probability(Cindex+21, Dscore);

        // Start screen message
        if (startscreen)
        {
            print_at(300, 120, "Welcome To Black Jack!\nPress X if you would like\nanother card and Z\nif you want to stand!\nPress Enter to start!");
        }

        // Only displays chances if startscreen and end screen are not displayed
        if (!startscreen && !displayscore)
        {
            // Displays players chance of getting 21
            print_at(0,160, "Player chance of getting 21:");
            int[10] Pchance;
            itoa(player21Probability, Pchance, 10);
            print_at(280,160, Pchance);

            // Displays dealers chance of getting 21
            print_at(320,160, "Dealer chance of getting 21:");
            int[10] Dchance;
            itoa(dealer21Probability, Dchance, 10);
            print_at(600,160, Dchance);
        }

        // States the winner of that hand
        // When displayscore is true
        if (displayscore)
        {
            // If the dealer has a better hand
            if (Pscore > 21 || (Dscore <= 21 && Dscore > Pscore))
            {
                print_at(250, 160, "DEALER WINS");
            }

            // If the player has a better hand
            else if (Dscore > 21 || (Pscore <= 21 && Pscore > Dscore))
            {
                print_at(250, 160, "PLAYER WINS");
            }

            // If the dealer and player have the same hand
            else
            {
                print_at(250, 160, "DRAW");
            }
        }

	if (changeView)
	{
            // Background
            clear_screen(make_color_rgb(123, 172, 200));
	}

        end_frame();
    }
}
