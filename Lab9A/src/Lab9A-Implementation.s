            .syntax     unified
            .cpu        cortex-m4
            .text

            .global     Discriminant
            .thumb_func
            .align

// float Discriminant(float a, float b, float c) ;
Discriminant:
                VMOV		S3,4.0		//Load 4 into S3
			    VMUL.F32	S3,S0,S3	//Multiply 4 and cortex
				VMUL.F32	S3,S3,S2	//Multiply 4*c and a
				VMUL.F32	S1,S1,S1	//square b
				VSUB.F32	S0,S1,S3	
			    BX	        LR

            .global     Root1
            .thumb_func
            .align

// float Root1(float a, float b, float c) ;
Root1:      
                PUSH		{LR}		//Preserve LR
			    VPUSH		{S16,S17}	//We are going to use S16 and S17 to preserve a and b
				VMOV		S16,S0		//Preserve a
				VMOV		S17,S1		//preserve b
			    BL			Discriminant//Get the Discriminant
			    VNEG.F32	S17,S17		//Negate b
			    VSQRT.F32	S0,S0		//Square root the Discriminant
			    VADD.F32	S0,S17,S0	//add the discriminant and the negated b
			    VMOV		S1,2.0		//prepare a constant 2
			    VMUL.F32	S1,S1,S16	//multiply 2 and c to get the denominator
			    VDIV.F32	S0,S0,S1	//Do the division
			    VPOP		{S16,S17}	//Restore S16 and S17
			    POP			{PC}		//Restore the return address

            .global     Root2
            .thumb_func
            .align

// float Root2(float a, float b, float c) ;
Root2:      
               	PUSH		{LR}		//Preserve LR
				VPUSH		{S16,S17}	//We are going to use S16 and S17 to preserve a and b
				VMOV		S16,S0		//Preserve a
				VMOV		S17,S1		//preserve b
				BL			Discriminant//Get the Discriminant
				VNEG.F32	S17,S17		//Negate b
				VSQRT.F32	S0,S0		//Square root the Discriminant
				VSUB.F32	S0,S17,S0	//subtract the discriminant and the negated b
				VMOV		S1,2.0		//prepare a constant 2
				VMUL.F32	S1,S1,S16	//multiply 2 and c to get the denominator
				VDIV.F32	S0,S0,S1	//Do the division
				VPOP		{S16,S17}	//Restore the return address
				POP			{PC}

            .global     Quadratic
            .thumb_func
            .align

// float Quadratic(float x, float a, float b, float c) ;
Quadratic:  
               	VMLA.F32	S2,S1,S0	//a*x +  b -> S2
				VMLA.F32	S3,S2,S0	//S2 * x + c-> S3
				VMOV		S0,S3		//Move the result into S0
				BX			LR

            .end
