        .syntax     unified
        .cpu        cortex-m4
        .text

// uint32_t Time2Msecs(uint32_t hour, uint32_t mins, uint32_t secs) ;

        .global     Time2Msecs
        .thumb_func

        .align
Time2Msecs:

        // R0 = hour
        // R1 = mins
        // R2 = secs
        LSL         R3,R0,6         //R3 = 64*hr
        SUB         R0,R3,R0,LSL 2  //R3 - 4*hr to get R3 = 60*hr
        ADD         R0,R0,R1        //add minutes
        LSL         R3,R0,6         //same thing to get 60*R3
        SUB         R0,R3,R0,LSL 2  
        ADD         R0,R0,R2        //add seconds to the previous calculations
        LSL         R3,R0,10        
        SUB         R3,R3,R0,LSL 5
        ADD         R0,R3,R0,LSL 3  //Finalize the millisecond value by doing LSL 10 - LSL 5 + LSL 3
        BX          LR                        

// void Msecs2Time(uint32_t msec, uint32_t *hour, uint32_t *mins, uint32_t *secs) ;

        .global     Msecs2Time
        .thumb_func

    .align
Msecs2Time:

        // R0 = msec
        // R1 = ptr to hour
        // R2 = ptr to mins
        // R3 = ptr to secs
        PUSH        {R4,LR}
        LDR         R12,=274877907  //Magic number -> R12
        UMULL       R12,R0,R12,R0   
        LSRS        R0,R0,6         //seconds = msec/1000
        LDR         R12,=2443359173 
        UMULL       R12,R4,R12,R0
        LSRS        R4,R4,11        //hours = seconds/3600
        STR         R4,[R1]         //Store hours
        LDR         R12,=3600      
        MLS         R0,R12,R4,R0    //seconds = seconds - 3600*hr
        LDR         R12,=2290649225
        UMULL       R12,R4,R12,R0
        LSRS        R4,R4,5
        STR         R4,[R2]         //store s/6 aka minutes
        LDR         R12,=60
        MLS         R0,R12,R4,R0    //Final second value = R0 (seconds) - 60*minutes
        STR         R0,[R3]
        POP         {R4,PC}         //Restore registers
        BX          LR 
        .end
