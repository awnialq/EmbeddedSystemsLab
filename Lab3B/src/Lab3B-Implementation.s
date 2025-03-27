        .syntax         unified
        .cpu            cortex-m4
        .text

// int32_t Return32Bits(void) ;

        .global         Return32Bits
        .thumb_func
        .align
Return32Bits:

//Implementation
        LDRSB           R0, =10
        BX              LR

// int64_t Return64Bits(void) ;

        .global         Return64Bits
        .thumb_func
        .align
Return64Bits:

//Implementation
        LDR             R0,=-10 //Load R0 with -10
        LDR             R1,=-1  //Fill the entire 2nd register with -1 to allow for the 64-bit representation of -10 to be accurate as it is a neg number.
        BX              LR

// uint8_t Add8Bits(uint8_t x, uint8_t y) ;

        .global         Add8Bits
        .thumb_func
        .align
Add8Bits:

//Implementation
         ADD            R0, R0, R1
         SXTB           R0, R0     //Stores the first 8 bits of the addition result from the previous instruction and then does a 0 or 1 fill depending on the sign
         BX             LR

// uint32_t FactSum32(uint32_t x, uint32_t y) ;

        .global         FactSum32
        .thumb_func
        .align
FactSum32:

//Implementation
         PUSH           {R4,LR}
         ADD            R0,R0,R1  //Adds x and y and puts them in R0 where they will be modified by the function FACTORIAL
         BL             Factorial
         POP            {R4,PC}

// uint32_t XPlusGCD(uint32_t x, uint32_t y, uint32_t z) ;

        .global         XPlusGCD
        .thumb_func
        .align
XPlusGCD:

//Implementation
         PUSH           {R4,LR}
         MOV            R4,R0    //Store the Original R0 value into R4 becuase it is always preserved
         MOV            R0,R1    //Shift the parameters so they are ready for the GCD function
         MOV            R1,R2    // ^
         BL             gcd
         ADD            R0,R0,R4 // Add the result of gcd (in R0) with the x parameter in R4
         POP            {R4,PC}  // Restore the value of R4 and the Program Counter

        .end


