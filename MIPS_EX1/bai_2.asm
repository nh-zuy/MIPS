.data
NhapVao: .asciiz "[?] Nhap vao mot chuoi: "
ChinhXac: .asciiz "\n[*] Day la ki tu!"
NhapLai: .asciiz "\n[!] Day khong phai la ki tu. Vui long nhap lai!"

.text
main:
li $v0, 4
la $a0, NhapVao
syscall

li $v0, 12
syscall

move $s0, $v0

# Kiem tra 65
slti $t0, $s0, 65
beq $t0, 1, Sai

# Kiem tra 90
slti $t1, $s0, 91
beq $t1, 1, Dung

# Kiem tra 97
slti $t3, $s0, 97
beq $t3, 1, Sai

# Kiem tra 121
slti $t4, $s0, 123
beq $t4, 0, Sai

Dung:
li $v0, 4
la $a0, ChinhXac
syscall
j Thoat

Sai:
li $v0, 4
la $a0, NhapLai
syscall

Thoat:
li $v0, 10
syscall




