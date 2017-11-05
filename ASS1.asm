############################################
#team
############################################

.data
arr: .word 1 2 3 4 5 6 7
space: .asciiz " "
endl: .asciiz "\n"

.text
  main:
  	la $s0,arr
  	jal display
  	
  	li $a1,0
  	li $a2,24
  	
  	jal quickSort
	addi $v0,$0,10
	syscall
	
    
################
#dispaly function
################    
 display:
  	
	add $t2,$0,$s0		#load arr to $t2		
	addi $t0, $0, 0		#khoi tao bien diem $t0
	addi $t1, $0, 7
   loopDisplay:
	beq $t0, $t1, exitDisplay	#kiem tra dieu kien ket thuc ham
	lw $a0, 0($t2)		#load so can in ra
	addi $v0,$0,1
	syscall
	la $a0, space		#in dau cách
	addi $v0,$0,4
	syscall
	addi $t2, $t2,4		#tang chi so arr 
	addi $t0,$t0,1		#tang bien dem
	j loopDisplay
   exitDisplay:
   	la $a0,endl		#print endl
  	addi $v0,$0,4
  	syscall
   	jr $ra
####################################
#swap function
#parameter	$a1: num1 addres	$a2: num2 address
#return	void
########################################
 swap:
 	
 	
  	lw $t0,0($a1)		#luu num1 vào temp1 = $t0	
  	lw $t1,0($a2)		#luu num2 vào temp2 = $t1
  	sw $t1,0($a1)		#swap(num1,num2);
  	sw $t0,0($a2)
  	
  	jr $ra  	
####################################
# partition function
# parameter: 	$a1: left x4    $a2: right x4     $a3 :pivot=value
# return: 	$v1=partitionPoint
             		
####################################
 partition:
 	addi $sp,$sp,-4		#store $ra to stack
  	sw $ra,0($sp)
 	
  	
  	
 		
  	add $s1,$s0,$a1		#luu dia chi leftPointer ($s1 = address of leftPointer)
  	addi $s1,$s1,-4		#leftPointer= left-1
  	add $s2,$s0,$a2		#luu dia chi rifhtPointer ($s2 = address of rightPointer)
  	
    loopPartition:
      loopLeft:
    	addi $s1,$s1,4		# ++ leftPointer
    	lw $t1,0($s1)		#load so leftPointr vao bien $t1
    	slt $t0,$t1 ,$a3	#so sanh voi pivot
    	bne $t0,$0,loopLeft
      loopRight:
    	beq $s2,$s0,exitRight	#exit neu rightPointer=0
    	addi $s2,$s2,-4		# -- rightPointer
    	lw $t1,0($s2)		#load so leftPointr vao bien $t1
    	slt $t0,$t1 ,$a3	#so sanh voi pivot
    	beq $t0,$0,loopRight
         exitRight:
         	slt $t0,$s1,$s2		#if(leftPointer<rightPointer)
         	beq $t0,$0,exitLoopPartition	# branch when leftPoniter>= rightPointer
         	
         	addi $sp,$sp,-8		#add to stack
         	sw $a1,0($sp)
  	sw $a2,4($sp)
  	
         	add $a1,$0,$s1		#swap(leftPointer,rightPointer);
         	add $a2,$0,$s2
         	jal swap
         	
         	lw $a1,0($sp)		#load from stack
  	lw $a2,4($sp)
  	addi $sp,$sp,8
  	
         	j loopPartition
   exitLoopPartition:
   	addi $sp,$sp,-8		#add to stack
         	sw $a1,0($sp)
  	sw $a2,4($sp)
         	
 	add $a1,$0,$s1		#swap(leftPointer,right);
 	add $a2,$s0,$a2
         	jal swap
         	
         	lw $a1,0($sp)		#load from stack
  	lw $a2,4($sp)
  	addi $sp,$sp,8
  	
  	
  	
         	jal display		#print array
         	
         	add $v1,$0,$s1		#return partitionPointer=leftPointer
         	lw $ra,0($sp)
  	addi $sp,$sp,4
	
         	jr $ra		#exit Partition Function
        	