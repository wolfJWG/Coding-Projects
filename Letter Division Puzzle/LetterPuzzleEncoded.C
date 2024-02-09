// Including necessary libraries
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <math.h>

#define SIZE 10         // Number of values to be encoded
#define LETTER_COUNT 26 // All letters in the alphabet

// Function to generate some number between min and max
int generateRandomNumber(int min, int max)
{
    return rand() % (max - min + 1) + min;
}

// Function to count the number of digits in a number
int digitCount(int number)
{
    int count = 0; // Stores the length of the number

    // Special case for when the number is 0
    if (number == 0)
    {
        return -1;
    }

    // Loop that counts the digits in the number
    while (number != 0)
    {
        // Divides the number by 10 each time to remove the last digit
        number /= 10;
        count++; // Increment count
    }

    return count; // Returns number length
}

// Funciton to print spaces X number of times
void printSpaces(int count)
{
    for (int i = 0; i <= count; i++)
    {
        printf(" "); // Prints a space everytime the loop executes
    }
}

// Funciton to print dashes X number of times
void printDashes(int count)
{
    for (int i = 0; i <= count; i++)
    {
        printf("-"); // Prints a dash everytime the loop executes
    }
}

// Funciton to print equals X number of times
void printEqual(int count)
{
    for (int i = 0; i <= count; i++)
    {
        printf("="); // Prints a eqaul everytime the loop executes
    }

    printf("\n"); // Goes to next line
}

// Function to get the result of multiplying a digit in a certian position
// of targetNumber by number.
int resNumber(int number, int targetNumber, int position)
{
    int length = 0; // Stores the length of targetNumber

    // Temp variable used to store targetNumber for getting the length
    int temp = targetNumber;

    // Finds the length of tagetNumber
    while (temp != 0)
    {
        length++;   // Increment the length for each digit found
        temp /= 10; // Removes the last digit in temp
    }

    int target_digit = 0; // Stores the digit at the given position

    // Isolates the digit at the given position of targetNumber
    for (int i = 0; i < length - position + 1; i++)
    {
        target_digit = targetNumber % 10; // Gets the last digit of targetNumber
        targetNumber /= 10;               // Removes the last digit of targetNumber
    }

    // Returns the result of multiplying the number and the value at the given position
    return number * target_digit;
}

// Function that subtracts subtractor from part of parNum
// *NOTE: The part of parNum matches the length of subtractor
int subtractPart(int parNum, int subtractor)
{
    // Checking that each number in play is positive
    if (parNum <= 0 || subtractor < 0)
    {
        return -1;
    }

    int numDigits = 0; // Stores the number of digits

    // Handle the case for when subtractor = 0
    int temp = (subtractor == 0) ? 1 : subtractor;

    // Gets the number of digits in the subtractor using a loop
    while (temp != 0)
    {
        numDigits++; // Increases numDigits everytime the loop executes
        temp /= 10;  // Removes the last digit in temp
    }

    // Determine the number of digits in parNum also using a loop
    int parNumDigits = 0;    // Stores the number of digits
    int tempParNum = parNum; // Temp variable as to not mess with parNum
    while (tempParNum != 0)
    {
        parNumDigits++;   // Increase parNumDigits everytime loop executes
        tempParNum /= 10; // Removes the last digit in temp
    }

    // Gets the right divisor based on the difference
    // in the number of digits between parNum and subtractor
    int divisor = 1;
    for (int i = 0; i < parNumDigits - numDigits; i++)
    {
        divisor *= 10; // Divisor is multiplyed by 10 for each extra digit in parNum
    }

    // Shorten the parNum to match the length of subtractor
    int shortened = parNum / divisor;

    // Adjusts the divisor and than calculates shortened until its greater
    // than or equal to the subtractor
    while (shortened < subtractor)
    {
        divisor /= 10;                // Shortens the divisor
        shortened = parNum / divisor; // Calculating shortened

        // Prevents the loop from going endlessly
        if (divisor == 1)
        {
            break;
        }
    }

    // Returns the result of the subtraciton
    return shortened - subtractor;
}

