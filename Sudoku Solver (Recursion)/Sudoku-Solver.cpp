#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <fstream>
using namespace std;

//Checks if a given value (k) could go into row, col, or box and returns true if it can and false if it cant. All cases need to be true else false.
bool is_valid(vector<vector<int>>& grid, int row, int col, int k) {
    //Checks for K in the rows. (using find from algorithm class)
    bool not_in_row = find(grid[row].begin(), grid[row].end(), k) == grid[row].end();
    
    //Checks for K in the columns.
    bool not_in_column = true;
    for (int i = 0; i < 9; i++) {
        if (grid[i][col] == k) {
            not_in_column = false;
            break;
        }
    }
    
    //Checks for K in the 3x3 boxes.
    bool not_in_box = true;
    int box_r = (row / 3) * 3; //get the top left cell for any 3x3 box
    int box_c = (col / 3) * 3; //get the top left cell for any 3x3 box
    for (int i = box_r; i < box_r + 3; i++) {
        for (int j = box_c; j < box_c + 3; j++) {
            if (grid[i][j] == k) {
                not_in_box = false;
                break;
            }
        }
        if (!not_in_box) {
            break;
        }
    }
    return not_in_row && not_in_column && not_in_box;
}

bool solve(vector<vector<int>>& grid, int row = 0, int col = 0) {
    if (row == 9) { //Checks if the end of the puzzle is reached.
        return true; 
    } else if (col == 9) { //If row is not at the end but col is then we need to go to the next row. Call the function again (recursive).
        return solve(grid, row + 1, 0);
    } else if (grid[row][col] != 0) { //If a value in the grid is not 0 then it already has a value and we need to move onto the next cell. Call the function again (recursive).
        return solve(grid, row, col + 1);
    } else {
        for (int k = 1; k <= 9; k++) { //If a cell has a 0 then try any number k (1-9) and check if it is valid. 
            if (is_valid(grid, row, col, k) == true) {
                grid[row][col] = k; //If is_valid is true then replace the 0 with k.
                if (solve(grid, row, col + 1) == true) { //Move onto the next value in a row. Call the function again (recursive).
                    return true;
                }
                grid[row][col] = 0; //If the solve function returns false then you need to backtrack and set the current cell to 0 and try the next k value.
            }
        }
        return false;
    }
}

vector<int> GETROWS(int start) {
    fstream data = fstream("sudoku.json");
    char ch;
    int targetBrackets= start;
    int countBrackets = 0;
    int bracketPos;

    string searchString = "[";
    while (data.get(ch)) {
        if (ch == searchString[0]) {
            countBrackets++;
            if (countBrackets == targetBrackets) {
                bracketPos = data.tellg();
                break;
            }
        }
    }

    if (bracketPos >= 0) {
        data.seekg(bracketPos);
    }

    int closingBrackets = 0;
    string output;
    vector<int> row;
    
    while (data.get(ch)) {
        if (ch == ']') {
            closingBrackets++;
            if (closingBrackets == 1) {
                break;
            }
        }
        output = ch;
        if (ch != ',') {
            row.push_back(stoi(output));
        }
    }
    return row;
}

vector<vector<int>> grid(int sudoku) {
    vector<vector<int>> grid;

    if (sudoku >= 0 && sudoku <= 26) {
        sudoku += (3 + (9 * sudoku));
    }
    
    for(int i = 0; i< 9; i++) {
        vector<int> RowGetter = GETROWS(sudoku+i);
        grid.push_back(RowGetter);
    }

    return grid;
}

int main() {
    vector<vector<int>> GRID = grid(0);
    
    solve(GRID);

    //Outputs the result
    for (vector<int> row : GRID) {
        for (int num : row) {
            cout << num << " ";
        }
        cout << endl;
    }
    return 0;
}