.data
	fileName: .asciiz "D:\FILETEST.txt" # the file is created in the directory where file is run
	input_string: .space 20
	attack_string: .space 5
	# addr = baseAddr + (rowIndex * colSize + colIndex) * dataSize
	point1: .word 0
	point2: .word 0
	p1: .asciiz "Player 1: \n"
	p2: .asciiz "Player 2: \n"
	pa: .asciiz "Number 1 represents where you have shoot! \n"
	attacktime: .asciiz "NOW, IT'S ATTACK TIME!!! \n"	
	m1:	.word 0, 0, 0, 0, 0, 0, 0 # Map ship of player 1
		.word 0, 0, 0, 0, 0, 0, 0
		.word 0, 0, 0, 0, 0, 0, 0
		.word 0, 0, 0, 0, 0, 0, 0
		.word 0, 0, 0, 0, 0, 0, 0
		.word 0, 0, 0, 0, 0, 0, 0
		.word 0, 0, 0, 0, 0, 0, 0
	m2:	.word 0, 0, 0, 0, 0, 0, 0 # Map ship of player 2
		.word 0, 0, 0, 0, 0, 0, 0
		.word 0, 0, 0, 0, 0, 0, 0
		.word 0, 0, 0, 0, 0, 0, 0
		.word 0, 0, 0, 0, 0, 0, 0
		.word 0, 0, 0, 0, 0, 0, 0
		.word 0, 0, 0, 0, 0, 0, 0
	ma1:		.word 0, 0, 0, 0, 0, 0, 0 # Map has attacked of player 1
			.word 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0
	ma2:		.word 0, 0, 0, 0, 0, 0, 0 # Map has attacked of player 2
			.word 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0
			.word 0, 0, 0, 0, 0, 0, 0
	enterShip: .asciiz "Enter your ship in format Row_Bow Col_Bow Row_Stern Col_Stern: "
	warnS: .asciiz "Your ship's coordinate has the wrong format! Please reenter the information \n"
	warnDup: .asciiz "The coordinate is already placed a ship. Please reenter the bow. \n"
	warnAlreadyHit: .asciiz "You have hit that point already! Please rechoose the row and column!"
	warnOutSideMap: .asciiz "Your point is outside the map, please reenter the value from 0 to 6!"
	warnSize4: .asciiz "Your ship is not true size of 4x1! Please reenter the information about the ship! \n"
	warnSize3: .asciiz "Your ship is not true size of 3x1! Please reenter the information about the ship! \n"
	warnSize2: .asciiz "Your ship is not true size of 2x1! Please reenter the information about the ship! \n"
	warnWrongAttack: .asciiz "The coordinate is outside the map. Please reenter your coordinate! \n"
	warnDupAttack: .asciiz "The coordinate is duplicated in the map. Please reenter your coordinate! \n"
	welcome: .asciiz "WELCOME TO BATTLESHIP \n"
	player1enter: .asciiz "Player 1 please enter your ship in order of 1 4x1 ship, 2 3x1 ships, and 3 2x1 ships! \n"
	player2enter: .asciiz "Player 2 please enter your ship in order of 1 4x1 ship, 2 3x1 ships, and 3 2x1 ships! \n"
	p1entershort: .asciiz "P1 enter" # 8
	p2entershort: .asciiz "P2 enter"
	p2shootshort: .asciiz "P2 shoot" # 8
	p1shootshort: .asciiz "P1 shoot"
	remind4: .asciiz "Please enter a 4x1 ship! \n"
	remind3: .asciiz "Please enter a 3x1 ship! \n"
	remind2: .asciiz "Please enter a 2x1 ship! \n"
	player1turn: .asciiz "Player 1 enters the coordinate to attack as row col: "
	player2turn: .asciiz "Player 2 enters the coordinate to attack as row col: "
	winner1: .asciiz "Player 1 has won! Congratulation!!! \n"
	winner2: .asciiz "Player 2 has won! Congratulation!!! \n"
	winner1short: .asciiz "P1 won" # 6
	winner2short: .asciiz "P2 won"
	dupshort: .asciiz "Duplicate!" # 10
	sizeshort: .asciiz "Wrong size!" # 11
	outmap: .asciiz "Outside map!" # 12
	formatshort: .asciiz "Wrong format!" # 13 
	endl: .asciiz "\n"
	blankline: .asciiz "------------------------------------------------------------------------ \n" 
	space: .asciiz " "
	number: .asciiz "x 0 1 2 3 4 5 6 \n" 
	hit: .asciiz "HIT! \n"
	hitshort: .asciiz "HIT!" # 4
	miss: .asciiz "MISS! \n"
	missshort: .asciiz "MISS!" # 5
