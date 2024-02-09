// Vircon32 Libraries
#include "video.h"
#include "input.h"
#include "math.h"
#include "time.h"
#include "misc.h"
#include "string.h"

//Max height tree can be (No height limit when set to 0)
#define MAX_HEIGHT 4

// Struct definition for node in the tree
struct Node
{
    int data;    // Data stored in the tree
    Node *left;  // Pointer to left child node
    Node *right; // Pointer to right child node
    int x;       // Storing x locaiton on screen
    int y;       // storing y location on screen
};

// Function to create new node in the tree
Node* newNode(int data)
{
    // Dynamically allocating memory for a node
    Node *node = (Node*) malloc(sizeof(Node));

    // Initializing the node
    node->data = data;  // Setting node data
    node->left = NULL;  // Left child set to NULL
    node->right = NULL; // Right child set to NULL

    // Return pointer to the node
    return node;
}

// Function to get the height of the tree
int getHeight(Node* node)
{
    int height; // Creating height variable

    // If the node is NULL than the height of the tree is 0. Base case
    if (node == NULL)
    {
        return 0;
    }

    else
    {
        // Calculating the height of the left and right subtrees using recursion
        int leftHeight = getHeight(node->left);
        int rightHeight = getHeight(node->right);

        // Finding which is taller between the left and right subtrees
        if (leftHeight > rightHeight)
        {
            height = leftHeight;
        }

        else
        {
            height = rightHeight;
        }

        // Returns the taller height. Adds one for the current node
        return height + 1;
    }
}

// Function to find the node with the lowest value in the tree
Node* minValueNode(Node* node)
{
    Node* current = node; // Initialzing current to the given node

    // Finds the furthest value to the left which is the smallest value
    while (current && current->left != NULL)
    {
        current = current->left;
    }

    return current; // Returns the node with the lowest value
}

// Function to delete a node with a given value from the tree
Node* deleteNode(Node* root, int data)
{
    // If the tree is empty or the end of a branch is reached. Base case
    if (root == NULL)
    {
        return root;
    }

    // Delete from the left subtree if the data is less than the roots data
    if (data < root->data)
    {
        root->left = deleteNode(root->left, data);
    }

    // Delete from the right subtree if the data is greater than the roots data
    else if (data > root->data)
    {
        root->right = deleteNode(root->right, data);
    }

    // If the root is the node that needs to be deleted
    else
    {
        // If the node has only the right child
        if (root->left == NULL)
        {
            // Temp is assigned to point to the right child of the root
            Node *temp = root->right;
            free(root); // Free memory allocated for the node

            return temp; // Return the right child
        }

        // If the node has only the left child
        else if (root->right == NULL)
        {
            // Temp is assigned to point to the left child of the root
            Node *temp = root->left;
            free(root); // Free memory allocated for the node

            return temp; // Return the left child
        }

        // If the node has two children than finds the successor.
        // The smallest in the right subtree
        Node* temp = minValueNode(root->right);

        // Copies the successor data to the this node
        root->data = temp->data;

        // Deletes the successor
        root->right = deleteNode(root->right, temp->data);
    }

    return root; // Returns root node
}

// Function to display the tree
void displayTree(Node *node, int x, int y, int depth)
{
    // If the node is NUll than do nothing. Base case
    if (node == NULL)
    {
        return;
    }

    int offset; // X-axis distance of children nodes

    // Gets the offset based off the tree height
    if (MAX_HEIGHT == 0)
    {
        // Getting the offset when there is no maximum height (max height is set to 0)
        offset = pow(2, getHeight(node) - 1) * 10;
    }

    else
    {
        // Getting the offset when there is a max height
        offset = pow(2, MAX_HEIGHT - depth) * 10;
    }

    // Setting the nodes x and y positions
    node->x = x;
    node->y = y;

    // Making it so the data values can be displayed (switching values to string)
    int[100] Treenums;              //Holding string of nodes data
    itoa(node->data, Treenums, 10); //Putting int value into Treenums
    print_at(x, y, Treenums);       // Displaying node data at give x and y position

    //Displying left and right subtrees using recursion
    displayTree(node->left, x - offset, y + 60, depth + 1);
    displayTree(node->right, x + offset, y + 60, depth + 1);
}

