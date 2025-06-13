.MODEL SMALL
.STACK 100H
.DATA
    menu DB 0AH,0DH,"Select Sorting Algorithm:",0AH,0DH
         DB "1. Bubble Sort",0AH,0DH
         DB "2. Insertion Sort",0AH,0DH
         DB "3. Selection Sort",0AH,0DH
         DB "4. Exit",0AH,0DH,'$'
    choice DB 0
    unsortedMsg DB 0AH,0DH,"Unsorted Array:",0AH,0DH,'$'
    sortedMsg DB 0AH,0DH,"Sorted Array:",0AH,0DH,'$'
    arr DB 5, 4, 3, 2, 1, 0 ; sample array
    arrLen DW 6 ; Changed to 6 as there are 6 elements in the array
    randSeed DW 1234H       ; Initial seed for random number generator
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

MENUU:
    LEA DX, menu
    MOV AH, 09H
    INT 21H

    ; Read user choice
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV choice, AL

    CMP choice, 4
    JE EXIT

    CALL DISPLAY_ARRAY

    CMP choice, 1
    JE BUBBLE_SORT

    CMP choice, 2
    JE INSERTION_SORT

    CMP choice, 3
    JE SELECTION_SORT

    JMP MENUU

DISPLAY_ARRAY PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    LEA DX, unsortedMsg
    MOV AH, 09H
    INT 21H

    MOV SI, 0
    MOV CX, arrLen
PRINT_LOOP:
    MOV AL, arr[SI]
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    MOV DL, ' '
    INT 21H

    INC SI
    LOOP PRINT_LOOP

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_ARRAY ENDP

BUBBLE_SORT PROC
    MOV CX, arrLen          ; Outer loop counter
    DEC CX
BUBBLE_OUTER_LOOP:
    MOV BX, CX              ; Inner loop counter
    MOV SI, 0               ; Index of arr
BUBBLE_INNER_LOOP:
    MOV AL, arr[SI]
    MOV DL, arr[SI+1]
    CMP AL, DL
    JBE NO_SWAP
    ; Swap arr[SI] and arr[SI+1]
    MOV arr[SI], DL
    MOV arr[SI+1], AL
NO_SWAP:
    INC SI
    DEC BX
    JNZ BUBBLE_INNER_LOOP
    DEC CX
    JNZ BUBBLE_OUTER_LOOP

    CALL DISPLAY_SORTED_ARRAY
    CALL SHUFFLE_ARRAY
    JMP MENUU
BUBBLE_SORT ENDP

INSERTION_SORT PROC
    MOV CX, 1               ; Start from the second element
INSERTION_OUTER_LOOP:
    MOV SI, CX
    MOV AL, arr[SI]         ; Element to insert
    MOV BX, SI
    DEC BX
INSERTION_INNER_LOOP:
    CMP BX, -1
    JE INSERTION_INSERT
    CMP arr[BX], AL
    JBE INSERTION_INSERT
    ; Shift element right
    MOV DL, arr[BX]
    MOV arr[SI], DL
    DEC SI
    DEC BX
    JMP INSERTION_INNER_LOOP
INSERTION_INSERT:
    MOV arr[SI], AL         ; Place the element
    INC CX
    CMP CX, arrLen
    JNE INSERTION_OUTER_LOOP

    CALL DISPLAY_SORTED_ARRAY
    CALL SHUFFLE_ARRAY
    JMP MENUU
INSERTION_SORT ENDP

SELECTION_SORT PROC
    MOV CX, arrLen
    DEC CX
SELECTION_OUTER:
    MOV BX, CX
    MOV SI, 0
    MOV DI, 0
SELECTION_INNER:
    MOV AL, arr[SI]
    MOV DL, arr[DI]
    CMP AL, DL
    JAE NEXT_SELECTION
    MOV DI, SI
NEXT_SELECTION:
    INC SI
    CMP SI, BX
    JLE SELECTION_INNER

    ; Swap arr[DI] and arr[BX]
    MOV AL, arr[DI]
    MOV DL, arr[BX]
    MOV arr[DI], DL
    MOV arr[BX], AL

    DEC CX
    JNZ SELECTION_OUTER

    CALL DISPLAY_SORTED_ARRAY
    CALL SHUFFLE_ARRAY
    JMP MENUU
SELECTION_SORT ENDP

SHUFFLE_ARRAY PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    MOV CX, arrLen
    DEC CX
SHUFFLE_OUTER_LOOP:
    MOV SI, CX

    ; Generate a random number
    CALL RANDOM
    MOV BX, AX
    XOR DX, DX
    DIV CX
    MOV BX, DX ; Random index in the range [0, CX]

    ; Swap arr[SI] and arr[BX]
    MOV AL, arr[SI]
    MOV DL, arr[BX]
    MOV arr[SI], DL
    MOV arr[BX], AL

    DEC CX
    JNZ SHUFFLE_OUTER_LOOP

    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
SHUFFLE_ARRAY ENDP

RANDOM PROC
    ; Linear Congruential Generator (LCG) algorithm
    ; Xn+1 = (a*Xn + c) mod m
    ; We'll use a=1103515245, c=12345, m=2^16
    ; In practice, a, c, and m should be chosen carefully
    MOV AX, randSeed
    MOV DX, 11035
    MUL DX
    ADD AX, 12345
    MOV randSeed, AX
    RET
RANDOM ENDP

DISPLAY_SORTED_ARRAY PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    LEA DX, sortedMsg
    MOV AH, 09H
    INT 21H

    MOV SI, 0
    MOV CX, arrLen
PRINT_LOOP_SORTED:
    MOV AL, arr[SI]
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    MOV DL,' '
    INT 21H

    INC SI
    LOOP PRINT_LOOP_SORTED

    MOV DL, 0AH ; Carriage return
    MOV AH, 02H ; BIOS display function.
    INT 21H
    MOV DL, 0DH ; Line feed
    MOV AH, 02
    INT 21H

    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DISPLAY_SORTED_ARRAY ENDP

EXIT:
    MOV AH, 4CH
    INT 21H

END MAIN
