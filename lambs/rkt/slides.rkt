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
              "λx.(λy.λx.y) x"
              ""
              "..."
              ""
              "<C-return>: special command thing (lines that begin with :)"
              ""
              "some examples..."
              ":draw (λf.λx.f x) foo bar"
              ":scale"
              ":scale 2"
              ":draw (λx.x) foo"
              ":border-length"
              ":border-length 5"
              ":slide hello"))


(define hello (list "Hello?"
                    ""
                    (static-image "imgs/pudu.png")
                    ""
                    "(some notes to a self:"
                    "maybe have a DrRacket open?"
                    "SML as well?"
                    "border-length, textsize stuffs?"
                    "did I switch out \"temp\" with sth?)"))


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

(define churchnums (list "nums like:"
                         "zero ≜ λf.λx.x"
                         "one ≜ λf.λx.f x"
                         "two ≜ λf.λx.f (f x)"
                         ""
                         "some trickery:"
                         "add1 ≜ λn.λf.λx.f (n f x)"
                         ""
                         "add1 (add1 (add1 two))"
                         ""
                         "but then the number kind of is its own eliminator or recursor or sth"
                         ""
                         "e.g. adding a and b together"
                         "base case, a is zero, answer is b"
                         "recursive case a is one more than sth, add one to result of sth plus b"
                         ""
                         "                   base"
                         "         recursive  |"
                         "                |   |"
                         "                V   V"
                         "plus ≜ λa.λb.a add1 b"
                         ""
                         "plus two two"))

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

(define summary? (list "1. type checkers tend not to like λx.x x"
                       "2. (λx.x x) (λx.x x) goes on and on"
                       "3. (more than) as many foos as we want"
                       "(λx.x x) (λx.foo (x x))"
                       "4. abstraction"
                       "λf.(λx.x x) (λx.f (x x))"
                       "5. eval into Y"))

(define some-functions? (list
                         "multiplication?"
                         ""
                         "triangles?"
                         "                                            *"
                         "                                *          * *"
                         "                      *        * *        * * *"
                         "              *      * *      * * *      * * * *"
                         "        *    * *    * * *    * * * *    * * * * *"
                         "T(0)  T(1)   T(2)    T(3)     T(4)         T(5)"
                         ""
                         ""
                         "possibly fib?"))

(define real-world (list
                    ":install real-world"
                    ""
                    "the Real-World consists of horrible and convenient things..."
                    ""
                    "+ 1 (+ 3 4)"
                    ""
                    "= (+ 1 (+ 3 4)) (+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (+ 1 1)))))))"
                    ""
                    "and (= (+ 1 (+ 3 4)) 8) (= (% 6 3) 0)"
                    ""
                    "print 5"
                    ""
                    "(λx.+ x 3) 5"
                    ""
                    "print ((λx.+ x 3) 5)"
                    ""
                    "and (print ((λx.+ x 3) 5)) (= (+ 3 2) 5)"
                    ""
                    ""
                    "so:"
                    "we're going to need some helper functions"
                    ""
                    ""
                    "and a recurring thing"
                    ""
                    ""))

(define links? (list "code: https://github.com/Glorp/lambs"
                     "some lambdas"
                     "   http://llama-the-ultimate.org/lambdas.html"
                     "or http://llama-the-ultimate.org/lists/lambs.html or sth"))
                     

(define Y (list "Y ≜ λf.(λx.f (x x)) (λx.f (x x))"))

(define cheat (list "Y ≜ λf.(λx.f (x x)) (λx.f (x x))"
                    "plus ≜ Y (λself.λn.λm.if (zero? m) n (add1 (self n (sub1 m))))"
                    "mul ≜ Y (λself.λn.λm.if (zero? m) 0 (+ n (self n (sub1 m))))"
                    "T ≜ Y (λself.λn.if (zero? n) 0 (+ n (self (sub1 n))))"
                    "fib ≜ Y (λself.λn.if (or (zero? n) (zero? (sub1 n))) n (+ (self (- n 1)) (self (- n 2))))"))

(define fizzbuzz (list
                  ":install real-world"
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
  `#hash((hello . ,hello)
         (halp . ,halp)
         (rules . ,rules)
         (churchnums . ,churchnums)
         (little . ,little)
         (ruleses . ,ruleses)
         (plusses . ,plusses)
         (plus . ,plus)
         (incons . ,incons)
         (incoons? . ,incoons?)
         (okay! . ,okay!)
         (small-expressions . ,small-expressions)
         (t-error . ,t-error)
         (summary? . ,summary?)
         (fizzbuzz . ,fizzbuzz)
         (some-functions? . ,some-functions?)
         (real-world . ,real-world)
         (Y . ,Y)
         (cheat . ,cheat)))


