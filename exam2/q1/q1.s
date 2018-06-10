# COMP1521 Practice Prac Exam #1
# int everyKth(int *src, int n, int k, int*dest)

   .text
   .globl everyKth

# params: src=$a0, n=$a1, k=$a2, dest=$a3
everyKth:
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
    # src[i] = s0, dest[j] = s1, i = t0, j = t1
    li $t1, 0
    
init_for:
    li $t0, 0

cond_for:
    bge $t0, $a1, end_for # end loop if i >= n
    #if (i % k != 0)
    rem $t2, $t0, $a2
    bnez $t2, step_for
    # dest[j] = src[i]
    sll $t3, $t0, 2 # t3=4*i
    sll $t4, $t1, 2 # t4=4*j
    add $s0, $a0, $t3
    add $s1, $a3, $t4
    lw $s0, ($s0)
    sw $s0, ($s1)
    addi $t1, $t1, 1 # j++
step_for:
    addi $t0, $t0, 1
    j cond_for
end_for:

    move $v0, $t1
   # add code for your everyKth function here

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

