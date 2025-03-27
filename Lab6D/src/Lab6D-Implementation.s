        .syntax     unified
        .cpu        cortex-m4
        .text

// void Hanoi(int num, int fm, int to, int aux) ;

        .global     Hanoi
        .thumb_func
        .align
//R0 = num, R1 = fm, R2 = to, R3 = aux
Hanoi:  
        PUSH        {R4-R7,LR}
        MOV         R4,R0   //num -> R4
        MOV         R5,R1   //fm -> R5
        MOV         R6,R2   //to -> R6
        MOV         R7,R3   //aux -> R7
	    CMP         R4,1    //Compare num with 1
        BLE         Hanoi1  //Continue if num is less than 1
 	    SUB         R0,R0,1 //Prep the hanoi recursive call for the next couple of lines num -1 -> R0
        MOV         R2,R7   //aux -> R2
        MOV         R1,R5   //fm -> R1
        MOV         R3,R6   //to -> R3
        BL          Hanoi   //Exectue the recursive call

Hanoi1: 
        MOV         R0,R5   //Prep the parameters for the Move1Disk function
        MOV         R1,R6   //^
        BL          Move1Disk //Move1Disk(fm, to)
        CMP         R4,1    //Compare num to 1
        BLE         Hanoi2  //If the number is less than 1 end the function
 	    MOV         R0,R4   //Restore Num in R0
        SUB         R0,R0,1 //Prepare num by decrementing by 1
        MOV         R1,R7   //aux -> R1
        MOV         R3,R5   //fm -> R3
        MOV         R2,R6   //to -> R2
        BL          Hanoi   //Yes --> Hanoi(num - 1, aux, to, fm)

Hanoi2: 
        POP         {R4-R7,PC}//Restore the variable registers to their previous state
        .end