// Function to get the digit at a given posision in a number
int getDigit(int number, int position)
{
    int count = 0; // Stores the length of number

    // Temporary variable to store the number for getting its length
    int tempNumber = number; 

    // Counts the digits in number
    while (tempNumber != 0)
    {
        count++;          // Increment count everytime loop executes
        tempNumber /= 10; // Remove the last digit in tempNumber

    }

    // Calculates the divisor to find the number at the givin position
    int divisor = pow(10, count - position);

    // Returns the digit at the specified locaiton
    return (number / divisor) % 10;
}

// Appends a digit to the end of a given numer
int appendDigit(int number, int digit)
{
    // Moves the original number digits over to the left (By mutliplying by 10)
    // and than adds the new digit to the end of the number
    return number * 10 + digit;
}

// Stores the letter assignments
char letterAssignments[SIZE];

// Function that shuffles an array (Fisher-Yates algorithm)
void shuffleArray(char *array, int size)
{
    // Loops through the given array
    for (int i = size - 1; i > 0; i--)
    {
        // Generates a random index between 0 and i
        int j = rand() % (i + 1);

        // Stores the current element in a temp variable
        char temp = array[i];

        // Putting the random element into the current position
        array[i] = array[j];

        // Putting the original element into the random position
        array[j] = temp;
    }
}

// Function that assigns random letters to numbers
void encode()
{
    // Creating an array to hold letters
    char letters[LETTER_COUNT];

    // Populating the array with all letters in the alphabet
    for(int i = 0; i < LETTER_COUNT; i++)
    {
        // Each element in the array is assigned a letter. Starts with A
        letters[i] = 'A' + i;
    }

    // Shuffles the array
    shuffleArray(letters, LETTER_COUNT);

    // Copies over the shuffled letter array to the global array letterAssignments
    for (int i = 0; i < SIZE; i++)
    {
        // Each element in letterAssignments is set to the corresponding one in letters
        letterAssignments[i] = letters[i];
    }
}

// Function that allows the user to decide the encoding
void userAssignLetters()
{
    char input; // Stores user input
    int used[LETTER_COUNT] = {0}; // Keeps thack of the letters already used

    printf("Enter a unique letter for each digit 0-9:\n");

    // Assigns letters to each digit
    for (int i = 0; i < SIZE; i++)
    {
        do
        {
            // Prompts the user to enter a letter
            printf("Enter a letter for digit %d: ", i);

            // Taking input from user
            scanf(" %c", &input);

            // Clearing input buffer as to only take one letter
            while (getchar() != '\n');

            // Input is converted to uppercase
            input = toupper(input);

            // Checks that input is a letter
            if (!isalpha(input))
            {
                // Informs the user if they did not enter a letter
                printf("Invalid input. Please enter a letter.\n");
                continue;
            }

            // Checks if a letter has already been used
            if (used[input - 'A'])
            {
                // Informs the user if they already used that letter
                printf("Letter '%c' has already been used."
                       " Please enter a different letter.\n", input);
            }
        }

        // Repeating till a valid letter is entered
        while (!isalpha(input) || used[input - 'A']);

        // Assigns the inputted letter to the current digit
        letterAssignments[i] = input;

        // Marking the letter if it is used
        used[input - 'A'] = 1;
    }
}

// Function to replace digits with letters
void replacer(int number)
{
    // Handles special case for 0
    if (number == 0)
    {
        // Prints the assigned letter and returns
        printf("%c", letterAssignments[0]);
        return;
    }

    // Variable to store the reverse of the number
    int reverse = 0;

    // Loop used to store the reverse digits of a given number
    while (number != 0)
    {
        // Adds the last digit of number to reverse
        reverse = reverse * 10 + number % 10;

        // Removes last digit
        number /= 10;
    }

    // prints letters corresponding to each digit of the reversed number
    while (reverse != 0)
    {
        // Printing the letter assigned to the last digit
        printf("%c", letterAssignments[reverse % 10]);

        // Removes the last digit from reverse
        reverse /= 10;
    }
}

