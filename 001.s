.section .data
sum:     .word 0

.section	 .text
.global _start

_start:
    // Calculate number of multiples
    mov x0, #999 // Upper limit - 1 (since we want below 1000)
    mov x1, #3 // Divisor for 3
    bl calc_multiples // x0 = sum of multiples of 3
    mov x3, x0 // Store result in x3

    mov x0, #999
    mov x1, #5 // Divisor for 5
    bl calc_multiples // x0 = sum of multiples of 5
    add x3, x3, x0 // Add result to x3

calc_multiples:
    // x0 = upper limit, x1 = divisor
    udiv x2, x0, x1 // x2 = upper limit / divisor
    mul x0, x2 , x1 // x0 = x2 * divisor
    add x2, x2, #1 // x2 = x2 + 1
    mul x0, x0, x2 // x0 = x0 * x2
    lsr x0, x0, #1 // x0 = x0 / 2 (sum of multiples)
    ret

