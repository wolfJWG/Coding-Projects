#include "video.h"
#include "input.h"
#include "math.h"
#include "time.h"
#include "misc.h"

// Texture Definitions in Cartridge
#define Pongtextures 0

// Regions in texture
#define Ball 0
#define Lhoop 1
#define Rhoop 2

// Left and right paddle speed
#define Lhooppaddle 5
#define Rhooppaddle 5

// Basic state for paddles and balls
struct GameObject
{
    bool Active;
    int X, Y;          // Position on screen
    int Width, Height; // Size of hitbox for objects
};

// Start of main function
void main(void)
{
    // Setting up textures
    select_texture(Pongtextures);         // Selecting texture in cartridge
    select_region(Ball);                  // Designating region for ball
    define_region(46, 1, 80, 35, 63, 18); // Location in texture file

    select_region(Lhoop);                 // Designating region for Lhoop
    define_region(24, 1, 45, 68, 35, 34); // Location in texture file

    select_region(Rhoop);                 // Designating region for Rhoop
    define_region(2, 1, 23, 68, 13, 34);  // Location in texture file

    // Control left paddle with keyboard
    select_gamepad(0);

    // Giving values to GameObject for Player (Left hoop)
    GameObject Player;
    Player.Active = true;
    Player.Width = 23;
    Player.Height = 72;
    Player.X = screen_width / 7;
    Player.Y = screen_height / 2;

    // Giving values to GamObject for Opponent (Right paddle)
    GameObject Opponent;
    Opponent.Active = true;
    Opponent.Width = 23;
    Opponent.Height = 72;
    Opponent.X = 6 * screen_width / 7;
    Opponent.Y = screen_height / 2;

    // Giving values to GamObject for BBall (Basketball)
    GameObject BBall;
    BBall.Active = true;
    BBall.Width = 17;
    BBall.Height = 17;
    BBall.X = screen_width / 7;
    BBall.Y = screen_height / 2;

    // Ball direction and speed
    int BallDirectionX = 1;
    int BallDirectionY = 1;
    int BallSpeed = 5;

    while (true)
    {
        // Background
        clear_screen(make_color_rgb(123, 172, 200));

        // Reads player input
        int DirectionX, DirectionY;
        gamepad_direction(&DirectionX, &DirectionY);

        // Left paddle movement and interaction with ball
        if (Player.Active)
        {
            // Left paddle movement
            Player.X += Lhooppaddle * DirectionX;
            Player.Y += Lhooppaddle * DirectionY;

            // Check for collision with left paddle
            if (BBall.X - BBall.Width / 2 <= 20 + Player.Width / 2 &&
                BBall.X + BBall.Width / 2 >= 20 - Player.Width / 2 &&
                BBall.Y - BBall.Height / 2 <= Player.Y + Player.Height / 2 &&
                BBall.Y + BBall.Height / 2 >= Player.Y - Player.Height / 2)
            {
                BallDirectionX *= -1; // Reverse the X direction when hitting the left paddle
            }
        }

        // Direction for right hoop
        int DirectionX1, DirectionY1;

        // Right paddle movement and interaciton with ball
        if (Opponent.Active)
        {
            // Calculates the difference between the ball's Y position and the right paddle's Y position
            int YDifference = BBall.Y - Opponent.Y;

            // Adjust the right paddle's Y position based on the difference
            if (YDifference > 0)
            {
                Opponent.Y += Rhooppaddle;
            }
            else if (YDifference < 0)
            {
                Opponent.Y -= Rhooppaddle;
            }

            // Right paddle movement
            Opponent.X += Rhooppaddle * DirectionX1;
            Opponent.Y += Rhooppaddle * DirectionY1;

            // Check for collision with right paddle
            if (BBall.X - BBall.Width / 2 <= 620 + Opponent.Width / 2 &&
                BBall.X + BBall.Width / 2 >= 620 - Opponent.Width / 2 &&
                BBall.Y - BBall.Height / 2 <= Opponent.Y + Opponent.Height / 2 &&
                BBall.Y + BBall.Height / 2 >= Opponent.Y - Opponent.Height / 2)
            {
                BallDirectionX *= -1; // Reverse the X direction when hitting the right paddle
            }
        }

        // Prevent paddles from leaving the screen
        Player.X = max(Player.X, Player.Width / 2);
        Player.Y = max(Player.Y, Player.Height / 2);

        Player.X = min(Player.X, screen_width - Player.Width / 2);
        Player.Y = min(Player.Y, screen_height - Player.Height / 2);

        Opponent.X = max(Opponent.X, Opponent.Width / 2);
        Opponent.Y = max(Opponent.Y, Opponent.Height / 2);

        Opponent.X = min(Opponent.X, screen_width - Opponent.Width / 2);
        Opponent.Y = min(Opponent.Y, screen_height - Opponent.Height / 2);

        // Ball movement
        BBall.X += BallSpeed * BallDirectionX;
        BBall.Y += BallSpeed * BallDirectionY;

        // Prevent Ball from leaving the screen
        BBall.X = max(BBall.X, BBall.Width / 2);
        BBall.Y = max(BBall.Y, BBall.Height / 2);

        BBall.X = min(BBall.X, screen_width - BBall.Width / 2 );
        BBall.Y = min(BBall.Y, screen_height - BBall.Height / 2);

        // Bounce off the walls
        if (BBall.X <= BBall.Width)
        {
            // Ball hit the left wall, reset to the center
            BBall.X = screen_width / 2;
            BBall.Y = screen_height / 2;
            BallDirectionX = 1; // Reset X direction
            BallDirectionY = 1; // Reset Y direction
        }
        else if (BBall.X >= screen_width - BBall.Width)
        {
            // Ball hit the right wall, reset to the center
            BBall.X = screen_width / 2;
            BBall.Y = screen_height / 2;
            BallDirectionX = -1; // Reset X direction
            BallDirectionY = 1;  // Reset Y direction
        }

        if (BBall.X <= BBall.Width || BBall.X >= screen_width - BBall.Width)
        {
            BallDirectionX *= -1; // Reverse the X direction when hitting the screen boundary
        }

        if (BBall.Y <= BBall.Height || BBall.Y >= screen_height - BBall.Height)
        {
            BallDirectionY *= -1; // Reverse the Y direction when hitting the screen boundary
        }

        // Texture starting locations on screen
        // Left paddle location
        select_region(Lhoop);
        draw_region_at(12, Player.Y);

        // Right paddle location
        select_region(Rhoop);
        draw_region_at(628, Opponent.Y);

        // Ball location
        select_region(Ball);
        draw_region_at(BBall.X, BBall.Y);

        end_frame();
    }
}
