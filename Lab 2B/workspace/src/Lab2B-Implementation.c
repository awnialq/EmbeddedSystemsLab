
#include <stdint.h>
/*
* This function takes the magnitude value mag and converts it to the given radix. 
* First, the magnitude value is directly converted to the other radix and the respective digit is placed into the digits array.
* Then, the digits are placed into the string based on the digit's value reference to the table array.
* The end of the string then has a terminating character.
*/
static void Magnitude2String(uint8_t mag, char str[], unsigned radix) {
    static const char table[] = "0123456789ABCDEF";
    int digits[3], index, j;
    index = 0;
    for (j = 2; j >= 0; j--) {
        digits[j] = mag % radix;
        mag = mag / radix;
    }
    for (j = 0; j < 3; j++) {
        int digit = digits[j];
        str[index++] = table[digit];
    }
    str[index] = '\0';
}
//radix 8
void Bits2OctalString(uint8_t bits, char string[])
    {
    Magnitude2String(bits, string, 8);
    }

//radix 10
void Bits2UnsignedString(uint8_t bits, char string[])
    {
    Magnitude2String(bits, string, 10);
    }

//radix 16
void Bits2HexString(uint8_t bits, char string[])
    {
    Magnitude2String(bits, string, 16);
    }
/*
* This function takes the bits input (a regular decimal number) and checks its binary to see if it is a negative number.
* If it is, it then flips the bits and adds a binary 1 to the number and presets the string prefix with a '-'
* If not it does not do any conversion but instead adds a '+' to the front of the string.
*/
void Bits2TwosCompString(uint8_t bits, char string[])
    {
    if ((bits & 0b10000000) == 0b10000000) {
        bits = ~bits;
        bits += 0b00000001;
        string[0] = '-';
    }
    else {
        string[0] = '+';
    }
    Bits2UnsignedString(bits, string + 1);
    }
/*
* This function checks if the bit is signed and then applies the + or - to the string. it then bit shifts a 1 7 bits to the left (makes it a 128 magnitude value) and then feeds it into the 
Bits2UnsignedString function.
*
*
*/
void Bits2SignMagString(uint8_t bits, char string[])
    {
    if ((bits & 0b10000000) != 0) {
        string[0] = '-';
    }
    else {
        string[0] = '+';
    }
    unsigned mag = bits & ~(1 << 7);
    Bits2UnsignedString(mag, string + 1);
    }

