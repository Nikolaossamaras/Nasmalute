extern exit
extern printf
extern scanf

section .data
    prompt db "Welcome to my calculator App made in nasm ",10,0
    question1 db "Enter your first number: ",0
    question2 db "Enter your second number: ",0
    operat db "Select an operation  1 for addition 2 for substraction 3 for multiplication and 4 for division ",0
    fmt db "%d",0
    output db "You total is : %d", 10, 0
    error db "You can't divide with 0",10,0
    error2 db "error please use one of the above actions next time",10,0
    bye db "bye bye ",10,0
    invalid_input_error db "please insert a number",10,0
    clear_fmt db "%*s",0

section .bss
    number1 resd 1 
    number2 resd 1 
    operation resd 1 

section .text
    global main
    main:
        sub rsp , 40 
    
        lea rcx,[rel prompt]
        call printf

    
    loop:
        jmp read_number1
        
        read_number1:
        lea rcx,[rel question1]
        call printf
        
        lea rcx,[rel fmt]
        lea rdx,[rel number1]
        call scanf
        
        cmp eax,1
        je read_number2

        cmp eax,-1
        je finish

        lea rcx,[rel invalid_input_error]
        call printf
    
        lea rcx,[rel clear_fmt]
        call scanf

        jmp read_number1
    read_number2:
        lea rcx,[rel question2]
        call printf
        
        lea rcx,[rel fmt]
        lea rdx,[rel number2]
        call scanf
        
        cmp eax,1
        je read_op

        cmp eax,-1
        je finish

        lea rcx,[rel invalid_input_error]
        call printf
    
        lea rcx,[rel clear_fmt]
        call scanf

        jmp read_number2
        read_op:
            

            lea rcx,[rel operat]
            call printf

            lea rcx,[rel fmt]
            lea rdx,[rel operation]
            call scanf

            

            cmp eax, 1
            mov eax ,[rel operation]
            je check_operation

            cmp eax, -1
            je finish

            lea rcx, [rel invalid_input_error]
            call printf

            lea rcx, [rel clear_fmt]
            call scanf

            jmp read_op
            check_operation:
                cmp eax,0
                je finish

                cmp eax,1
                je addition

                cmp eax,2
                je substraction

                cmp eax,3
                je multiplication

                cmp eax,4 
                je division


                lea rcx,[rel error2]
                call printf
                jmp loop
        
        addition:
            mov eax,[rel number1]
            add eax,[rel number2]

            mov edx,eax
            lea rcx,[rel output]
            call printf
            jmp loop
        substraction:
            mov eax,[rel number1]
            sub eax,[rel number2]

            mov edx,eax
            lea rcx,[rel output]
            call printf
            jmp loop
        multiplication:
            mov eax,[rel number1]
            imul eax,[rel number2]
            mov edx,eax
            lea rcx,[rel output]
            call printf
            jmp loop
        division:
            mov eax,[rel number1]
            mov ecx,[rel number2]
            
            cmp ecx,0
            je division_error
            cdq
            idiv ecx

            mov edx,eax

            lea rcx,[rel output]
            call printf
            jmp loop
        division_error:
            lea rcx,[rel error]
            call printf
            jmp loop
        finish:
            lea rcx,[rel bye]
            call printf
            xor ecx, ecx
            add rsp, 40
            ret