// Funciton to find node by its position on screen
Node* findNodeByPosition(Node* node, int x, int y)
{
    // If the node is NULL than return NULL. Base case
    if (node == NULL)
    {
        return NULL;
    }

    int hitboxSize = 15; // Hitbox around each node

    // Check if the given x and y values are within the nodes hitbox
    if (x >= node->x - hitboxSize && x <= node->x + hitboxSize &&
        y >= node->y - hitboxSize && y <= node->y + hitboxSize)
    {
        return node; // Found the node
    }

    // Check in the left tree by using recursion
    Node* foundNode = findNodeByPosition(node->left, x, y);

    // If not in the left subtree than check the right
    if (foundNode == NULL)
    {
        foundNode = findNodeByPosition(node->right, x, y);
    }

    return foundNode; //Return the node or NULL if not found
}

int randomValue; // Variable initialized for random value that player needs to select

// Function to sort the array (bubble sort algorithm)
void bubbleSort(int *array, int size)
{
    // Outer loop runs through array up to the second to last element
    for (int i = 0; i < size - 1; i++)
    {
	// Inner loop compares and adjust the array to organize from smallest to largest
        for (int j = 0; j < size - i - 1; j++)
	{
	    // if the current element is greater than the next element than swap them
            if (array[j] > array[j + 1])
	    {
                int temp = array[j];     // Temp to store current element
                array[j] = array[j + 1]; // Current element is replaced with next element
                array[j + 1] = temp;     // next element becomes temp variable
            }
        }
    }
}

// Function to create array with unique random values
void createSortedArray(int *array, int size)
{
    bool [100]used = {0}; // Track numbers used

    // Loop to fill array with unique random numbers
    for (int i = 0; i < size; i++)
    {
        int num; // Initialize num

	// Create random number till unique one is found
        do
	{
            num = rand() % 99 + 1; // Random number generated
        }

	while (used[num]); // Continue looping till unique number is found

	// assign unique number to the array
        array[i] = num;

	// Mark the number as used
        used[num] = true;
    }

    // Select a random number from the generated array
    int randomIndex = rand() % size;

    // Assigned to global variable
    randomValue = array[randomIndex];

    // Sort the generated array
    bubbleSort(array, size);
}

// Function to make balanced binary tree given an array
Node* sortedArrayToTree(int *arr, int start, int end, int currentDepth)
{
    // Returns NULL if start index is greater than the end index. Base case
    // Also returns NULL if currentDepth is greater than or equal to MAX_HEIGHT
    if (start > end || (MAX_HEIGHT > 0 && currentDepth >= MAX_HEIGHT))
    {
        return NULL; // Returns NULL
    }

    // Middle index in array
    int mid = (start + end) / 2;

    // Create new node with value in the middle of the array
    Node* node = newNode(arr[mid]);

    // Recursively make the left subtree with the values from start to mid-1
    node->left = sortedArrayToTree(arr, start, mid - 1, currentDepth + 1);

    // Recursively make the right subtree with values from mid+1 to end
    node->right = sortedArrayToTree(arr, mid + 1, end, currentDepth + 1);

    return node; // Retuns node
}

// Function to make binary tree based off number of levels
Node* createTreeFinal(int levels)
{
    // Returns NULL if levels is less than or eqaul to 0. Base case
    if (levels <= 0)
    {
         return NULL;
    }

    // If there is a MAX_HEIGHT and the given levels exceeds it than adjust levels
    if (MAX_HEIGHT > 0 && levels > MAX_HEIGHT)
    {
        levels = MAX_HEIGHT;
    }

    // Calculates size of array based on number of levels
    int size = (int)pow(2, levels) - 1;

    // Allocating memory for array
    int *array = (int*)malloc(size * sizeof(int));

    // Creating sorted array
    createSortedArray(array, size);

    // Makes the binary tree from the sorted array
    Node *root = sortedArrayToTree(array, 0, size - 1, 0);

    free(array); // Frees allocated memory for array

    return root; // Returns node
}

