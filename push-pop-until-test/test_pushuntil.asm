; Test PUSHUNTIL instruction
; This test demonstrates pushing registers r0 through r3 onto the stack
; Expected: r0, r1, r2, r3 are pushed to stack
; Then we verify they can be popped back

jmp test_start

test_start:
; Initialize registers with test values
    loadn r0, #10       ; r0 = 10
    loadn r1, #20       ; r1 = 20
    loadn r2, #30       ; r2 = 30
    loadn r3, #40       ; r3 = 40
    loadn r4, #50       ; r4 = 50 (will not be pushed)

; Push registers r0 to r3 (until r4)
    pushuntil r0, r4

; Modify registers to verify pop works
    loadn r0, #0
    loadn r1, #0
    loadn r2, #0
    loadn r3, #0

; Pop registers back r0 to r3
    popuntil r0, r4

; Verify values (if pop worked, registers should have original values)
; r0 = 10, r1 = 20, r2 = 30, r3 = 40

    halt
