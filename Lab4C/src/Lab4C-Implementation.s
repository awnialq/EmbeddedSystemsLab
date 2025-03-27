        .syntax     unified
        .cpu        cortex-m4
        .text

// ----------------------------------------------------------
// unsigned HalfWordAccess(int16_t *src) ;
// ----------------------------------------------------------

        .global     HalfWordAccess
        .thumb_func
        .align
HalfWordAccess:
	    .rept       100
        LDRH        R1,[R0]
        .endr
        BX          LR


// ----------------------------------------------------------
// unsigned FullWordAccess(int32_t *src) ;
// ----------------------------------------------------------

        .global     FullWordAccess
        .thumb_func
        .align
FullWordAccess:
	    .rept       100
        LDR         R1,[R0]
        .endr
        BX          LR

// ----------------------------------------------------------
// unsigned NoAddressDependency(uint32_t *src) ;
// ----------------------------------------------------------

        .global     NoAddressDependency
        .thumb_func
        .align
NoAddressDependency:
	    .rept       100
        LDR         R1,[R0]
        LDR         R2,[R0]
        .endr
        BX          LR

// ----------------------------------------------------------
// unsigned AddressDependency(uint32_t *src) ;
// ----------------------------------------------------------

        .global     AddressDependency
        .thumb_func
        .align
AddressDependency:
	    .rept       100
        LDR         R1,[R0]
        LDR         R0,[R1]
        .endr
        BX          LR
// ----------------------------------------------------------
// unsigned NoDataDependency(float f1) ;
// ----------------------------------------------------------

        .global     NoDataDependency
        .thumb_func
        .align
NoDataDependency:
	    .rept       100
        VADD.F32    S1,S0,S0
        VADD.F32    S2,S0,S0
        .endr
        VMOV        S1,S0
        BX          LR

// ----------------------------------------------------------
// unsigned DataDependency(float f1) ;
// ----------------------------------------------------------

        .global     DataDependency
        .thumb_func
        .align
DataDependency:
	    .rept       100
        VADD.F32    S1,S0,S0
        VADD.F32    S0,S1,S1
        .endr
        VMOV        S1,S0
        BX          LR

// ----------------------------------------------------------
// void VDIVOverlap(float dividend, float divisor) ;
// ----------------------------------------------------------

        .global     VDIVOverlap
        .thumb_func
        .align
VDIVOverlap:
	    VDIV.F32    S2,S1,S0
        .rept       1
        NOP
        .endr
        VMOV        S3,S2
        BX           LR
        .end
