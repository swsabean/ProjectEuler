.section .data
sum:     .word 0

.section		.text
.global _start

_start:
    // Calculate number of multiples
    mov x0, #999 // Upper limit - 1 (since we want below 1000)
    mov x1, #3 // Divisor for 3

calc_multiples:
    // x0 = upper limit, x1 = divisor
    udiv x0, x0, x1
