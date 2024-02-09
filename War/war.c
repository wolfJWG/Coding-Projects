#include "video.h"
#include "input.h"
#include "math.h"
#include "time.h"
#include "misc.h"
#include "string.h"

/*
Welcome to the card game WAR!!
Use the enter key to play.

Changes:
Added logic for when player and robot have the same card.

Added a little message explaining how to see cards and how to start.

Now display the number of cards the player and robot have along with
a pointer to whos cards is whos.

Finally, added a message saying who won the game.
*/

// Texture Definitions in Cartridge
#define deck1 0

// Regions in texture
#define card1 1
#define back 60

struct cardnode
{
    int Rcard;         // Card id to call for displaying
    int value;         // Value for each card
    cardnode* next;    // Pointer to the next card node
    cardnode* prev;    // Pointer to the previous card node
};

struct deck
{
    cardnode* start;  // Pointer to the first card in the deck
    cardnode* end;    // Pointer to the last card in the deck
    int size;         // Size of the deck
};

struct queue {
    cardnode* front;  // Pointer to the front of the queue
    cardnode* rear;   // Pointer to the rear of the queue
    int size;         // Size of the queue
};

cardnode* currentCard = NULL; // Pointer to current card in use

// Function that creates and initializes a new deck structure
deck* createDeck()
{
    deck* newDeck = (deck*)malloc(sizeof(deck));
    newDeck->start = NULL;
    newDeck->end = NULL;
    newDeck->size = 0;
    return newDeck;
}

// Function that creates and initializes a new queue
queue* createQueue()
{
    queue* newQueue = (queue*)malloc(sizeof(queue));
    newQueue->front = newQueue->rear = NULL;
    newQueue->size = 0;
    return newQueue;
}

// Declarations of deck and queues
deck* myDeck;
queue* playerQueue;
queue* robotQueue;

// Function that adds a card to a given deck
void addCardToDeck(deck* d, int Rcard, int value)
{
    // Initializes cardnode
    cardnode* newCard = (cardnode*)malloc(sizeof(cardnode));
    newCard->Rcard = Rcard;
    newCard->value = value;
    newCard->next = NULL;
    newCard->prev = d->end;

    // If there aleardy is an end card, set its next to the newCard
    if (d->end != NULL)
    {
        d->end->next = newCard;
    }

    d->end = newCard; //Updating end of stack

    // If this is the first card set it as the start
    if (d->start == NULL)
    {
        d->start = newCard;
    }

    d->size++; // Increase size of the deck
}

// Function to enqueue a card to the end of a queue
void enqueue(queue* q, cardnode* card)
{
    card->next = NULL; // Sets next pointer to null

    // If the queue is empty than both front and rear are set to card
    if (q->front == NULL)
    {
        q->front = q->rear = card;
    }

    // If the queue is not empty than add new card to rear of queue
    else
    {
        q->rear->next = card;
        q->rear = card;
    }

    q->size++; // Increase queue size
}

// Function that dequeues a card from the front of a queue
cardnode* dequeue(queue* q)
{
    // If the queue is empty than it returns null
    if (q->front == NULL)
    {
        return NULL;
    }

    cardnode* card = q->front; // Gets card at front of queue
    q->front = card->next;     // Front pointer is updated to next card in the queue
    q->size--;                 // Size of queue is decreased
    return card;               // Returns dequeued card
}

// Function to populate a stack with a certian number of cards from a deck
void populateQueue(queue* q, deck* d, int numCards)
{
    for (int i = 0; i < numCards; i++)
    {
        if (d->start != NULL)
        {
            cardnode* poppedCard = d->start; // Get the first card from the deck
            d->start = d->start->next; // Changes decks start pointer to the next card
            enqueue(q, poppedCard); // Card is then enqueued into the queue
            d->size--; // Deck size is decreased
        }
    }
}

