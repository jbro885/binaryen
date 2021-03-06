;; NOTE: Assertions have been generated by update_lit_checks.py and should not be edited.
;; RUN: wasm-opt %s --optimize-instructions --enable-threads -S -o - | filecheck %s

(module
 (import "env" "memory" (memory $0 (shared 256 256)))

 ;; CHECK:      (func $x
 ;; CHECK-NEXT:  (drop
 ;; CHECK-NEXT:   (i32.shr_s
 ;; CHECK-NEXT:    (i32.shl
 ;; CHECK-NEXT:     (i32.atomic.load8_u
 ;; CHECK-NEXT:      (i32.const 100)
 ;; CHECK-NEXT:     )
 ;; CHECK-NEXT:     (i32.const 24)
 ;; CHECK-NEXT:    )
 ;; CHECK-NEXT:    (i32.const 24)
 ;; CHECK-NEXT:   )
 ;; CHECK-NEXT:  )
 ;; CHECK-NEXT: )
 (func $x
  (drop
   (i32.shr_s
    (i32.shl
     (i32.atomic.load8_u ;; can't be signed
      (i32.const 100)
     )
     (i32.const 24)
    )
    (i32.const 24)
   )
  )
 )
)
