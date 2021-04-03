.data
NhapVao: .asciiz "[?] Nhap vao mot so nguyen (> 0): "
KetQua: .asciiz "[*] Giai thua la: "

.text
main:
li $v0, 4
la $a0, NhapVao     # Thong bao nhap vao so nguyen khong am
syscall
li $v0, 5           # Nhap so nguyen
syscall
    
move $a0, $v0       # Nhap doi so v0
jal Stack           # Goi stack de tinh toan
move $t0, $v0       # Sau khi tinh toan, luu ket qua vao t0
    
li $v0, 4
la $a0, KetQua	    # Thong bao xuat ket qua
syscall
li $v0, 1           # In so nguyen
move $a0, $t0       # Xuat ket qua
syscall              
    
li $v0, 10          # Thoat
syscall

Stack:
addi $sp, $sp, -8
    # save $s0 and $ra
sw $s0, 4($sp)
sw $ra, 0($sp)
bne $a0, 0, DeQui
addi $v0, $zero, 1    # return 1
j TraVe

DeQui:
    # backup $a0
move $s0, $a0
addi $a0, $a0, -1 # x -= 1
jal Stack
    # when we get here, we already have Fact(x-1) store in $v0
multu $s0, $v0 # return x*Fact(x-1)
mflo $v0

TraVe:
lw      $s0, 4($sp)
lw      $ra, 0($sp)
addi    $sp, $sp, 8
jr      $ra
