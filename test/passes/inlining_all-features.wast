(module
  (export "ref_func_test" (func $ref_func_test))
  ;; $foo should not be removed after being inlined, because there is 'ref.func'
  ;; instruction that refers to it
  (func $foo)
  (func $ref_func_test (result funcref)
    (call $foo)
    (ref.func $foo)
  )
)
(module
 ;; a function reference in a global's init should be noticed, and prevent us
 ;; from removing an inlined function
 (global $global$0 (mut funcref) (ref.func $0))
 (func $0 (result i32)
  (i32.const 1337)
 )
 (func $1 (result i32)
  (call $0)
 )
)
(module
 ;; a function reference in the start should be noticed, and prevent us
 ;; from removing an inlined function
 (start $0)
 (func $0
  (nop)
 )
 (func $1
  (call $0)
 )
)
;; inline a return_call_ref
(module
 (type $none_=>_none (func))
 (export "func_36_invoker" (func $1))
 (func $0
  (return_call_ref
   (ref.null $none_=>_none)
  )
 )
 (func $1
  (call $0)
 )
)
