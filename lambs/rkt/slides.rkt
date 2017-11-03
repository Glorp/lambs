#lang at-exp racket
(provide (struct-out static-image)
         slides)

(struct static-image (path) #:transparent)

(define halp (list
              "C-d: ≜"
              "C-l: λ"
              ""
              "C-e: add definition or do one step of evaluation"
              ""
              "like, cursor somewhere on next line and do C-e:"
              "I ≜ λx.x"
              ""
              "C-S-e: evaluate until normal form, or like at least 1000 steps"
              "C-r: replace names of things you have defined with their definitions"
              ""
              "like, cursor on next line, C-r, then C-e or C-S-e:"
              "I I I I foo"
              ""
              ""
              "Renaming variables to avoid capture counts as one step:"
              "like,"
              "λx.(λy.λx.y) x"))

(define rules (list
               "Syntax:"
               "Exp u ::= x         variable"
               "          λx.u      abstraction"
               "          u1 u2     application"
               ""
               "Computation rule:"
               "(λx.u1) u2"
               "[u2/x]u1"
               ""
               "e.g."
               "(λa.λb.λc.a c c) foo bar quux"))

(define little (list
                (static-image "imgs/ls.png")
                "The Little Schemer uses"
                "    * numbers, add1, sub1, zero?"
                "    * booleans and if or cond or something"
                "    * elephants"))

(define ruleses (list
                 "Syntax:"
                 "Exp u ::= x                         variable"
                 "          λx.u                      abstraction"
                 "          u1 u2                     application"
                 "          true                      boolean"
                 "          false                     boolean"
                 "          if                        stuff"
                 "          [0-9]+                    number"
                 "          add1                      stuff"
                 "          sub1                      stuff"
                 "          zero?                     stuff"
                 ""
                 "          maybe other stuff         also stuff"
                 "e.g."
                 ""
                 "(λa.λb.λc.a c c) foo bar quux"
                 ""
                 "add1 3"
                 ""
                 "zero? 0"
                 ""
                 "if true foo bar"
                 ""
                 "(λx.(if (zero? (sub1 x)) add1 sub1)) 1 5"))


(define plus (list (static-image "imgs/plus.png")
                   "(define plus"
                   "  (lambda (n m)"
                   "    (cond"
                   "      ((zero? m) n)"
                   "      (else (add1 (plus n (sub1 m)))))))"))

(define plusses (list
                 "                                                    ..."
                 "                              \\__________________________________________/"
                 "                                                     |"
                 "                                                     v"
                 "                        λn.λm.if (zero? m) n (add1 (___ n (sub1 m)))"
                 "                        \\__________________________________________/"
                 "                                               |"
                 "                                               v"
                 "                  λn.λm.if (zero? m) n (add1 (___ n (sub1 m)))"
                 "                  \\__________________________________________/"
                 "                                         |"
                 "                                         v"
                 "            λn.λm.if (zero? m) n (add1 (___ n (sub1 m)))"
                 "            \\__________________________________________/"
                 "                                   |"
                 "                                   v"
                 "      λn.λm.if (zero? m) n (add1 (___ n (sub1 m)))"
                 "      \\__________________________________________/"
                 "                             |"
                 "                             v"
                 "λn.λm.if (zero? m) n (add1 (___ n (sub1 m)))"))

(define incons (list
                "Church made lambda calculus, for to use as logic and things"
                "Kleene and Rosser proved that it was inconsistent"
                ""
                "\"in the sense that every forumula in their notation is"
                "provable, irrespective of its meaning under the"
                "interpretation intended for the symbols\""
                ""
                "which probably involves like terms that have no \"solution\""
                "like if you try to reduce them you can go on like forever"
                ""
                "I guess we could like read what they wrote"))

(define incoons? (list "um," (static-image "imgs/incons.png") "hmmm, um?"))

(define okay! (list
               "okay."
               ""
               "anyway, people added like types to avoid stuff like that. so"))

(define small-expressions (list
                           "smallest, lambda and variable ref:"
                           "λx.x"
                           ""
                           "two lambdas and variable ref:"
                           "λa.λb.a"
                           "λa.λb.b"
                           ""
                           "one lambda and function application (and variable refs):"
                           "λx.x x"))

(define t-error (list
                 "SML:"
                 "Error: operator is not a function [circularity]"
                 "- fn x => x x;;"
                 "stdIn:1.10-1.13 Error: operator is not a function [circularity]"
                 "  operator: 'Z"
                 "  in expression:"
                 "    x x"
                 ""
                 "Haskell:"
                 "Prelude> \\x -> x x"
                 ""
                 "<interactive>:2:9:"
                 "    Occurs check: cannot construct the infinite type: t1 = t1 -> t0"
                 "    In the first argument of `x', namely `x'"
                 "    In the expression: x x"
                 "    In the expression: \\ x -> x x"
                 ""
                 "F#:"
                 "> fun x -> x x;;"
                 ""
                 "  fun x -> x x;;"
                 "  -----------^"
                 ""
                 "stdin(1,12): error FS0001: Type mismatch. Expecting a"
                 "    'a"
                 "but given a"
                 "    'a -> 'b"
                 "The resulting type would be infinite when unifying ''a' and ''a -> 'b'"
                 ""
                 "Coq:"
                 (static-image "imgs/c.png")))

(define fizzbuzz (list
                  ":install real-world"
                  ""
                  "and a b ≜ if a b false"
                  ""
                  "Y ≜ λf.(λx.f (x x)) (λx.f (x x))"
                  ""
                  "div3 ≜ λn.(= 0 (% n 3))"
                  ""
                  "div5 ≜ λn.(= 0 (% n 5))"
                  ""
                  "div35 ≜ λn.and (div3 n) (div5 n)"
                  ""
                  "fbhalp ≜ λn. if (div35 n) fizzbuzz (if (div3 n) fizz (if (div5 n) buzz n))"
                  ""
                  "fb' ≜ λself.λn.if (= n 101) true (and (print (fbhalp n)) (self (+ 1 n)))"
                  ""
                  "fb ≜ Y fb' 1"))

(define slides
  `#hash((hello . ,(list "Hello?"))
         (halp . ,halp)
         (rules . ,rules)
         (little . ,little)
         (ruleses . ,ruleses)
         (plusses . ,plusses)
         (plus . ,plus)
         (incons . ,incons)
         (incoons? . ,incoons?)
         (okay! . ,okay!)
         (small-expressions . ,small-expressions)
         (t-error . ,t-error)
         (fizzbuzz . ,fizzbuzz)))


