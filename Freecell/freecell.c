#include "video.h"
#include "input.h"
#include "math.h"
#include "time.h"
#include "misc.h"
#include "string.h"

/*
NOTE:
Use the arrow keys to move around the pointer and the enter key
to grab and drop cards in desired location.

A card is in your hand when it appears in the bottom right of the screen.
*/

/*
Changes for cgf3:
Combined the displayStack and displayTopStack functions

Simplified Grabber and Dropper functions using arrays of stacks

Added logic to prevent random movement of cards in columns. Follows
the freecell rules.

Added suits to cards.

Added rules for putting cards in final positions.
*/

// Texture Definitions in Cartridge
#define deck1 0

// Regions in texture
#define card1 1
#define back 60

struct cardnode
{
    bool Active;
    int Rcard;         // Card id to call for displaying
    int value;         // Value for each card
    int suit;          // Suit of a card
    cardnode* next;    // Pointer to the next card node
    cardnode* prev;    // Pointer to the previous card node
};

struct deck
{
    cardnode* start;  // Pointer to the first card in the deck
    cardnode* end;    // Pointer to the last card in the deck
    int size;         // Size of the deck
};

struct stack
{
    deck* deckPtr;   // Pointer to the deck structure
    cardnode* top;   // Pointer to the top card in the stack
    int size;        // Size of the stack
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

// Function that creates and initializes a new stack structure given a deck
stack* createStack(deck* d)
{
    stack* newStack = (stack*)malloc(sizeof(stack));
    newStack->deckPtr = d;
    newStack->top = NULL;
    newStack->size = 0;
    return newStack;
}

deck* myDeck;

// Declarations of stacks
stack* Stack1;
stack* Stack2;
stack* Stack3;
stack* Stack4;
stack* Stack5;
stack* Stack6;
stack* Stack7;
stack* Stack8;
stack* UpperStack1;
stack* UpperStack2;
stack* UpperStack3;
stack* UpperStack4;
stack* UpperStack5;
stack* UpperStack6;
stack* UpperStack7;
stack* UpperStack8;
stack* Hand;

// Function that adds a card to a given deck
void addCardToDeck(deck* d, int Rcard, int value, int suit)
{
    // Initializes cardnode
    cardnode* newCard = (cardnode*)malloc(sizeof(cardnode));
    newCard->Active = true;
    newCard->Rcard = Rcard;
    newCard->value = value;
    newCard->suit = suit;
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

// Function to push card onto the stack
void push(stack* s, cardnode* card)
{
    card->next = s->top;  // Link the new card to the previous top
    s->top = card;        // Set the new card as the top
    s->size++;            // Increase the size of the stack
}

// Function to pop a card from the stack
cardnode* pop(stack* s)
{
    if (s->size == 0)
    {
        return NULL;  // Stack is empty
    }

    cardnode* topCard = s->top;
    s->top = topCard->next;  // Move the top pointer to the next card
    s->size--;               // Decrease the size of the stack
    return topCard;
}

// Function to populate a stack with a certian number of cards from a deck
void populateStack(stack* s, deck* d, int numCards)
{
    for (int i = 0; i < numCards; i++)
    {
        if (d->start != NULL)
        {
            cardnode* poppedCard = d->start; // Get the first card from the deck
            d->start = d->start->next; // Changes deck's start pointer to the next card
            push(s, poppedCard); // Card is than pushed onto stack
            d->size--; // Deck size is decreased
        }
    }
}

// Function to grab card from a stack and put in Hand stack based on pointer location
// Function is dependent on X an Y pointer location
void Grabber(int point, int pointY)
{
    // Arrays containing stacks and upperstacks
    stack* [8]stacks = {Stack1, Stack2, Stack3, Stack4, Stack5, Stack6, Stack7, Stack8};

    stack* [8]upperStacks = {UpperStack1, UpperStack2, UpperStack3, UpperStack4,
                             UpperStack5, UpperStack6, UpperStack7, UpperStack8};

    stack* currentStack;

    // If the pointer is at the bottom of the screen than looking at stacks
    if (pointY == 340)
    {
        currentStack = stacks[(point - 60) / 70];
    }

    // If the pointer is at the top of the screen than looking at upperstacks
    else
    {
        currentStack = upperStacks[(point - 60) / 70];
    }

    // If the selected stack is not empty than it can grab a card
    if (currentStack != NULL && currentStack->size != 0)
    {
        cardnode* topCard = pop(currentStack);
        push(Hand, topCard);
    }
}

// Function to determine if two cards have opposite colors
bool haveOppositeColors(cardnode* CARD1, cardnode* CARD2)
{
    // Determine the color of CARD1 based on its Rcard value
    bool isBlack1 = (CARD1->Rcard <= 13 || (CARD1->Rcard > 39 && CARD1->Rcard <= 52));

    // Determine the color of CARD2 based on its Rcard value
    bool isBlack2 = (CARD2->Rcard <= 13 || (CARD2->Rcard > 39 && CARD2->Rcard <= 52));

    // Cards have opposite colors if one is black and the other is red
    return (isBlack1 && !isBlack2) || (!isBlack1 && isBlack2);
}

// Funtion for checking a valid placment of a card in the final destination
bool isMoveValid(stack* upperStack, cardnode* card)
{
     // If the stack is empty, only Ace can be placed
    if (upperStack->size == 0)
    {
        return card->value == 1;
    }

    cardnode* topCard = upperStack->top;

    // Checks if suits are the same and the card being added is one higher than the current card
    return (topCard->suit == card->suit) && (topCard->value + 1 == card->value);
}

// Function to drop card that is in Hand stack to whatever stack the pointer is currently on
// Function is dependent on X an Y pointer location
// *Follows rules of freecell
void Dropper(int point, int pointY)
{
    // Arrays containing stacks and upperstacks
    stack*[8] stacks = {Stack1, Stack2, Stack3, Stack4, Stack5, Stack6, Stack7, Stack8};

    stack*[8] upperStacks = {UpperStack1, UpperStack2, UpperStack3, UpperStack4,
                             UpperStack5, UpperStack6, UpperStack7, UpperStack8};

    stack* currentStack;

    // If the pointer is at the bottom of the screen than looking at stacks
    if (pointY == 340)
    {
        currentStack = stacks[(point - 60) / 70];
    }

    // If the pointer is at the top of the screen than looking at upperstacks
    else
    {
        currentStack = upperStacks[(point - 60) / 70];
    }

    // Checks if a card is already in Hand
    if (Hand->size != 0)
    {
        // If pointer on final destination stacks
        if (currentStack == UpperStack1 || currentStack == UpperStack2 ||
            currentStack == UpperStack3 || currentStack == UpperStack4)
        {
            // Checks if the card can be dropped with the isMoveValid funtion and drops if so
            if (isMoveValid(currentStack, Hand->top))
            {
                cardnode* topCard = pop(Hand);
                push(currentStack, topCard);
            }
        }

        // If pointer is on freecell stacks
        else if (currentStack == UpperStack5 || currentStack == UpperStack6 ||
                 currentStack == UpperStack7 || currentStack == UpperStack8)
        {
            // Checks that the number of cards in currentStack is empty and drops if so
            if (currentStack->size < 1)
            {
                cardnode* topCard = pop(Hand);
                push(currentStack, topCard);
            }
        }

        // If pointer on stacks 1-8
        else
        {
            // Drops card if currentStack size is zero
            if (currentStack->size == 0)
            {
                cardnode* topCard = pop(Hand);
                push(currentStack, topCard);
            }

            // Drops card if they are opposite colors and the current card in hand is 1 less than the one it is being placed on
            else if (haveOppositeColors(Hand->top, currentStack->top) && Hand->top->value == currentStack->top->value - 1)
            {
                // Check if the colors are opposite and the value is one less
                cardnode* topCard = pop(Hand);
                push(currentStack, topCard);
            }
        }
    }
}

// Function to display all cards in a stack at speicific X and Y cords
void displayStack(stack* s, int X, int Y, bool LocationCheck)
{
    cardnode* current = s->top; // Start with the top card
    int stackSize = s->size;

    // Allocating memory for array to store card pointers
    cardnode** cardArray = (cardnode**)malloc(stackSize * sizeof(cardnode*));

    // cardArray is populated with card pointers from the stack
    int i = 0;
    while (current != NULL)
    {
        cardArray[i] = current;
        i++;
        current = current->next;
    }

    // Iterates through array in reverse order to display top card last
    for (i = stackSize - 1; i >= 0; i--)
    {
        // Selecting card to be displayed
        current = cardArray[i];
        select_region(current->Rcard);

        // Setting the draw size of a card
        set_drawing_scale(1.5, 1.5);

        if (LocationCheck)
        {
            // Draw location
            draw_region_zoomed_at(X, Y);
        }

        else
        {
            // Draw location
            draw_region_zoomed_at(X, Y);
            Y += 25; // Increase Y so cards dont display on top of another
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

    // Values to be assigned to each card
    int[52] cardValues = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1,
                          2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1,
                          2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1,
                          2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1};


    // All cards before they are randomized
    int[52] cardOrder = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
                        16,17,18,19,20,21,22,23,24,25,26,27,28,
                        29,30,31,32,33,34,35,36,37,38,39,40,41,
                        42,43,44,45,46,47,48,49,50,51,52};

    // Suit values to be assigned to each card
    int[52] suitValues = {0,0,0,0,0,0,0,0,0,0,0,0,0,
                          1,1,1,1,1,1,1,1,1,1,1,1,1,
                          2,2,2,2,2,2,2,2,2,2,2,2,2,
                          3,3,3,3,3,3,3,3,3,3,3,3,3};

    // Fisher-Yates shuffle algorithm
    for (int i = 51; i >= 0; i--) {
        // Generate a random index between 0 and i
        int j = rand() % (i + 1);

        // Swaps cardOrder[i] and cardOrder[j], cardValues[i] and cardValues[j],
        //       suitValues[i] and suitValues[j]
        int temp = cardOrder[i];
        int temp2 = cardValues[i];
        int temp3 = suitValues[i];
        cardOrder[i] = cardOrder[j];
        cardValues[i] = cardValues[j];
        suitValues[i] = suitValues[j];
        cardOrder[j] = temp;
        cardValues[j] = temp2;
        suitValues[j] = temp3;
    }

    myDeck = createDeck();  // Creates a new deck

    // Initialize upper and lower stacks
    Stack1 = createStack(myDeck);
    Stack2 = createStack(myDeck);
    Stack3 = createStack(myDeck);
    Stack4 = createStack(myDeck);
    Stack5 = createStack(myDeck);
    Stack6 = createStack(myDeck);
    Stack7 = createStack(myDeck);
    Stack8 = createStack(myDeck);
    UpperStack1 = createStack(myDeck);
    UpperStack2 = createStack(myDeck);
    UpperStack3 = createStack(myDeck);
    UpperStack4 = createStack(myDeck);
    UpperStack5 = createStack(myDeck);
    UpperStack6 = createStack(myDeck);
    UpperStack7 = createStack(myDeck);
    UpperStack8 = createStack(myDeck);

    // Holds card to move between stacks
    Hand = createStack(myDeck);


    // Loop to add cards to the deck
    for (int i = 0; i < 52; i++) {
        addCardToDeck(myDeck, cardOrder[i], cardValues[i], suitValues[i]);
    }

    // Initialize currentCard with the start of the deck
    currentCard = myDeck->start;

    // Stacks are populated with specific number of cards from myDeck
    populateStack(Stack1, myDeck, 7);
    populateStack(Stack2, myDeck, 8);
    populateStack(Stack3, myDeck, 7);
    populateStack(Stack4, myDeck, 7);
    populateStack(Stack5, myDeck, 6);
    populateStack(Stack6, myDeck, 5);
    populateStack(Stack7, myDeck, 6);
    populateStack(Stack8, myDeck, 6);

    // Selects keyboard as gamepad to use for input
    select_gamepad(0);

    int Pointer = 60;   // X axis pointer
    int PointerY = 340; // Y axis pointer
    int Move = 70;      // X movement speed
    int Vert = 270;     // Y movement speed

    // Start of game loop
    while (true)
    {
        // Background
        clear_screen(make_color_rgb(123, 172, 200));

        // Buttons to move cards between stacks
        bool rightStack = (gamepad_right() == 1);
        bool leftStack = (gamepad_left() == 1);
        bool Upperstacks = (gamepad_up() == 1);
        bool Lowerstacks = (gamepad_down() == 1);

        // Button to grab and drop card depending on pointer location
        bool holdcard = (gamepad_button_start() == 1);

        // Used to prevent from having more than one card in Hand stack
        bool EmptyHand = (Hand->size == 0);

        // Following 4 if statements are movement logic for pointer
        if (rightStack)
        {
            if (Pointer + Move <= 560)
            {
                Pointer += Move;
            }
        }

        if (leftStack)
        {
            if (Pointer - Move >= 60)
            {
                Pointer -= Move;
            }
        }

        if (Upperstacks)
        {
            if (PointerY - Vert >= 50)
            {
                PointerY -= Vert;
            }
        }

        if (Lowerstacks)
        {
            if (PointerY + Vert <= 360)
            {
                PointerY += Vert;
            }
        }

        // Hand logic
        if (holdcard)
        {
            // If the Hand stack is empty than grabs card based on pointer location
            if (EmptyHand)
            {
                Grabber(Pointer, PointerY);
            }

            // Else if the Hand stack is not empty than the current card in the Hand stack is dropped
            else
            {
                Dropper(Pointer, PointerY);
            }
        }

        // Calls the display functions to display stacks
        displayStack(Stack1, 40, 90, false);
        displayStack(Stack2, 110, 90, false);
        displayStack(Stack3, 180, 90, false);
        displayStack(Stack4, 250, 90, false);
        displayStack(Stack5, 320, 90, false);
        displayStack(Stack6, 390, 90, false);
        displayStack(Stack7, 460, 90, false);
        displayStack(Stack8, 530, 90, false);
        displayStack(UpperStack1, 40, 0, true);
        displayStack(UpperStack2, 110, 0, true);
        displayStack(UpperStack3, 180, 0, true);
        displayStack(UpperStack4, 250, 0, true);
        displayStack(UpperStack5, 320, 0, true);
        displayStack(UpperStack6, 390, 0, true);
        displayStack(UpperStack7, 460, 0, true);
        displayStack(UpperStack8, 530, 0, true);
        displayStack(Hand, 580, 280, true);

        // Prints "^" based on pointer X and Y location
        print_at(Pointer, PointerY,"^");

        end_frame();
    }
}
