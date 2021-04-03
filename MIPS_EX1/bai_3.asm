.data
NhapVao: .asciiz "[?] Nhap vao mot chuoi: "
KetQua: .asciiz "[*] Chuoi dao nguoc: "
Vao:	.space	256
Ra:	.space	256

.text
main:
li $v0, 4
la $a0, NhapVao     # Thong bao nhap vao so nguyen khong am
syscall
    
li $v0, 8			# Ask the user for the string they want to reverse
la $a0, Vao		# We'll store it in 'input'
li $a1, 256		# Only 256 chars/bytes allowed
syscall
	
jal strlen			# JAL to strlen function, saves return address to $ra
	
# Dao nguoc chuoi	
add $t1, $zero, $v0		# Copy some of our parameters for our reverse function
add $t2, $zero, $a0		# We need to save our input string to $t2, it gets
add $a0, $zero, $v0		# butchered by the syscall.
li $t0, 0			# Set t0 to zero to be sure
li $t3, 0			# and the same for t3
	
DaoChuoi:
add $t3, $t2, $t0		# $t2 is the base address for our 'input' array, add loop index
lb $t4, 0($t3)		# load a byte at a time according to counter
beq $t4, 0, TraVe		# We found the null-byte
sb $t4, Ra($t1)		# Overwrite this byte address in memory	
subi $t1, $t1, 1		# Subtract our overall string length by 1 (j--)
addi $t0, $t0, 1		# Advance our counter (i++)
j DaoChuoi		# Loop until we reach our condition
	
TraVe:
li $v0, 4
la $a0, KetQua     # Thong bao nhap vao so nguyen khong am
syscall
li $v0, 4			# Print
la $a0, Ra		# the string!
syscall
		
li $v0, 10			# exit()
syscall
	

# strlen:
# a0 is our input string
# v0 returns the length
# -- This function loops over the character array until it encounters
# the null byte, interestingly, the 0x0a character is stored by default
# for input strings requested through the syscall. So we just subtract one
# from the end result.

strlen:
li $t0, 0
li $t2, 0
	
strlen_loop:
add $t2, $a0, $t0
lb $t1, 0($t2)
beq $t1, 0, strlen_exit
addi $t0, $t0, 1
j strlen_loop
		
strlen_exit:
subi $t0, $t0, 1
add $v0, $zero, $t0
add $t0, $zero, $zero
jr $ra