// Function that performs long division and prints each step
void longDivision(int dividend, int divisor)
{
    int quotient = 0;            // Hold the quotient
    int remainder = 0;           // Holds the remainder
    int tempDividend = dividend; // Temp variable for manipulating dividend

    // Loop that calculates the quotient and remainder
    while (tempDividend >= divisor)
    {
        quotient++; // Increments the quotient

        // Takes the divisor from the tempDividend and lowering it
        // each time the loop executes
        tempDividend -= divisor; 
    }
    remainder = tempDividend; // The final value of the temp variable is the remainder

    // Calculates the number of digits for the dividend, divisor, and quotient
    int dividendDigits = digitCount(dividend);
    int divisorDigits = digitCount(divisor);
    int quotientDigits = digitCount(quotient);

    // Calculates the proper spacing for the quotient
    int Qspacing = dividendDigits + divisorDigits - quotientDigits;

    // Prints the quotient as letters
    printSpaces(Qspacing + 2);
    replacer(quotient);
    printf("\n");

    // Uses the length of the divisor and puts the corner in the correct spot
    printSpaces(divisorDigits);
    printf("+");

    // X amount of dashes are printed based on the dividend length
    printDashes(dividendDigits);

    // Prints the divisor and the dividend as letters
    printf("\n");
    replacer(divisor);
    printf(" | ");
    replacer(dividend);
    printf("\n");

    int count = 1;        // Increments the main while loop
    int diffCount = 1;    // Keeps track of which number to bring down

    // Final is used to display the result of subtracting and appending a number
    int Final = dividend; 

    // Spacing for subtracting lines
    int spacing = 0;
    spacing += digitCount(divisor) + 1;

    // Spacing for Final lines
    int fspacing = digitCount(divisor)+2;

    // Used for special case when dividend starts with 1 and the first
    // subtract starts with a num > 1
    bool lineUp = false;
    
    // Both used X amount of times when the Final and resNum have the same values to start
    int zeroOutCount1 = 1;
    int zeroOutCount2 = 1;

    // Start of main loop
    // Goes until count is the same as the number of digits in quotient
    while (count <= quotientDigits)
    {
        // Checks if there is a 0 in the quotient
        if (resNumber(divisor, quotient, count) == 0)
        {
            // If the 0 is at the end of the quotient then loop ends else increase count
            if (getDigit(quotient, quotientDigits) == 0)
            {
                break;
            }

            else
            {
                count++;
            }
        }

        // Setting a temp variable to be used in comparision
        int temp = getDigit(Final, 1);

        // Loop to check if the dividend starts with a 1 and if the start
        // of the first subtraction is larger
        if (temp < getDigit(resNumber(divisor, quotient, count), 1))
        {
            spacing++;     // Spacing increases
            lineUp = true; // linUp is true now
        }

        printSpaces(spacing); // Prints the spacing

        // Prints the number that is being subtracted from Final as letters
        printf("-");
        replacer(resNumber(divisor, quotient, count));
        printf("\n");

        // Prints the equal signs based on the length of the subtracting number
        printSpaces(spacing+1);
        printEqual(digitCount(resNumber(divisor, quotient, count))-1); 

        // Result of subtraciton before appending number from dividend
        int SubNum2 = subtractPart(Final, resNumber(divisor, quotient, count));

        // Prevents from pulling a number down when there is not one available 
        if (diffCount+digitCount(resNumber(divisor, quotient, 1)) < digitCount(dividend))
        {
            // Number that gets dragged down from the dividend
            int drag1 = getDigit(dividend,
                                 diffCount+digitCount(resNumber(divisor, quotient, 1)));

            // If lineUp is true
            if (lineUp)
            {
                fspacing += 1; // Spacing increases by 1

                // Gets the correct number to be dragged now that the spacing has changed
                drag1 = getDigit(dividend,
                                 diffCount+digitCount(resNumber(divisor, quotient, 1))+1);

                // If the second number in Final is smaller than the
                // number being subtracted
                if (getDigit(Final, 2) == 0 &&
                    getDigit(resNumber(divisor, quotient, count), 1) == 9)
                {

                    // If the third number in Final is the same as the second
                    // in the one being subtracted
                    if (getDigit(Final, 3) ==
                        getDigit(resNumber(divisor, quotient, count), 2))
                    {
                        // If the fourth number in Final is less than the third number
                        // in the one being subtrated than the spacing increases for Final
                        // and subtracting lines
                        if (getDigit(Final, 4) <
                            getDigit(resNumber(divisor, quotient, count), 3))
                        {
                            fspacing += 1;
                            spacing += 1;
                        }
                    }

                    // If the third number in Final is less than the second in the number
                    // being subtracted than the spacing increases for Final and
                    // subtracting lines
                    else if (getDigit(Final, 3) <
                             getDigit(resNumber(divisor, quotient, count), 2))
                    {
                        fspacing += 1;
                        spacing += 1;
                    }
                }
            }

            // Setting to increment through the digits in Final and the number
            // being subtracted
            zeroOutCount1 = 1;

            // Moves over Final to the correct spot when the result of subtracting leads
            // to zeros in the first slots the numbers are the same
            while (getDigit(Final, zeroOutCount1) ==
                   getDigit(resNumber(divisor, quotient, count), zeroOutCount1))
            {
                // Handles the case for when lineUp is true
                if (lineUp)
                {
                    fspacing += 0; // Fspacing does not change
                }

                else
                {
                    fspacing += 1; // Fspacing increases
                }
                
                spacing += 1; // spacing increases
                zeroOutCount1++; // Increments count

                // Moves over Final to the correct spot when the result of subtracting
                // leads to zeros in the first slot

                // Final is larger by 1 but there is a borrow that results in zero
                while (getDigit(Final, zeroOutCount1) ==
                       getDigit(resNumber(divisor, quotient, count), zeroOutCount1)+1)
                {
                    // Checks if a borrow is happening in the next slot over
                    if (getDigit(Final, zeroOutCount1+1) <=
                        getDigit(resNumber(divisor, quotient, count), zeroOutCount1+1))
                    {
                        fspacing += 1; // Increase final spacing
                        spacing += 1;  // Increase subtracting spacing
                        zeroOutCount1++; // Increment variable to check the next slot
                    }

                    // If there is not a borrow than breaks out of the loop
                    else
                    {
                        break;
                    }
                }
            }

            // When count is equal to the length of quotient -1
            if (digitCount(quotient)-1 == count)
            {
                // If the second number in Final is eqaul to the second number in
                // the subtracing number
                if (getDigit(Final, 2) ==
                    getDigit(resNumber(divisor, quotient, count), 2))
                {
                    fspacing++; // Increase Final spacing
                }
            }

            // Setting to increment through the digits in Final and the number
            // being subtracted
            int finalSpacingCheck1 = 1; 

            // Moves over Final to the correct spot when the result of subtracting leads
            // to zeros in the first slot

            // Final is larger by 1 but there is a borrow that results in zero
            while (getDigit(Final, finalSpacingCheck1) ==
                   getDigit(resNumber(divisor, quotient, count), finalSpacingCheck1)+1)
            {
                // Checks if a borrow is happening in the next slot over
                if (getDigit(Final, finalSpacingCheck1+1) <=
                    getDigit(resNumber(divisor, quotient, count), finalSpacingCheck1+1))
                {
                    // Handles the case for when lineUp is true
                    if (lineUp)
                    {
                        fspacing --;   // Decrease Final spacing by 1
                    }

                    else
                    {
                        fspacing += 1; // Increase Final spacing by 1
                    }

                    finalSpacingCheck1++; // Increments count
                    spacing += 1;         // Spacing increases by 1
                }
                
                // If there is not a borrow than breaks out of the loop
                else
                {
                    break;
                }
            }

            // The number is brought down and appened onto SubNum2
            Final = appendDigit(SubNum2, drag1);

            // Makes sure that a double drag is possible 
            if (count < quotientDigits-1)
            {
                // If Final is still less than the divisor after a drag than another
                // one is performed
                if (divisor > Final)
                {
                    // Second number being dragged
                    int drag2 = getDigit(dividend,
                                diffCount+digitCount(resNumber(divisor, quotient, 1))+1);

                    // Appends on both drag numbers
                    Final = appendDigit(appendDigit(SubNum2, drag1), drag2);
                    diffCount++; // Increments count
                }
            }
        
        }
        // Case for the last step in the division process
        else {
            // Setting a temp variable to be used in the conparision
            int temp = getDigit(Final, 1);

            // Loop to check if the dividend starts with a 1 and if the start of
            // the first subtraction is larger
            if (temp < getDigit(resNumber(divisor, quotient, count), 1))
            {
                spacing++;     // Spacing increases
                lineUp = true; // lineUp is set to true
                fspacing++;    // Fspacing increases
            }

            // Setting to increment through the digits in Final and the number
            // being subtracted
            zeroOutCount2 = 1;

            // Moves over Final to the correct spot when the result of subtracting leads
            // to zeros in the first slots because the numbers are the same
            while (getDigit(Final, zeroOutCount2) ==
                   getDigit(resNumber(divisor, quotient, count), zeroOutCount2))
            {
                fspacing += 1;   //Fspacing is increased
                zeroOutCount2++; // Increments count

                // Moves over Final to the correct spot when the result of subtracting
                // leads to zeros in the first slots

                // Final is larger by 1 but there is a borrow that results in zero
                while (getDigit(Final, zeroOutCount2) ==
                       getDigit(resNumber(divisor, quotient, count), zeroOutCount2)+1)
                {
                    // Checks if a borrow is happening in the next slot over
                    if (getDigit(Final, zeroOutCount2+1) <=
                        getDigit(resNumber(divisor, quotient, count), zeroOutCount2+1))
                    {
                        fspacing += 1;   // Increase final spacing
                        zeroOutCount2++; // Increment variable to check the next slot
                    }

                    // If there is not a borrow than breaks out of the loop
                    else
                    {
                        break;
                    }
                }
            }

            // Setting to increment through the digits in Final and the number
            // being subtracted
            int finalSpacingCheck2 = 1; 

            // Moves over Final to the correct spot when the result of subtracting leads
            // to zeros in the first slots

            // Final is larger by 1 but there is a borrow that results in zero
            while (getDigit(Final, finalSpacingCheck2) ==
                   getDigit(resNumber(divisor, quotient, count), finalSpacingCheck2)+1)
            {
                // Checks if a borrow is happening in the next slot over
                if (getDigit(Final, finalSpacingCheck2+1) <=
                    getDigit(resNumber(divisor, quotient, count), finalSpacingCheck2+1))
                {
                    fspacing++;           // Increases fspacing
                    finalSpacingCheck2++; // Increments counts
                }

                // If there is not a borrow than breaks out of the loop
                else
                {
                    break;
                }
            }

            // If the last digit in quotient is 0 than bring down the last number
            // in the dividend
            if (getDigit(quotient, quotientDigits) == 0)
            {
                Final = appendDigit(SubNum2, getDigit(dividend, dividendDigits));
            }
            
            else
            {
                Final = SubNum2;
            }
            
        }

        printSpaces(fspacing); // Prints the final spacing

        replacer(Final); // Prints final as letters
        printf("\n");

        diffCount++; // Increment diffCount
        count++;     // Increment count
    }
}

int main()
{
    srand(time(NULL)); // Seed for random number generation

    // User selects if they want to create the encoding themselves or randomize it
    int choice;
    printf("Choose assignment method:\n");
    printf("1. Random\n");
    printf("2. Manual\n");
    printf("Enter choice (1 or 2): ");
    scanf("%d", &choice);

    // If they choose random than encode is called
    if (choice == 1)
    {
        encode();
    }

    // Else if they want to encode themselves than userAssignLetters is called
    else if (choice == 2)
    {
        userAssignLetters();
    }

    // If the user does not choose either than program is terminated
    else {
        printf("Invalid choice.\n");
        return 1;
    }

    // Display the encoding
    printf("\nLetter assignments for digits 0-9:\n");

    // Loops through all numbers
    for (int i = 0; i < SIZE; i++) {
        // Prints the letter assigned to each number
        printf("%d -> %c\n", i, letterAssignments[i]);
    }

    printf("\n");

    int divisor = generateRandomNumber(1000, 999999); // 4 to 6 digitss
    int dividend = generateRandomNumber(1000000, 999999999); // 7 to 9 digits

    longDivision(dividend, divisor); // Calling longDivision function 

    return 0;
}