// Start of main function
void main(void)
{
    // Setting up textures for deck and game
    select_texture(deck1);

    int width = 32;  // Width of cards
    int height = 47; // Height of cards

    // Loop that selects card and defines their regions based on location in .png file
    for (int i = 1; i <= 52; i++)
    {
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

    //Defining back of card
    select_region(back);
    define_region_topleft(32,192, 64,241);

    srand(get_time()); // Seeds random number generator

    // Values to be assigned to each card
    int[52] cardValues = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
                          2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
                          2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
                          2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14};


    // All cards before they are randomized
    int[52] cardOrder = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
                        16,17,18,19,20,21,22,23,24,25,26,27,28,
                        29,30,31,32,33,34,35,36,37,38,39,40,41,
                        42,43,44,45,46,47,48,49,50,51,52};

    // Fisher-Yates shuffle algorithm
    for (int i = 51; i >= 0; i--)
    {
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

    myDeck = createDeck(); // Creates a new deck

    playerQueue = createQueue(); // Creates player queue
    robotQueue = createQueue();  // Creates robot queue

    // Loop to add cards to the deck
    for (int i = 0; i < 52; i++)
    {
        addCardToDeck(myDeck, cardOrder[i], cardValues[i]);
    }

    // Initialize currentCard with the start of the deck
    currentCard = myDeck->start;

    // Populating queues
    populateQueue(playerQueue, myDeck, 26);
    populateQueue(robotQueue, myDeck, 26);

    // Declarations of player and robot cards
    cardnode* playerCard;
    cardnode* robotCard;
    cardnode* playerCard2;
    cardnode* robotCard2;

    // Selects keyboard as gamepad to use for input
    select_gamepad(0);

    bool Wartest = false; // Used for if values are the same
    bool Startgame = true; // Used for starting game

    bool changeView = false; // Enables underHood view


    // Start of game loop
    while (true)
    {
        // Background
        clear_screen(make_color_rgb(123, 172, 200));

        // Button to compare player and robots card
        bool compare = (gamepad_button_start() == 1);

	// Button to go down to see logic
	bool underHood = (gamepad_down() == 1);

        // If enter is pressed than the following happens
        if (compare)
        {
            Startgame = false; // Startgame varaible is swiched to false

            // If both queues have a card and robot and player cards are not null the following happens
            if (playerQueue->size > 0 && robotQueue->size > 0 && playerCard != NULL && robotCard != NULL)
            {
                // Dequeue a card from player and robot queues
                playerCard = dequeue(playerQueue);
                robotCard = dequeue(robotQueue);

                // If player has a larger card than player wins
                if (playerCard->value > robotCard->value)
                {
                    // Transfer the card from robot to Player
                    enqueue(playerQueue, playerCard);
                    enqueue(playerQueue, robotCard);
                    Wartest = false; // Keeps Wartest as false
                }

                // If robot has a larger card than robot wins
                else if (playerCard->value < robotCard->value)
                {
                    // Transfer the card from Player to robot
                    enqueue(robotQueue, robotCard);
                    enqueue(robotQueue, playerCard);
                    Wartest = false; // Keeps Wartest as false
                }

                // If robot and player have same value cards
                else if (playerCard->value == robotCard->value)
                {
                    // Makes sure both can take part in a war
                    if (playerQueue->size >= 3 && robotQueue->size >= 3)
                    {
                        Wartest = true; // Swiches Wartest to true to display war

                        // Card from player and robot queues to compare for war
                        playerCard2 = dequeue(playerQueue);
                        robotCard2 = dequeue(robotQueue);

                        // 3 cards from each queue for war
                        cardnode* playerCard3 = dequeue(playerQueue);
                        cardnode* playerCard4 = dequeue(playerQueue);
                        cardnode* playerCard5 = dequeue(playerQueue);

                        cardnode* robotCard3 = dequeue(robotQueue);
                        cardnode* robotCard4 = dequeue(robotQueue);
                        cardnode* robotCard5 = dequeue(robotQueue);

                        // If they have the same cards again they are given back their cards
                        if (playerCard2->value == robotCard2->value)
                        {
                            enqueue(robotQueue, robotCard);
                            enqueue(robotQueue, robotCard2);
                            enqueue(robotQueue, robotCard3);
                            enqueue(robotQueue, robotCard4);
                            enqueue(robotQueue, robotCard5);

                            enqueue(playerQueue, playerCard);
                            enqueue(playerQueue, playerCard2);
                            enqueue(playerQueue, playerCard3);
                            enqueue(playerQueue, playerCard4);
                            enqueue(playerQueue, playerCard5);
                        }

                        // If player has a larger card than player wins
                        else if (playerCard2->value > robotCard2->value)
                        {
                            // Transfer the card from robot to Player
                            enqueue(playerQueue, playerCard);
                            enqueue(playerQueue, playerCard2);
                            enqueue(playerQueue, playerCard3);
                            enqueue(playerQueue, playerCard4);
                            enqueue(playerQueue, playerCard5);

                            enqueue(playerQueue, robotCard);
                            enqueue(playerQueue, robotCard2);
                            enqueue(playerQueue, robotCard3);
                            enqueue(playerQueue, robotCard4);
                            enqueue(playerQueue, robotCard5);
                        }

                        // If robot has a larger card than robot wins
                        else if (playerCard2->value < robotCard2->value)
                        {
                            // Transfer the card from Player to robot
                            enqueue(robotQueue, playerCard);
                            enqueue(robotQueue, playerCard2);
                            enqueue(robotQueue, playerCard3);
                            enqueue(robotQueue, playerCard4);
                            enqueue(robotQueue, playerCard5);

                            enqueue(robotQueue, robotCard);
                            enqueue(robotQueue, robotCard2);
                            enqueue(robotQueue, robotCard3);
                            enqueue(robotQueue, robotCard4);
                            enqueue(robotQueue, robotCard5);
                        }
                    }
                }
            }
        }

	if (underHood)
	{
	    changeView = true;
	}

        // Drawing back of card
        select_region(back);
        set_drawing_scale(1.5, 1.5);
        draw_region_zoomed_at(290, 25);
        draw_region_zoomed_at(290, 270);

        // Display cards for war
        if (Wartest)
        {
            // Player cards for war
            draw_region_zoomed_at(340, 100);
            draw_region_zoomed_at(390, 100);
            draw_region_zoomed_at(440, 100);

            // Robot cards for war
            draw_region_zoomed_at(340, 195);
            draw_region_zoomed_at(390, 195);
            draw_region_zoomed_at(440, 195);

            // Drawing player card for war
            select_region(playerCard2->Rcard);
            set_drawing_scale(1.5, 1.5);
            draw_region_zoomed_at(490, 100);

            // Drawing robot card for war
            select_region(robotCard2->Rcard);
            set_drawing_scale(1.5, 1.5);
            draw_region_zoomed_at(490, 195);
        }

        // Drawing player card
        select_region(playerCard->Rcard);
        set_drawing_scale(1.5, 1.5);
        draw_region_zoomed_at(290, 100);

        // Drawing robot card
        select_region(robotCard->Rcard);
        set_drawing_scale(1.5, 1.5);
        draw_region_zoomed_at(290, 195);

        // Start screen is displayed till enter is pressed
        if (Startgame)
        {
            print_at(10, 20, "Press enter to see cards!");
        }

        // If someone has 0 cards left than displays the winner
        if (playerQueue->size == 0 || robotQueue->size == 0)
        {
            if (playerQueue->size > robotQueue->size)
            {
                print_at(10, 20, "PLAYER WINS");
            }

            else
            {
                print_at(10, 20, "ROBOT WINS");
            }
        }

        // Formatting stuff for player
        int [10]temp2;
        itoa(playerQueue->size, temp2, 10);
        print_at(250, 115, temp2);
        print_at(30 , 115, "Player cards remaing:");
        print_at(120, 140, "Player Card ->");

        // Formatting stuff for robot
        int [10]temp;
        itoa(robotQueue->size, temp, 10);
        print_at(250, 210, temp);
        print_at(30, 210, "Robot cards remaing:");
        print_at(120, 235, "Robot Card ->");

	if (changeView)
	{
            // Background
            clear_screen(make_color_rgb(123, 172, 200));
	}



        end_frame();
    }
}
