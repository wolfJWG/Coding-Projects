#include "video.h"
#include "input.h"
#include "math.h"
#include "time.h"
#include "misc.h"

// Texture Definitions in Cartridge
#define BreakoutTexture 0

// Regions in texture
#define Ball 0
#define Brick 1
#define Paddle 2
#define Star 3
#define LgBall 4
#define LgPaddle 5

// Paddle speeds
#define PaddleSpeed 8
#define PaddleSpeedF 12
#define PaddleSpeedS 16
#define StarSpeed 4

//Bit Mask for features
#define FEATURE_1 (1 << 0)
#define FEATURE_2 (1 << 1)
#define FEATURE_3 (1 << 2)
#define FEATURE_4 (1 << 3)
#define FEATURE_5 (1 << 4)
#define FEATURE_6 (1 << 5)
#define FEATURE_7 (1 << 6)
#define FEATURE_8 (1 << 7)

// Stores active feature but is set to 0 to state no active feature
int featureMask = 0;

// selects specified feature
void OnFeature (int feature)
{
    featureMask |= (1 << feature);
}

// Basic state for paddles and balls
struct GameObject
{
    bool Active;
    int X, Y;          // Position on screen
    int Width, Height; // Size of hitbox for objects
};

struct BrickNode
{
    bool Active;
    int X, Y;          // Position on screen
    int Width, Height; // Size of hitbox for objects
    BrickNode* next;   // Pointer to the next brick node
};

