# CAN DUYAR - 171044075
.data
     input_message:  .asciiz "Enter the array size value: "
     input_message2: .asciiz "\nEnter the target value: "
     input_message3: .asciiz "\nEnter elements of array(line by line):\n"
     arr:	     .word 0:100
     arraySize:      .word 0
     num:            .word 0
     #empty: .asciiz " "  # I tried to used it for bonus part
     possible: .asciiz "Possible!\n"
     not_possible: .asciiz "Not possible!\n"     

.text
    .globl main 
    main:
     	# cin >> arraySize;
        li $v0, 4
        la $a0, input_message
        syscall
        
        li $v0, 5
        syscall
        
        sw $v0, arraySize
	move $a3, $v0 # I used $a3 register to send arraySize value as parameter 
	
	#cin >> num;               
	li $v0, 4
        la $a0, input_message2
        syscall
        
	li $v0, 5
        syscall
        
        sw $v0, num
        move $a1,$v0 # I used $a1 register to send num value as parameter 
        
        li $v0, 4
        la $a0, input_message3
        syscall        
        

	li $s0,0
	la $s1,arr


#for(int i = 0; i < arraySize; ++i){cin >> arr[i];}
	rd_loop:li $v0,5 
 		syscall
 		mul $t0,$s0,4
 		add $t0,$s1,$t0
 		sw $v0,($t0)
 		add $s0,$s0,1
 		blt $s0,$a3,rd_loop

		li $s0,0 
		la $s1,arr 

      		move $a2, $s1 # I used $a2 register to send the arr[ ] as parameter 
		#returnVal = CheckSumPossibility(num,arr,arraySize);
		jal CheckSumPossibility
		# if(returnVal == 1){cout << "Possible!" << endl;}
		bne $v1,$zero,P
		#else{cout << "Not possible!" << endl;}
       		beq $v1,$zero,NP   

#POSSIBLE 
P: 
	li $v0, 4
        la $a0, possible
        syscall
        j done 

# NOT POSSIBLE
NP:	
	li $v0, 4
        la $a0, not_possible
        syscall
        j done

#tell the system that the program is done
done:
	li $v0,10
	syscall
	  
CheckSumPossibility: 
 	addiu $sp, $sp, -12
 	sw $a3,8($sp)
 	sw $a1, 0($sp) 
 	sw $ra, 4($sp) 
 
	beq $a1, $zero, condition     # if (num == 0){return 1;}
	beq $a3,$zero, condition2    #if (arraysize == 0){return 0;}
	move $t0,$zero
	
	addiu $t0, $a3, -1 # address of arr[arraysize-1]
	mul $t0,$t0,4
	addu $t0, $t0, $a2  #array+....
	lw $s0, 0($t0) # s0 = arr[arraysize-1]
	# if (arr[arraySize - 1] > num){ return CheckSumPossibility(num, arr, arraySize - 1);}
	bgt $s0, $a1, condition3 

	addiu $a3, $a3, -1 # set arguments
	jal CheckSumPossibility # CheckSumPossibility(num,arr,arraysize - 1)
	bne $v1,$zero,label
	move $t0,$zero

	lw $a3,8($sp)
	lw $a1,0($sp)
	addiu $t0, $a3, -1 # address of arr[arraysize-1]
	mul $t0,$t0,4
	addu $t0, $t0, $a2  #array+....
	
	lw $s0, 0($t0) # s0 = arr[arraysize-1]
	sub $t1,$a1,$s0 # address of( num - arr[arraySize-1])
	addiu $a1, $t1,0 # set arguments
	addi $a3,$a3,-1
	jal CheckSumPossibility # CheckSumPossibility(num-arr[arraySize-1],arr,arraySize-1)

	bne $v1,$zero,label
	li $v1, 0
	j CheckSumPossibility_end


label:	
#COMMENT PARTS ARE RELATED WITH BONUS PART,I TRIED TO DO IT, BUT IT DIDN'T WORK PROPERLY
	#move $t0,$zero	
	#addiu $t0, $a3, -1 # address of arr[arraysize-1]
	#mul $t0,$t0,4
	#addu $t0, $t0, $a2  #array+....
	#lw $s0, 0($t0) # s0 = arr[arraysize-1]
        #li $v0, 4
        #move $a0, $s0
        #syscall	
	li $v1, 1
	j CheckSumPossibility_end 

condition:  li $v1, 1
	   j CheckSumPossibility_end 

condition2: li $v1, 0
	   j CheckSumPossibility_end

condition3: 
        addiu $a3, $a3, -1 # set arguments
	jal CheckSumPossibility # CheckSumPossibility(num,arr,arraysize - 1)
	j CheckSumPossibility_end
	 	 	 	 
CheckSumPossibility_end: 
	lw $ra, 4($sp) # restore $ra
	addiu $sp, $sp, 12
 	jr $ra




	        	        	        
	        	        	        	        
	        	        	        	        	        
	        	        	        	        	        	        
	        	        	        	        	        	        	        
	        	        	        	        	        	        	        	        
	        	        	        	        	        	        	        	        	        
	        	        	        	        	        	        	        	        	        	        
	        	        	        	        	        	        	        	        	        	        	        
	        	        	        	        	        	        	        	        	        	        	        	        
	        	        	        	        	        	        	        	   
