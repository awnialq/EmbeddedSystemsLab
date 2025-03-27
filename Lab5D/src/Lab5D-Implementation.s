        .syntax     unified
        .cpu        cortex-m4
        .text

// uint64_t TireDiam(uint32_t W, uint32_t A, uint32_t R) ;

        .global     TireDiam
        .thumb_func

        .align
TireDiam:       // R0 = W, R1 = A, R2 = R
	    PUSH        {R4}        //Preserves R4
        LDR         R4,=1270    //Stores the denominator
        MUL         R3,R0,R1    //Stores the numerator
        UDIV        R0,R3,R4    //Gets you the quotient
        ADD         R1,R0,R2    //Adds R to the quotient and stores it in R1
        MLS         R0,R4,R0,R3 //Gets you the remainder of the division operation.
        POP         {R4}        //Restores R4
        BX          LR

// uint64_t TireCirc(uint32_t W, uint32_t A, uint32_t R) ;

        .global     TireCirc
        .thumb_func

        .align
TireCirc:       // R0 = W, R1 = A, R2 = R
        PUSH        {LR}        //Preserve LR
        BL          TireDiam    //Call TireDiam to get the 64-bit addition
        LDR         R3,=4987290 //Load the first constant to be used
        MUL         R2,R1,R3    //Perform the multiplaction between the most significant part of TireDiam and the constant
        LDR         R3,=3927    //Load R3 with the 2nd constant to be used
        MLA         R2,R3,R0,R2 //Multiply the new constant with the least significant part of TireDiam and then add the R2 result to it and store in R2 to get the final dividend
        LDR         R3,=1587500 //Load R3 with the final constant to be used
        UDIV        R1,R2,R3    //Get the quotient of the divided and constant and store it as the most significant part
        MLS         R0,R3,R1,R2 //Get the remainder of the division operation and store it as the least significant part
        POP         {LR}
        BX          LR

        .end