// Start of main function
void main(void)
{
    srand(get_time()); // Seeds random number generator

    Node* root = NULL; // Initialize the root of the tree
    root = createTreeFinal(5); // Making the random tree with 5 levels

    // Selects keyboard as gamepad to use for input
    select_gamepad(0);

    // Initializing pointerX and Y along with speed for pointer
    int PointerX = 1;
    int PointerY = 1;
    int speed = 3;

    // Variables used for displaying to guess higher or lower or that you won
    bool higher = false;
    bool lower = false;
    bool gameOver = false;

    // Number of guesses
    int guessesLeft = 4;

    // Start of game loop
    while (true)
    {
        // Setting background color
        clear_screen(make_color_rgb(123, 172, 200));

        int DirectionX, DirectionY; // Stores the direciton input
        gamepad_direction(&DirectionX, &DirectionY); // Gets movement from keyboard

        // Initializing delete button for deleting data when enter is pressed
        bool deleter = (gamepad_button_start() == 1);

        // Updates the pointers X position based on input and boundary checks
        if (PointerX + speed * DirectionX >= 0 && PointerX + speed * DirectionX <= 630)
        {
            PointerX += speed * DirectionX;
        }

        // Updates the pointers Y position based on input and boundary checks
        if (PointerY + speed * DirectionY >= 0 && PointerY + speed * DirectionY <= 350)
        {
            PointerY += speed * DirectionY;
        }

        // If enter is pressed than the following happens
        if (deleter)
        {
            // Find the node at the current position of the pointer
            Node* targetNode = findNodeByPosition(root, PointerX, PointerY);

            // If targetNode is not NULL
            if (targetNode != NULL)
            {
		// If the selected number matches the randomValue than the following
		// variables are adjusted
  	        if (targetNode->data == randomValue)
	        {
		    //Player wins
		    gameOver = true;
		    lower = false;
		    higher = false;
	        }

		// If the selected number is less than the randomValue and gameOver is
		// false than the following variables are adjusted
	        else if (targetNode->data < randomValue && !gameOver)
	        {
		    // Guessed value is lower than randomValue
		    lower = true;
		    higher = false;
		    gameOver = false;
		    guessesLeft--;
	        }

		// If the selected number is greater than the randomValue and gameOver
		// is false than the following variables are adjusted
	        else if (targetNode->data > randomValue && !gameOver)
	        {
		    // Guessed value is higher than randomValue
		    higher = true;
		    lower = false;
		    gameOver = false;
		    guessesLeft--;
	        }

		// Can delete node if the guesses remaining is above 0 and gameOver
		// is false
	        if (guessesLeft > 0 && !gameOver)
		{
                    deleteNode(root, targetNode->data); // Deletes the given node
		}
            }
        }

        displayTree(root, 300, 50, 1); // Display the tree

        print_at(PointerX, PointerY, "^"); // Display the pointer

	// Message saying what you are playing and what to do
	print_at(400, 10, "Welcom to Binary Search!");
	print_at(435, 30,"Try to guess the\n random number!");

	// Displays the number of guesses remaining
	print_at(10,10, "Remaining Guesses:");
	if (guessesLeft < 0)
	{
	    guessesLeft = 0;
	}

	// Converting guesses left int to be displayed
	int [30] guesses;
	itoa(guessesLeft, guesses, 10);
	print_at(200, 10, guesses);

	// If guesses left is above 0
	if (guessesLeft > 0){
	    // If the guess is too low
 	    if (lower)
	    {
	        print_at(265,10, "Guess Higher!");
	    }

	    // If the guess is too high
	    if (higher)
	    {
	        print_at(265,10, "Guess Lower!");
	    }

	    // If randomValue is guessed correctly
	    if (gameOver)
	    {
	        print_at(280,10, "YON WON!");
	    }
	}

	// If guesses remaining is 0 or less player lost and variables
	// are adjusted
	else if (guessesLeft <= 0)
	{
	    print_at(280,10, "YOU LOST!");
	    higher = false;
	    lower = false;
	    gameOver = false;
	}

        end_frame(); // Ends the current frame
    }

}
