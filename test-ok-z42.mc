//OPIS: inkrement u numexp-u
//RETURN: 6

unsigned y;

unsigned main() {
    unsigned x;
    x = 2u;
    y = 6u;

    x = x + (x<y) ? x : y + 2u;
    return x;
}

