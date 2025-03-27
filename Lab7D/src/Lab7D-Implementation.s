        .syntax     unified
        .cpu        cortex-m4
        .text

// void PutNibble(void *nibbles, uint32_t index, uint32_t nibble) ;

        .global     PutNibble
        .thumb_func
        .align

PutNibble:
        LSRS        R1,1        //Divide index by 2 to get the 8 byte combo that nibble is located in
        LDRB        R3,[R0,R1]  //Load the nibble pair
        IT          CS          //Check if index was an odd number
        RORCS       R3,4        //if it is odd, rotate the 4 bits to the front
        BIC         R3,0xF      //Clear the first 4 bits
        ORR         R3,R3,R2    //set the first 4 bits
        IT          CS          //Check if index was an odd number
        RORCS       R3,28       //rotate the nibble back to be an 8 bit value while retaining the original first 4 bits
        STRB        R3,[R0,R1]  //store the new nibble in memmory
        BX          LR

// uint32_t GetNibble(void *nibbles, uint32_t index) ;

        .global     GetNibble
        .thumb_func
        .align

GetNibble:
        LSRS        R1,1        //Find the nibble pair index by dividing by 2
        LDRB        R0,[R0,R1]  //load the nibble pair
        ITE         CS          //if the index was odd
        LSRCS       R0,R0,4     //Bit shift 4 to the right to place the latter nibble in the spot of the first 4 bytes
        ANDCC       R0,R0,0xF   //clear the rest of the bits
        BX          LR
        .end
