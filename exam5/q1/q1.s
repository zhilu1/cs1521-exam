# COMP1521 Practice Prac Exam #1
# (int dp, int n) dotProd(int *a1, int n1, int *a2, int n2)

   .text
   .globl dotProd

# params: a1=$a0, n1=$a1, a2=$a2, n2=$a3
dotProd:
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
   # if you need to save more $s? registers
   # add the code to save them here

# function body
# locals: ...

    li $t1, 0 # sum=0
    # if n1 < n2:
    bge $a1, $a3, else
    move $t2, $a1 # len = n1 
    j init_for
else:
    move $t2, $a3 # len = n2
init_for:
    li $t0, 0 # i = 0
cond_for:
    bge $t0, $t2, end_for
    # s0 = a1[i]*a2[i]
    sll $t3, $t0, 2 #t3=4*i    
    add $t4, $a0, $t3 # a1[i]
    add $t5, $a2, $t3 # a1[i]
    lw $t4, ($t4)
    lw $t5, ($t5)
    mul $s0, $t4, $t5   
    add $t1, $t1, $s0
step_for:
    addi  $t0, $t0, 1
    j cond_for
end_for:
    move $v0, $t1
    move $v1, $t2
   # add code for your dotProd function here

# epilogue
   # if you saved more than two $s? registers
   # add the code to restore them here
   lw   $s1, ($sp)
   addi $sp, $sp, 4
   lw   $s0, ($sp)
   addi $sp, $sp, 4
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   j    $ra