.text
	main:
		li $v0, 13
    		la $a0, fileName
    		li $a1, 1 # open for writing 
    		syscall # open file
    		move $s6, $v0 # save the file description
		jal UI1
		li $v0, 4
		la $a0, player1enter
		syscall
		jal printMapP1
		la $s1, m1
		la $a3, m1
		li $s3, 3
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p1entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP1
		la $s1, m1
		la $a3, m1
		li $s3, 2
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p1entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP1
		la $s1, m1
		la $a3, m1
		li $s3, 2
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p1entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP1
		la $s1, m1
		la $a3, m1
		li $s3, 1
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p1entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP1
		la $s1, m1
		la $a3, m1
		li $s3, 1
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p1entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP1
		la $s1, m1
		la $a3, m1
		li $s3, 1
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p1entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP1
		li $v0, 4
    		
		la $a0, player2enter
		syscall
		jal printMapP2
		la $s1, m2
		la $a3, m2
		li $s3, 3
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p2entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP2
		la $s1, m2
		la $a3, m2
		li $s3, 2
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p2entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP2
		la $s1, m2
		la $a3, m2
		li $s3, 2
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p2entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP2
		la $s1, m2
		la $a3, m2
		li $s3, 1
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p2entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP2
		la $s1, m2
		la $a3, m2
		li $s3, 1
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p2entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP2
		la $s1, m2
		la $a3, m2
		li $s3, 1
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, p2entershort
    		li $a2, 8 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		jal entership
		jal printMapP2
		jal fakeClearPage
		j beginGame
	beginGame:
		li $v0, 4
		la $a0, attacktime
		syscall
		la $s1, point2
		lw $s1, ($s1)
		player1shoot:
			jal printMapAttackP1
			li $v0, 4
			la $a0, player1turn
			syscall
			
			li $v0, 15
   			move $a0, $s6
    			la $a1, p1shootshort
    			li $a2, 8 
    			syscall
    		
    			li $v0, 15
   			move $a0, $s6
    			la $a1, endl
    			li $a2, 1
    			syscall
    			
			li $v0, 8
			la $a0, attack_string
			li $a1, 5
			syscall
			
			li $v0, 15
   			move $a0, $s6
    			la $a1, attack_string
    			li $a2, 3
    			syscall
    		
    			li $v0, 15
   			move $a0, $s6
    			la $a1, endl
    			li $a2, 1
    			syscall
    			
			j checkAttack1
		player2shoot:
			jal printMapAttackP2
			li $v0, 4
			la $a0, player2turn
			syscall
			
			li $v0, 15
   			move $a0, $s6
    			la $a1, p2shootshort
    			li $a2, 8 
    			syscall
    		
    			li $v0, 15
   			move $a0, $s6
    			la $a1, endl
    			li $a2, 1
    			syscall
    			
			li $v0, 8
			la $a0, attack_string
			li $a1, 5
			syscall
			
			li $v0, 15
   			move $a0, $s6
    			la $a1, attack_string
    			li $a2, 3
    			syscall
    		
    			li $v0, 15
   			move $a0, $s6
    			la $a1, endl
    			li $a2, 1
    			syscall
    			
			j checkAttack2
	checkAttack1:
		la $a0, attack_string
		lb $t0, ($a0)
		subi $t0, $t0, 48
		blt $t0, 0, warnAttack1
		bgt $t0, 6, warnAttack1
		addi $a0, $a0, 1
		lb $t1, ($a0)
		bne $t1, 32, warnAttack1
		addi $a0, $a0, 1
		lb $t1, ($a0)
		subi $t1, $t1, 48
		blt $t1, 0, warnAttack1
		bgt $t1, 6, warnAttack1
		addi $t0, $t0, 0
		addi $t1, $t1, 0
		la $a1, ma1
		mul $t4, $t0, 7 #get the row
		add $t4, $t4, $t1 # get the col
		mul $t4, $t4, 4
		add $t4, $t4, $a1
		lw $s2, ($t4)
		beqz $s2, changeMapAttack1
		j warnDuplicateAttack1
		continueAttack1:
		mul $t4, $t0, 7 #get the row
		add $t4, $t4, $t1 # get the col
		mul $t4, $t4, 4
		la $a1, m2
		add $t4, $t4, $a1
		lw $t2, ($t4)
		beq $t2, 1, increasePoint1
		li $v0, 4
		la $a0, miss
		syscall
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, missshort
    		li $a2, 5 
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		doneIncreasePoint1:
		beq $s1, 16, saywin1
		j player2shoot
	increasePoint1:
		li $v0, 4
		la $a0, hit
		syscall
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, hitshort
    		li $a2, 4
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		la $s0, point1
		lw $s1, ($s0)
		addi $s1, $s1, 1
		sw $s1, ($s0)
		j doneIncreasePoint1
	changeMapAttack1:
		li $t3, 1
		sw $t3, ($t4)
		j continueAttack1
	checkAttack2:
		la $a0, attack_string
		lb $t0, ($a0)
		subi $t0, $t0, 48
		blt $t0, 0, warnAttack2
		bgt $t0, 6, warnAttack2
		addi $a0, $a0, 1
		lb $t1, ($a0)
		bne $t1, 32, warnAttack2
		addi $a0, $a0, 1
		lb $t1, ($a0)
		subi $t1, $t1, 48
		blt $t1, 0, warnAttack2
		bgt $t1, 6, warnAttack2
		addi $t0, $t0, 0
		addi $t1, $t1, 0
		la $a1, ma2
		mul $t4, $t0, 7 #get the row
		add $t4, $t4, $t1 # get the col
		mul $t4, $t4, 4
		add $t4, $t4, $a1
		lw $s2, ($t4)
		beqz $s2, changeMapAttack2
		j warnDuplicateAttack2
		continueAttack2:
		mul $t4, $t0, 7 #get the row
		add $t4, $t4, $t1 # get the col
		mul $t4, $t4, 4
		la $a1, m2
		add $t4, $t4, $a1
		lw $t2, ($t4)
		beq $t2, 1, increasePoint2
		li $v0, 4
		la $a0, miss
		syscall
		doneIncreasePoint2:
		beq $s1, 16, saywin2
		j player1shoot
	increasePoint2:
		li $v0, 4
		la $a0, hit
		syscall
		la $s0, point2
		lw $s1, ($s0)
		addi $s1, $s1, 1
		sw $s1, ($s0)
		j doneIncreasePoint2
	changeMapAttack2:
		li $t3, 1
		sw $t3, ($t4)
		j continueAttack2
	saywin1:
		li $v0, 4
		la $a0, winner1
		syscall
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, winner1short
    		li $a2, 6
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		j exit
	saywin2:
		li $v0, 4
		la $a0, winner2
		syscall
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, winner2short
    		li $a2, 6
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		j exit
	warnAttack1:
		li $v0, 4
		la $a0, warnWrongAttack
		syscall 
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, formatshort
    		li $a2, 13
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		j player1shoot
	warnDuplicateAttack1:
		li $v0, 4
		la $a0, warnDupAttack
		syscall
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, dupshort
    		li $a2, 10
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		j player1shoot
	warnAttack2:
		li $v0, 4
		la $a0, warnWrongAttack
		syscall 
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, formatshort
    		li $a2, 13
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		j player2shoot
	warnDuplicateAttack2:
		li $v0, 4
		la $a0, warnDupAttack
		syscall
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, dupshort
    		li $a2, 10
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		j player2shoot
	entership: #entership then checkship
		beq $s3, 3, remindShip4
		beq $s3, 2, remindShip3
		beq $s3, 1, remindShip2
		remindShip4:
			li $v0, 4
			la $a0, remind4
			syscall
			j doneRemind
		remindShip3:
			li $v0, 4
			la $a0, remind3
			syscall
			j doneRemind
		remindShip2:
			li $v0, 4
			la $a0, remind2
			syscall
		j doneRemind
		doneRemind:
		# write to file, announce that player 1 enter
		li $v0, 4
		la $a0, enterShip
		syscall
		
		li $v0, 8
		la $a0, input_string
		li $a1, 9
		syscall
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, input_string
    		li $a2, 7
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		li $v0, 4
		la $a0, endl
		syscall
		
		la $a3, m1
		j checkship
	enterdone:
		jr $ra
	checkship: #checkship then if not good then warn ship
		la $a0, input_string
		lb $t0, ($a0)
		subi $t0, $t0, 48
		blt $t0, 0, warnShip
		bgt $t0, 6, warnShip
		addi $a0, $a0, 1
		lb $t1, ($a0)
		bne $t1, 32, warnShip
		addi $a0, $a0, 1
		lb $t1, ($a0)
		subi $t1, $t1, 48
		blt $t1, 0, warnShip
		bgt $t1, 6, warnShip
		addi $a0, $a0, 1
		lb $t2, ($a0)
		bne $t2, 32, warnShip
		addi $a0, $a0, 1
		lb $t2, ($a0)
		subi $t2, $t2, 48
		blt $t2, 0, warnShip
		bgt $t2, 6, warnShip
		addi $a0, $a0, 1
		lb $t3, ($a0)
		bne $t3, 32, warnShip
		addi $a0, $a0, 1
		lb $t3, ($a0)
		subi $t3, $t3, 48
		blt $t3, 0, warnShip
		bgt $t3, 6, warnShip
		addi $a0, $a0, 1
		beq $t0, $t2, row
		beq $t1, $t3, col
		row: # the start of row is at $t1, end at $t3
			bgt $t1, $t3, setCol
			j nosetCol
			setCol: # swap t1 và t3
				sub $t7, $t1, $t3
				bne $t7, $s3, warnNotTrueSize
				sub $t1, $t1, $s3
				add $t3, $t3, $s3
			nosetCol:
				sub $t7, $t3, $t1
				bne $t7, $s3, warnNotTrueSize
			# check duplicate, if not then continue to change the map
			mul $t4, $t0, 7 #get the row
			add $t4, $t4, $t1 # get the col
			mul $t4, $t4, 4
			add $t4, $t4, $s1
			# Check if a ship here
			li $t0, 0
			addi $t1, $s3, 1
			loopCheckRow:
				beq $t0, $t1, endLoopCheckRow
				lb $a0, ($t4)
				bne $a0, 0, warnDuplicate
				addi $t4, $t4, 4
				addi $t0, $t0, 1
				j loopCheckRow
			endLoopCheckRow:
			# Change the place to ship 4
			li $t0, 0
			addi $t1, $s3, 1
			subi $t4, $t4, 4
			loopChangeRow:
				beq $t0, $t1, endLoopChangeRow
				li $t5, 1
				sw $t5, ($t4)
				subi $t4, $t4, 4
				addi $t0, $t0, 1
				j loopChangeRow
			endLoopChangeRow:
			j next
		col:
			bgt $t0, $t2, setRow
			j nosetRow
			setRow: # swap t0 và t2
				sub $t7, $t0, $t2
				bne $t7, $s3, warnNotTrueSize
				sub $t0, $t0, $s3
				add $t2, $t2, $s3
			nosetRow:
				sub $t7, $t2, $t0
				bne $t7, $s3, warnNotTrueSize
			# check duplicate, if not then continue to change the map
			mul $t4, $t0, 7 #get the row
			add $t4, $t4, $t1 # get the col
			mul $t4, $t4, 4
			add $t4, $t4, $s1
			# Check if a ship here
			li $t0, 0
			addi $t1, $s3, 1
			loopCheckCol:
				beq $t0, $t1, endLoopCheckCol
				lb $a0, ($t4)
				bne $a0, 0, warnDuplicate
				addi $t4, $t4, 28
				addi $t0, $t0, 1
				j loopCheckCol
			endLoopCheckCol:
			# Change the place to ship 4
			li $t0, 0
			addi $t1, $s3, 1
			subi $t4, $t4, 28
			loopChangeCol:
				beq $t0, $t1, endLoopChangeCol
				li $t5, 1
				sw $t5, ($t4)
				subi $t4, $t4, 28
				addi $t0, $t0, 1
				j loopChangeCol
			endLoopChangeCol:
			j next
		next:
			j enterdone

	warnShip: 
		li $v0, 4
		la $a0, warnS
		syscall
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, formatshort
    		li $a2, 13
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		j entership
	warnDuplicate:
		li $v0, 4
		la $a0, warnDup
		syscall
		
		li $v0, 15
   		move $a0, $s6
    		la $a1, dupshort
    		li $a2, 10
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		j entership
	warnNotTrueSize:
		beq $s3, 3, w4
		beq $s3, 2, w3
		beq $s3, 1, w2
		w4:
			li $v0, 4
			la $a0, warnSize4
			syscall
			j endwarn
		w3:
			li $v0, 4
			la $a0, warnSize3
			syscall
			j endwarn
		w2:
			li $v0, 4
			la $a0, warnSize2
			syscall
		endwarn:
		li $v0, 15
   		move $a0, $s6
    		la $a1, sizeshort
    		li $a2, 11
    		syscall
    		
    		li $v0, 15
   		move $a0, $s6
    		la $a1, endl
    		li $a2, 1
    		syscall
    		
		j entership
	exit:
		li $v0, 16
   		move $a0, $s6
    		syscall
		
		li $v0, 10
		syscall
	UI1:
		li $v0, 4
		la $a0, welcome
		syscall
		li $v0, 4
		la $a0, blankline
		syscall
		li $v0, 4
		la $a0, p1
		syscall
		jr $ra
	printMapP1:
		li $v0, 4
		la $a0, p1
		syscall
		li $v0, 4
		la $a0, number
		syscall
		la $a1, m1
		li $t0, 0
		loopRow1:
			beq $t0, 7, endRow1
			li $t1, 0
			li $v0, 1
			addi $a0, $t0, 0
			syscall
			li $v0, 4
			la $a0, space
			syscall
			loopCol1:
				beq $t1, 7, endCol1
				lw $t2, ($a1)
				li $v0, 1
				move $a0, $t2
				syscall
				li $v0, 4
				la $a0, space
				syscall
				addi $t1, $t1, 1
				addi $a1, $a1, 4
				j loopCol1
			endCol1:
				li $v0, 4
				la $a0, endl
				syscall
				addi $t0, $t0, 1
				j loopRow1
		endRow1:
		jr $ra
	printMapP2:
		li $v0, 4
		la $a0, p2
		syscall
		li $v0, 4
		la $a0, number
		syscall
		la $a1, m2
		li $t0, 0
		loopRow2:
			beq $t0, 7, endRow2
			li $t1, 0
			li $v0, 1
			addi $a0, $t0, 0
			syscall
			li $v0, 4
			la $a0, space
			syscall
			loopCol2:
				beq $t1, 7, endCol2
				lw $t2, ($a1)
				li $v0, 1
				move $a0, $t2
				syscall
				li $v0, 4
				la $a0, space
				syscall
				addi $t1, $t1, 1
				addi $a1, $a1, 4
				j loopCol2
			endCol2:
				li $v0, 4
				la $a0, endl
				syscall
				addi $t0, $t0, 1
				j loopRow2
		endRow2:
		jr $ra
	printMapAttackP1:
		li $v0, 4
		la $a0, pa
		syscall
		li $v0, 4
		la $a0, number
		syscall
		la $a1, ma1
		li $t0, 0
		loopRowA1:
			beq $t0, 7, endRowA1
			li $t1, 0
			li $v0, 1
			addi $a0, $t0, 0
			syscall
			li $v0, 4
			la $a0, space
			syscall
			loopColA1:
				beq $t1, 7, endColA1
				lw $t2, ($a1)
				li $v0, 1
				move $a0, $t2
				syscall
				li $v0, 4
				la $a0, space
				syscall
				addi $t1, $t1, 1
				addi $a1, $a1, 4
				j loopColA1
			endColA1:
				li $v0, 4
				la $a0, endl
				syscall
				addi $t0, $t0, 1
				j loopRowA1
		endRowA1:
		jr $ra
	printMapAttackP2:
		li $v0, 4
		la $a0, pa
		syscall
		li $v0, 4
		la $a0, number
		syscall
		la $a1, ma2
		li $t0, 0
		loopRowA2:
			beq $t0, 7, endRowA2
			li $t1, 0
			li $v0, 1
			addi $a0, $t0, 0
			syscall
			li $v0, 4
			la $a0, space
			syscall
			loopColA2:
				beq $t1, 7, endColA2
				lw $t2, ($a1)
				li $v0, 1
				move $a0, $t2
				syscall
				li $v0, 4
				la $a0, space
				syscall
				addi $t1, $t1, 1
				addi $a1, $a1, 4
				j loopColA2
			endColA2:
				li $v0, 4
				la $a0, endl
				syscall
				addi $t0, $t0, 1
				j loopRowA2
		endRowA2:
		jr $ra
	
	fakeClearPage:
		li $t0, 0
		loopFake:
			beq $t0, 100, endLoopFake
			li $v0, 4
			la $a0, endl
			syscall
			addi $t0, $t0, 1
			j loopFake
		endLoopFake:
			jr $ra
	
	
	
	
		
		
		
		
		
	
