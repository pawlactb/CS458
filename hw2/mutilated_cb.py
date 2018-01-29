checkerboard_size = 4

missing_x1 = 2
missing_x2 = 3

missing_y1 = 4
missing_y2 = 4

def generate_constants():
    for x in range(checkerboard_size-1):
        for y in range(checkerboard_size-1):
            print("(declare-const h" + str(x) + str(y) + " Bool)")
            print("(declare-const v" + str(x) + str(y) + " Bool)")
            
def generate_assertion_mutilation():
    print("(assert 
