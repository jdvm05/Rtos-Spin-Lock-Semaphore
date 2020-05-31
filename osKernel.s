		AREA |.text|, CODE, READONLY, ALIGN=2
        THUMB
		EXTERN  currentPt
		EXPORT	SysTick_Handler
		EXPORT  osSchedulerLaunch


SysTick_Handler          ;save r0,r1,r2,r3,r12,lr,pc,psr      
    CPSID   I               ;Disbale interrupts
    PUSH    {R4-R11}        ;save r4,r5,r6,r7,r8,r9,r10,r11   onto the stack
    LDR     R0, =currentPt  ; r0 points to currentPt       
    LDR     R1, [R0]        ; r1= currentPt   
    STR     SP, [R1]           
    LDR     R1, [R1,#4]     ; r1 =currentPt->next   
    STR     R1, [R0]        ;currentPt =r1   
    LDR     SP, [R1]        ;SP= currentPt->stackPt   
    POP     {R4-R11}           
    CPSIE   I               ;Enable interrupts
    BX      LR 
	
	

osSchedulerLaunch
    LDR     R0, =currentPt ;pointing R0 ti the currentPt        
    LDR     R2, [R0]       ; R2 =currentPt       
    LDR     SP, [R2]       ;SP = currentPt->stackPt    this 3 steps load currentPt which we set task 1 to SP
    POP     {R4-R11}          
    POP     {R0-R3}            
    POP     {R12}
    ADD     SP,SP,#4        ;add 4 to the stack pointer to get rid of the LR   
    POP     {LR}             ;pop value int LR  
    ADD     SP,SP,#4         ;add 4 to get rid of the PSR
    CPSIE   I                 ;enable interrupts
    BX      LR                 

    ALIGN
    END