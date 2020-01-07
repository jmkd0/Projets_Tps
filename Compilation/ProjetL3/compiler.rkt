#lang racket/base

(require racket/match
         "baselib.rkt"
         "ast.rkt")

(provide compile)

(define (fail! msg)
  (eprintf "fatal error: ~a\n" msg)
  (exit 1))



(define (compile prog)
(Mips
  (eval-prog prog *baselib*)))

(define (eval-prog prog benv)
  
  (match prog
    [(list) (fail! "empty program")]
    [(list main)
       (append (list (Asciiz 'newline "\\n"))
           (map (lambda (s) (Asciiz (car s) (cdr s))) (cdr prog)))
           (append *baselib-implem*
           (list (Label 'main)
                 (Addi 'sp 'sp -4)
                 (Sw 'ra (Mem 'sp 0))))
     (let* ([inputs (map (lambda (i) (Bool 0)) (Block-inputs main))]
            [outputs (eval-block main inputs (make-immutable-hash) benv)]
            )
       (for-each (lambda (o v) (printf "~a: ~a\n" o (if v 1 0)))
                 (Block-outputs main) outputs))
                 ]
    [(cons b prog)
     (eval-prog prog (hash-set benv (Block-name b) b))]))

(define (eval-block b args venv benv)
  (let* ([inputs (env-add (Block-inputs b) args venv benv)]
         [venv (eval-instrs (Block-body b) inputs benv)])
    (map (lambda (o) (hash-ref venv o)) (Block-outputs b))))

(define (eval-instrs instrs venv benv)
;;(displayln instrs)
  (match instrs
    [(list) venv]
    [(cons a instrs)
     (let ([venv (env-add (Assign-outputs a) (list (Assign-expr a)) venv benv)])
       (eval-instrs instrs venv benv))]))

(define (eval-expr expr venv benv)
(displayln expr)
  (match expr
    [(Bool b) (list(Li 'v0 b))]
    [(Num n) (list (Li 'v0 n))]

    [(Var v) (list (hash-ref venv v))]
    [(Cond t y n)
    (let ([at (eval-expr t venv benv)]
           [ay (eval-expr y venv benv)]
           [an (eval-expr n venv benv)])
       (Cond at ay an)
             (list))]
    [(Call b a)
     (match (hash-ref benv b)
       [(? Block? b) (eval-block b a venv benv)]
       [(? pair? f) (f (eval-args a venv benv))]
       [else (fail! "not a callable")])]
    [else (fail! "not an expression")]))

(define (eval-args args venv benv)
  (apply append (map (lambda (a) (eval-expr a venv benv)) args)))

(define (env-add names exprs venv benv)
  (let ([val (eval-args exprs venv benv)])
    (foldl (lambda (n v e) (hash-set e n v)) venv names val)))