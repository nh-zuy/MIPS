.data
NhapVaoX: .asciiz "Input x: "
NhapVaoY: .asciiz "Input y: "
KetQua: .asciiz "\nResult:\n"

Cong: .asciiz "x + y = "
Tru: .asciiz "\nx - y = "
Nhan: .asciiz "\nx * y = "
Chia: .asciiz "\nx / y = "
AND: .asciiz "\nx and y = "
DichTrai: .asciiz "\nx << 2 = "
DichPhai: .asciiz "\ny >> 2 = "

.text
main:

# Nhap vao x, y
li $v0, 4
la $a0, NhapVaoX
syscall
li $v0, 5
syscall
addi $s0, $v0, 0

li $v0, 4
la $a0, NhapVaoY
syscall
li $v0, 5
syscall
addi $s1, $v0, 0

# Ket qua
li $v0, 4
la $a0, KetQua
syscall

# x + y
add $t0, $s0, $s1
li $v0, 4
la $a0, Cong
syscall
li $v0, 1
move $a0, $t0
syscall


# x - y
sub $t1, $s0, $s1
li $v0, 4
la $a0, Tru
syscall
li $v0, 1
move $a0, $t1
syscall

# x * y
multu $s0, $s1
mflo $t2
li $v0, 4
la $a0, Nhan
syscall
li $v0, 1
move $a0, $t2
syscall

# x / y
div $s0, $s1
mflo $t3
li $v0, 4
la $a0, Chia
syscall
li $v0, 1
move $a0, $t3
syscall

# x and y
and $t4, $s0, $s1
li $v0, 4
la $a0, AND
syscall
li $v0, 1
move $a0, $t4
syscall

# x << 2
sll $t5, $s0, 2
li $v0, 4
la $a0, DichTrai
syscall
li $v0, 1
move $a0, $t5
syscall

# y >> 2
srl $t6, $s1, 2
li $v0, 4
la $a0, DichPhai
syscall
li $v0, 1
move $a0, $t6
syscall

# Thoat
li $v0, 10
syscall
