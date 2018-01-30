#!/bin/python


checkerboard_size = 4

missing_x1 = 1
missing_x2 = 2

missing_y1 = 3
missing_y2 = 3

def generate_constants():
    print(";_ij is the position of a horzontal (h) or vertical (v) domino")
    for x in range(checkerboard_size):
        for y in range(checkerboard_size):
            print("(declare-const h" + str(x) + str(y) + " Bool)")
            print("(declare-const v" + str(x) + str(y) + " Bool)")
            
def generate_basic_assertions():
    print(";We can't have verticals on the bottom row, or horizontals on the rightmost")
    for z in range(checkerboard_size):
        print("(assert (not h" + str(checkerboard_size-1) + str(z) + "))")
        print("(assert (not v" + str(z) + str(checkerboard_size-1) + "))")
        
    for x in range(checkerboard_size-1):
        for y in range(checkerboard_size-1):
            print("(assert (=> h" + str(x) + str(y) + " (and (not (or v" + str(x) + str(y) + " h" + str(x+1) + str(y) + " v" + str(x) + str(y+1) + ")))))")
            
            print("(assert (=> v" + str(x) + str(y) + " (and (not (or h" + str(x) + str(y) + " h" + str(x) + str(y+1) + " v" + str(x) + str(y+1) + ")))))")
            
def generate_assertion_mutilation(x, y):
    print(";We cannot have a horizontal domino left the mutilated square, or a vertical domino above.")
    print("(assert h" + str(x) + str(y) + ")")
    print("(assert v" + str(x) + str(y) + ")")
    if (x > 0):
        print("(assert (not h" + str(x-1) + str(y) + "))")
    if(y > 0):
        print("(assert (not v" + str(x) + str(y-1) + "))")
        
def fill_in():
    for x in range(checkerboard_size):
        for y in range(checkerboard_size):
            print("(assert (or v" + str(x) + str(y) + " h" + str(x) + str(y) + "))")
        
def main():
    generate_constants()
    generate_basic_assertions()
    generate_assertion_mutilation(missing_x1, missing_y1)
    generate_assertion_mutilation(missing_x2, missing_y2)
    print("(check-sat)")
    print("(get-model)")
    
if __name__ == "__main__":
    main()
