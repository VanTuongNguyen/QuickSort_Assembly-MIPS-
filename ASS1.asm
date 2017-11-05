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
   	
