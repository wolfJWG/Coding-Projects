#include "video.h"
#include "input.h"
#include "math.h"
#include "time.h"
#include "misc.h"

// Texture Definitions in Cartridge
#define BreakoutTexture 0

// Regions in texture
#define Ball 1
#define Brick 2
#define Paddle 3

// Paddle speed
#define PaddleSpeed 8

// Basic state for paddles and balls
struct GameObject
{
    bool Active;
    int X, Y;          // Position on screen
    int Width, Height; // Size of hitbox for objects
};

struct BrickOBJ
{
    bool Active;
    int X, Y;          // Position on screen
    int Width, Height; // Size of hitbox for objects
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

    // Control paddle
    select_gamepad(0);

    // Giving values to GameObject for Paddle
    GameObject Player;
    Player.Active = true;
    Player.Width = 64;
    Player.Height = 28;
    Player.X = screen_width / 2;
    Player.Y = 340;


    // Giving values to GamObject for BallMV (Ball)
    GameObject BallMV;
    BallMV.Active = true;
    BallMV.Width = 8;
    BallMV.Height = 8;
    BallMV.X = screen_width / 2;
    BallMV.Y = screen_height / 2;

    // Brick array
    int size = 30; // Number of bricks displayed (size of array)

    // Declare a pointer to an array of BrickOBJ structures and initialize it to NULL
    BrickOBJ *Brick_array = NULL;

    // Dedicating memory for Brick array based on size using malloc
    Brick_array = (BrickOBJ*)malloc(size * sizeof(BrickOBJ));

    // Loops through all bricks in array
    for(int i = 0; i < size; i++)
    {
        // Brick is active and height and width are declared
        (*(Brick_array + i)).Active = true;
        (*(Brick_array + i)).Width = 64;
        (*(Brick_array + i)).Height = 32;

        // Setting location for first brick
        if (i == 0)
        {
            (*(Brick_array + i)).X = 32;
            (*(Brick_array + i)).Y = 8;
        }
        // For bricks 1 - 10 Y = 8
        else if (i >= 1 && i < 10)
        {
            (*(Brick_array + i)).X = (i * (*(Brick_array + i)).Width) + 32;
            (*(Brick_array + i)).Y = 8;
        }
        // For bricks 11 - 20 Y = 28 and 10 is taken away from i so blocks dont print off screen
        else if (i >= 10 && i <= 19)
        {
            (*(Brick_array + i)).X = ((i-10) * (*(Brick_array + i)).Width) + 32;
            (*(Brick_array + i)).Y = 28;
        }
        // For bricks 21 - 30 Y = 48 and 20 is taken away from i so blocks dont print off screen
        else
        {
            (*(Brick_array + i)).X = ((i-20) * (*(Brick_array + i)).Width) + 32;
            (*(Brick_array + i)).Y = 48;
        }


    };

    // Ball direction and speed
    int BallDirectionX = 1;
    int BallDirectionY = 1;
    int BallSpeed = 2;


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

            for (int i = 0; i < size; i++) {
                if ((*(Brick_array + i)).Active)
                {
                    // Check for collision between ball and brick
                    if (BallMV.X - BallMV.Width / 2 <= (*(Brick_array + i)).X + (*(Brick_array + i)).Width / 2 &&
                        BallMV.X + BallMV.Width / 2 >= (*(Brick_array + i)).X - (*(Brick_array + i)).Width / 2 &&
                        BallMV.Y - BallMV.Height / 2 <= (*(Brick_array + i)).Y + (*(Brick_array + i)).Height / 2 &&
                        BallMV.Y + BallMV.Height / 2 >= (*(Brick_array + i)).Y - (*(Brick_array + i)).Height / 2)
                    {
                        // Collision detected with brick
                        (*(Brick_array + i)).Active = false;  // Deactivate the brick and is not displayed
                        BallDirectionY *= -1;                 // Reverse the Y direction of the ball
                    }
                }
            }

        };

        // Prevent paddles from leaving the screen
        Player.X = max(Player.X, Player.Width / 2);
        Player.X = min(Player.X, screen_width - Player.Width / 2);

        // Ball movement
        BallMV.X += BallSpeed * BallDirectionX;
        BallMV.Y += BallSpeed * BallDirectionY;

        // Prevent Ball from leaving the screen
        BallMV.X = max(BallMV.X, BallMV.Width / 2);
        BallMV.Y = max(BallMV.Y, BallMV.Height / 2);

        BallMV.X = min(BallMV.X, screen_width - BallMV.Width / 2 );
        BallMV.Y = min(BallMV.Y, screen_height - BallMV.Height / 2);

        // Bounce off floor
        if (BallMV.Y >= screen_height - BallMV.Height)
        {
            // If ball hits the floor, reset to the center
            BallMV.X = screen_width / 2;
            BallMV.Y = screen_height / 2;
            BallDirectionX = 1; // Reset X direction
            BallDirectionY = 1;  // Reset Y direction
        }

        if (BallMV.X <= BallMV.Width || BallMV.X >= screen_width - BallMV.Width)
        {
            BallDirectionX *= -1; // Reverse the X direction when hitting the screen boundary
        }

        if (BallMV.Y <= BallMV.Height || BallMV.Y >= screen_height - BallMV.Height)
        {
            BallDirectionY *= -1; // Reverse the Y direction when hitting the screen boundary
        }


        // Texture starting location on screen
        // Ball location
        select_region(Ball);
        draw_region_at(BallMV.X, BallMV.Y);

        // Paddle location
        select_region(Paddle);
        draw_region_at(Player.X, 340);

        // Brick location
        select_region(Brick);

        // Displays each brick if active
        for (int i = 0; i < size; i++) {
            if ((*(Brick_array + i)).Active)
            {
                draw_region_at((*(Brick_array + i)).X, (*(Brick_array + i)).Y);
            };
        };

        end_frame();
    }

}
