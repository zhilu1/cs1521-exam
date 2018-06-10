# COMP1521 Practice Prac Exam #1
# int lowerfy(char *src, char *dest)

   .text
   .globl lowerfy

# params: src=$a0, dest=$a1
lowerfy:
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
    # i = t0, n = t1, src[i] = s0, dest[i] = s1, ch = t2
   # add code for your lowerfy function here

    li $t1, 0

init_for:
    li $t0, 0
cond_for:
    # src[i] == '\0' == 0
    add $s0, $a0, $t0
    lb $s0, ($s0)
    beqz $s0, end_for
    #ch = src[i]
    move $t2, $s0
    
    # if ch < 'A'
    li $t3, 'A'
    blt $t2, $t3, end_if
    # if ch > 'Z'
    li $t3, 'Z'
    bgt $t2, $t3, end_if
    # ch = ch - 'A' + 'a'
    subu $t2, $t2, 'A'
    addu $t2, $t2, 'a'
    addi $t1, $t1, 1
end_if:
    #   dest[i] = ch
    add $s1, $a1, $t0
    sb $t2, ($s1)    

step_for:
    addi $t0, $t0, 1
    j cond_for
end_for:
    #dest[i] = 0
    add $s1, $a1, $t0
    sb $0, ($s1)
    
    move $v0, $t1

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

