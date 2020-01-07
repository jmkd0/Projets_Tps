#lang racket/base
(require parser-tools/lex
        (prefix-in : parser-tools/lex-sre)
        "helper.rkt")

(provide get-token keywords-and-operators values-and-names
            (struct-out position))
(define-tokens values-and-names
    (Lident Lnum Lbool))
(define-empty-tokens keywords-and-operators
    (Lend Ladd Lsub Lmul Ldiv Lopar Lcpar Loacc Lcacc 
    Lsc Lco Lassign Lneq Lgt Llt Lgte Llte Land Lxor Lnot Lor Leq Ldef Lreturn Lif Lelse))
(define-lex-abbrev identifier
  (:: alphabetic (:* (:or alphabetic numeric "-" "_"))))


(define get-token
    (lexer-src-pos
    [(eof)      (token-Lend)]
    [whitespace  (return-without-pos (get-token input-port))]
    ["+"        (token-Ladd)]
    ["-"        (token-Lsub)]
    ["*"        (token-Lmul)]
    ["/"        (token-Ldiv)]
    ["("        (token-Lopar)]
    [")"        (token-Lcpar)]
    ["{"        (token-Loacc)]
    ["}"        (token-Lcacc)]
    [";"        (token-Lsc)]
    [","        (token-Lco)]
    ["="        (token-Lassign)]
    ["!="       (token-Lneq)]
    [">"        (token-Lgt)]
    ["<"        (token-Llt)]
    ["<="       (token-Llte)]
    [">="       (token-Lgte)]
    ["true"     (token-Lbool #t)]
    ["false"    (token-Lbool #f)]
    ["&&"       (token-Land)]
    ["^"        (token-Lxor)]
    ["!"        (token-Lnot)]
    ["||"       (token-Lor)]
    ["=="       (token-Leq)]
    ["if"       (token-Lif)]
    ["else"     (token-Lelse)]
    ["def"      (token-Ldef)]
    ["return"   (token-Lreturn)]
    [identifier (token-Lident (string->symbol lexeme))]
    [(:+ numeric)(token-Lnum (string->number lexeme))]
    [any-char   (error (format "unrecognized character '~a'" lexeme) start-pos)]
    )
    )