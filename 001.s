.section .data
sum:     .word 0
format:  .asciz "%d\n" // Format string for printf

.section	 .text
.global _start
.extern printf

_start:
// Calculate number of multiples
    ldr x0, =999 // Upper limit - 1 (since we want below 1000)
    mov x1, #3 // Divisor for 3
    bl calc_multiples // x0 = sum of multiples of 3
    mov x3, x0 // Store result in x3

    ldr x0, =999
    mov x1, #5 // Divisor for 5
    bl calc_multiples // x0 = sum of multiples of 5
    add x3, x3, x0 // Add result to x3

    ldr x0, =999
    mov x1, #15 // Divisor for 15
    bl calc_multiples // x0 = sum of multiples of 15
    sub x3, x3, x0 // Subtract result from x3

// Load the address of 'sum' into x9
    adrp x9, sum
    add x9, x9, :lo12:sum

// Store result
    str x3, [x9] // Store the sum in memory

// Prepare arguments for printf
    ldr w1, =sum // Load the sum into w1 (first argument to print)
    ldr x0, =format  // Load address of format string into x0

// Call printf
    bl printf

// Exit code (for Linux)
    mov x8, #93 // syscall number for exit in Linux AArch64
    mov x0, #0 // Status code
    svc 0 // Make syscall

calc_multiples:
    // x0 = upper limit, x1 = divisor
    udiv x2, x0, x1 // x2 = upper limit / divisor
    mul x0, x2 , x1 // x0 = x2 * divisor
    add x2, x2, #1 // x2 = x2 + 1
    mul x0, x0, x2 // x0 = x0 * x2
    lsr x0, x0, #1 // x0 = x0 / 2 (sum of multiples)
    ret

