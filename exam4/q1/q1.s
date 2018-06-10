# COMP1521 Practice Prac Exam #1
# int novowels(char *src, char *dest)

   .text
   .globl novowels

# params: src=$a0, dest=$a1
novowels:
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
    #t6 = i, t1 =j, t2= n, s0 = src, s1 = dest
     # t3 = ch, $t4 = src[i], $t5 = dest[j]
    li $t1, 0 
    li $t2, 0 
    move $s0, $a0
    move $s1, $a1
init_for:
    li $t6, 0
cond_for:
    add $t4, $s0, $t6
    lb $t4, ($t4)
    beqz $t4, end_for
    
    move $t3, $t4

    #isvowl(ch)
    move $a0, $t3
    jal isvowel
    beqz $v0, else

    addi $t2, $t2, 1
    j end_if
else:
    add $t5, $s1, $t1
    sb $t3, ($t5)
    addi $t1, $t1, 1
end_if:    

step_for:
    addi $t6, $t6, 1
    j cond_for
end_for:
    add $t5, $s1, $t1
    sb $0, ($t5)
    move $v0, $t2

   # add code for your novwels function here

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
   jr    $ra

#####

# auxiliary function
# int isvowel(char ch)
isvowel:
# prologue
   addi $sp, $sp, -4
   sw   $fp, ($sp)
   la   $fp, ($sp)
   addi $sp, $sp, -4
   sw   $ra, ($sp)

# function body
   li   $t0, 'a'
   beq  $a0, $t0, match
   li   $t0, 'A'
   beq  $a0, $t0, match
   li   $t0, 'e'
   beq  $a0, $t0, match
   li   $t0, 'E'
   beq  $a0, $t0, match
   li   $t0, 'i'
   beq  $a0, $t0, match
   li   $t0, 'I'
   beq  $a0, $t0, match
   li   $t0, 'o'
   beq  $a0, $t0, match
   li   $t0, 'O'
   beq  $a0, $t0, match
   li   $t0, 'u'
   beq  $a0, $t0, match
   li   $t0, 'U'
   beq  $a0, $t0, match

   li   $v0, 0
   j    end_isvowel
match:
   li   $v0, 1
end_isvowel:

# epilogue
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   j    $ra