// Start of main function
void main(void)
{
    // Setting up textures
    select_texture(BreakoutTexture);      // Selecting texture in cartridge

    select_region(Ball);                  // Designating region for ball
    define_region(65,0, 81,16, 73,8);     // Location in texture file

    select_region(Brick);                 // Designating region for Brick
    define_region(0,0, 64,16, 32, 8);     // Location in texture file

    select_region(Paddle);                // Designating region for Paddle
    define_region(0,17, 64,33, 32,26);    // Location in texture file

    select_region(Star);                  // Designating region for Star
    define_region(65,17, 81,32, 73,25);   // Location in texture file

    select_region(LgPaddle);              // Designating region for LgPaddle
    define_region(0,35, 128,67, 64,51);   // Location in texture file

    select_region(LgBall);                // Designating region for LgBall
    define_region(82,0, 114,32, 98, 16);  // Location in texture file

    // Control paddle
    select_gamepad(0);

    // Giving values to GameObject for Paddle
    GameObject Player;
    Player.Active = true;
    Player.Width = 64;
    Player.Height = 28;
    Player.X = screen_width / 2;
    Player.Y = 340;

    // Giving values to GamObject for BallMV
    GameObject BallMV;
    BallMV.Active = true;
    BallMV.Width = 8;
    BallMV.Height = 8;
    BallMV.X = screen_width / 2;
    BallMV.Y = screen_height / 2;

    // Giving values to GameObject for StarMV
    GameObject StarMV;
    StarMV.Active = true;
    StarMV.Width = 16;
    StarMV.Height = 16;
    StarMV.X = screen_width / 2;
    StarMV.Y = 0;

    // Brick linked list
    int size = 30; // Number of bricks displayed

    BrickNode* BrickList = NULL; // Linked list is initialize as empty

    // Create a linked list of bricks
    for (int i = 0; i < size; i++)
    {
        // Creates a new node for each brick
        BrickNode* newBrick = (BrickNode*)malloc(sizeof(BrickNode));
        newBrick->Active = true;
        newBrick->Width = 64;
        newBrick->Height = 32;

        // Setting location for bricks
        if (i == 0)
        {
            newBrick->X = 32;
            newBrick->Y = 8;
        }
        else if (i >= 1 && i < 10)
        {
            newBrick->X = (i * newBrick->Width) + 32;
            newBrick->Y = 8;
        }
        else if (i >= 10 && i <= 19)
        {
            newBrick->X = ((i - 10) * newBrick->Width) + 32;
            newBrick->Y = 28;
        }
        else
        {
            newBrick->X = ((i - 20) * newBrick->Width) + 32;
            newBrick->Y = 48;
        }

        // The new brick node is linked to existing list
        newBrick->next = BrickList;
        BrickList = newBrick; // Head of list is set to th new brick
    }

    // Ball direction and speed
    int BallDirectionX = 1;
    int BallDirectionY = 1;
    int BallSpeed = 2;   // Normal speed
    int BallSpeedF = 3;  // Medium Speed
    int BallSpeedS = 5;  // Fast speed

    int HitCount = 0;      // Keeps track of number of times ball hits brick
    srand(get_time());     // seeds random number generator
    bool Rbricks = false;  // Used for resetting bricks
    bool Hbricks = false;  // Used for halfing bricks
    int PrandomFeature = -1; // Temp veriable for non repeat randomFeature
    while (true)
    {
        // Background
        clear_screen(make_color_rgb(128, 100, 128));

        // Reads player input
        int DirectionX, DirectionY;
        gamepad_direction(&DirectionX, &DirectionY);

        if (Player.Active)
        {
            // Paddle Movement
            Player.X += PaddleSpeed * DirectionX;

            // Check for collision with paddle
            if (BallMV.X - BallMV.Width / 2 <= Player.X + Player.Width / 2 &&
                BallMV.X + BallMV.Width / 2 >= Player.X - Player.Width / 2 &&
                BallMV.Y - BallMV.Height / 2 <= Player.Y + Player.Height / 2 &&
                BallMV.Y + BallMV.Height / 2 >= Player.Y - Player.Height / 2)
            {
                BallDirectionY *= -1; // Reverse the Y direction when hitting the paddle
            };

            BrickNode* currentBrick = BrickList; // Creating pointer
            while (currentBrick != NULL)
            {
                if (currentBrick->Active)
                {
                    // Check for collision between ball and brick
                    if (BallMV.X - BallMV.Width / 2 <= currentBrick->X + currentBrick->Width / 2 &&
                        BallMV.X + BallMV.Width / 2 >= currentBrick->X - currentBrick->Width / 2 &&
                        BallMV.Y - BallMV.Height / 2 <= currentBrick->Y + currentBrick->Height / 2 &&
                        BallMV.Y + BallMV.Height / 2 >= currentBrick->Y - currentBrick->Height / 2)
                    {
                        // Collision detected with brick
                        currentBrick->Active = false;  // Deactivate the brick and is not displayed
                        BallDirectionY *= -1;          // Reverse the Y direction of the ball

                        HitCount++; // Hitcount increased by 1

                        if (HitCount >= 2)
                        {
                            // Spawn a new star
                            StarMV.Active = true;
                            StarMV.X = rand() % (screen_width); // Random x within the screen width
                            StarMV.Y = 0; // Start at the top of the screen
                            HitCount = 0; // Reset the counter
                        }

                    }
                }
                currentBrick = currentBrick->next; // Next node
            }
        }

        // Prevent paddles from leaving the screen
        Player.X = max(Player.X, Player.Width / 2);
        Player.X = min(Player.X, screen_width - Player.Width / 2);

        // Ball movement
        BallMV.X += BallSpeed * BallDirectionX;
        BallMV.Y += BallSpeed * BallDirectionY;

        // Prevent Ball from leaving the screen
        BallMV.X = max(BallMV.X, BallMV.Width / 2);
        BallMV.Y = max(BallMV.Y, BallMV.Height / 2);

        BallMV.X = min(BallMV.X, screen_width - BallMV.Width / 2);
        BallMV.Y = min(BallMV.Y, screen_height - BallMV.Height / 2);

        // Bounce off floor
        if (BallMV.Y >= screen_height - BallMV.Height)
        {
            // If ball hits the floor, reset to the center
            BallMV.X = screen_width / 2;
            BallMV.Y = screen_height / 2;
            BallDirectionX = 1; // Reset X direction
            BallDirectionY = 1; // Reset Y direction
        }

        if (BallMV.X <= BallMV.Width || BallMV.X >= screen_width - BallMV.Width)
        {
            BallDirectionX *= -1; // Reverse the X direction when hitting the screen boundary
        }

        if (BallMV.Y <= BallMV.Height || BallMV.Y >= screen_height - BallMV.Height)
        {
            BallDirectionY *= -1; // Reverse the Y direction when hitting the screen boundary
        }

        // Checks for collision between paddle and star
        if (Player.Active && StarMV.Active &&
            StarMV.X - StarMV.Width / 2 <= Player.X + Player.Width / 2 &&
            StarMV.X + StarMV.Width / 2 >= Player.X - Player.Width / 2 &&
            StarMV.Y + StarMV.Height / 2 >= Player.Y - Player.Height / 2)
        {
            // Collision detected with the star
            StarMV.Active = false; // Deactivate the star

            // If feature active then turn off feature
            if (featureMask != 0)
            {
                featureMask = 0;
            }

            int randomFeature;
            // Generate random number till randomFeature is not eqaul to PrandomFeature
            do {
                randomFeature = rand() % 8; // Generate a random number between 0 and 7
            } while (randomFeature == PrandomFeature);

            PrandomFeature = randomFeature; // Store current randomFeature

            OnFeature(randomFeature); // Random feature enabled
        }

        // If feature activated then mid fast paddle speed enabled
        if (featureMask & FEATURE_1)
        {
            Player.X += PaddleSpeedF * DirectionX;
            print_at(10, 335, "Mid Fast Paddle");
        }

        // If feature activated then mid fast ball speed enabled
        if (featureMask & FEATURE_2)
        {
            BallMV.X += BallSpeedF * BallDirectionX;
            BallMV.Y += BallSpeedF * BallDirectionY;
            print_at(10, 335, "Mid Fast Ball");
        }

        // If feature activated then super fast ball enabled
        if (featureMask & FEATURE_3)
        {
            BallMV.X += BallSpeedS * BallDirectionX;
            BallMV.Y += BallSpeedS * BallDirectionY;
            print_at(10, 335, "Fast Ball");
        }

        // If feature activated then super fast paddle enabled
        if (featureMask & FEATURE_4)
        {
            Player.X += PaddleSpeedS * DirectionX;
            print_at(10, 335, "Fast Paddle");
        }

        // If feature activted then paddle doubled in size
        if (featureMask & FEATURE_5)
        {
            Player.Width = 128;
            Player.Height = 35;
            select_region(LgPaddle);
            draw_region_at(Player.X, 340);
            print_at(10, 335, "Large Paddle");
        }
        else
        {
            Player.Width = 64;
            Player.Height = 28;
            select_region(Paddle);
            draw_region_at(Player.X, 340);
        }

        // If feature activted then ball doubled in size
        if (featureMask & FEATURE_6)
        {
            BallMV.Width = 20;
            BallMV.Height = 20;
            select_region(LgBall);
            draw_region_at(BallMV.X, BallMV.Y);

            print_at(10, 335, "Large Ball");
        }
        else
        {
            BallMV.Width = 16;
            BallMV.Height = 16;
            select_region(Ball);
            draw_region_at(BallMV.X, BallMV.Y) ;
        }

        // If feature activated then all bricks set to active
        if (featureMask & FEATURE_7)
        {
            if (!Rbricks) // On until Rbricks is true
            {
                // Loops through linked list and activates bricks
                BrickNode* currentBrick = BrickList;
                while (currentBrick != NULL)
                {
                    currentBrick->Active = true;
                    currentBrick = currentBrick->next;
                }
                print_at(10, 335, "Reset Bricks");
                Rbricks = true;
            }
        }

        // If feature activated then half the bricks disappear
        if (featureMask & FEATURE_8)
        {
            if (!Hbricks) // On until Hbricks is true
            {
                // Loops through linked list and deactivates hall the bricks
                BrickNode* currentBrick = BrickList;
                int count = 0;
                while (currentBrick != NULL)
                {
                    if (count % 2 == 0)
                    {
                        currentBrick->Active = false;
                    }
                    currentBrick = currentBrick->next;
                    count++;
                }
                Hbricks = true;
            }
            print_at(10, 335, "Half Bricks");
        }
        else
        {
            Hbricks = false;
        }

        // Updates the star's position
        if (StarMV.Active)
        {
            // Move the star down
            StarMV.Y += StarSpeed;
        }

        // Brick
        select_region(Brick);

        // Creates pointer to iterate through the linked list
        BrickNode* currentBrick = BrickList;
        // Continue looping if currentBrick is not NULL which is end of list
        while (currentBrick != NULL)
        {
            if (currentBrick->Active)
            {
                draw_region_at(currentBrick->X, currentBrick->Y);
            }
            currentBrick = currentBrick->next; // Move to the next brick in the list
        }

        // If star active then draw star
        if (StarMV.Active)
        {
            select_region(Star);
            draw_region_at(StarMV.X, StarMV.Y);
        }

        // Star is deactivated when it gets to bottom of screen
        if (StarMV.Active && StarMV.Y > screen_height)
        {
            StarMV.Active = false;
        }

        end_frame();
    }
}
