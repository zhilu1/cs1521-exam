# COMP1521 17s2 Final Exam
# void colSum(m, N, a)

   .text
   .globl colSum

# params: m=$a0, N=$a1, a=$a2
colSum:
# prologue
   addi $sp, $sp, -4
   sw   $fp, ($sp)
   la   $fp, ($sp)
   addi $sp, $sp, -4
   sw   $ra, ($sp)
   addi $sp, $sp, -4
   sw   $s0, ($sp)
   addi $sp, $sp, -4
   sw   $s1, ($sp)
   addi $sp, $sp, -4
   sw   $s2, ($sp)
   addi $sp, $sp, -4
   sw   $s3, ($sp)
   addi $sp, $sp, -4
   sw   $s4, ($sp)
   addi $sp, $sp, -4
   sw   $s5, ($sp)
   # if you need to save more than six $s? registers
   # add extra code here to save them on the stack

# suggestion for local variables (based on C code):
# m=#s0, N=$s1, a=$s2, row=$s3, col=$s4, sum=$s5

    move $s0, $a0
    move $s1, $a1
    move $s2, $a2

init_c_for:
    li $s4,0
cond_c_for:
    #if col >= N:
    bge $s4, $s1, end_c_for
    li $s5, 0
init_r_for:
    li $s3,0
cond_r_for:
    #if row >= N:
    bge $s3, $s1, end_r_for
    # &m[row][col] = m + 4*row*N + 4*col
    sll $t0, $s3, 2
    mul $t0, $t0, $s1
    sll $t1, $s4, 2
    add $t2, $t0, $t1
    add $t2, $t2, $s0
    lw $t2, ($t2)
    # sum = sum +  m[row][col]
    add $s5, $s5, $t2
step_r_for:
    addi $s3, $s3, 1
    j cond_r_for
end_r_for:
    # &a[col] = a + 4*col
    sll $t1, $s4, 2
    add $t3, $s2, $t1
    sw $s5, ($t3)
step_c_for:
    addi $s4, $s4, 1
    j cond_c_for
end_c_for:
   # add code for your colSum function here

# epilogue
   # if you saved more than six $s? registers
   # add extra code here to restore them
   lw   $s5, ($sp)
   addi $sp, $sp, 4
   lw   $s4, ($sp)
   addi $sp, $sp, 4
   lw   $s3, ($sp)
   addi $sp, $sp, 4
   lw   $s2, ($sp)
   addi $sp, $sp, 4
   lw   $s1, ($sp)
   addi $sp, $sp, 4
   lw   $s0, ($sp)
   addi $sp, $sp, 4
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   j    $ra

