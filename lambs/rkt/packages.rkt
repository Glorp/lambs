#lang racket
(require "structs.rkt"
         "eval/eval.rkt"
         "eval/subst.rkt"
         "unparse.rkt")

(provide (struct-out package)
         packages
         numify)

(struct num (n) #:transparent)
(struct bool (b) #:transparent)

(define (numify x)
  (define (sym->num s)
    (match (regexp-match #rx"^[0-9]+$" (symbol->string s))
      [(list x) (other (string->symbol x) (num (string->number x)))]
      [#f #f]))
  
  (match x
    [#f #f]
    [(lam p x)
     (define numip (numify x))
     (and (not (sym->num p))
          numip
          (lam p numip))]
    [(app f a)
     (define numif (numify f))
     (define numia (numify a))
     (and numif numia (app numif numia))]
    [(ref s)
     (or (sym->num s) (ref s))]
    [(other n s)
     (and (not (sym->num n)) (other n s))]
    [(other-fun n ari acc? f args)
     (define numiargs (map numify args))
     (and (not (sym->num n))
          (andmap identity args)
          (other-fun n ari acc? f numiargs))]
    [(def i x)
     (define numix (numify x))
     (and (not (sym->num i))
          numix
          (def i numix))]
    [(undef i) (and (not (sym->num i)) (undef i))]
    [(defcomb i ps x)
     (define numix (numify x))
     (and (not (sym->num i))
          numix
          (andmap (compose not sym->num) ps)
          (defcomb i ps numix))]))


(define (num-acc? n x)
  (match x
    [(other _ (num _)) #t]
    [_ #f]))

(define (bol-acc? n x)
  (match x
    [(other _ (bool _)) #t]
    [_ #f]))

(define tru (other 'true (bool #t)))
(define fal (other 'false (bool #f)))

(define ite
  (other-fun 'if
             3
             (λ (n x)
               (match* (n x)
                 [(0 (other _ (bool _))) #t]
                 [(0 _) #f]
                 [(_ _) #t]))
             (λ (l)
               (match l
                 [(list (other _ (bool #t)) t _) t]
                 [(list (other _ (bool #f)) _ e) e]))
             '()))

(define (res->exp res)
  (match res
    [#t tru]
    [#f fal]
    [n (other (string->symbol (number->string n)) (num n))]))

(define (numbin name f)
  (define (fun l)
    (match l
      [(list (other _ (num a-num)) (other _ (num b-num)))
       (res->exp (f a-num b-num))]))
  (other-fun name 2 num-acc? fun '()))


(define (numunar name f)
  (define (fun l)
    (match l
      [(list (other _ (num a-num)))
       (res->exp (f a-num))]))
  (other-fun name 1 num-acc? fun '()))


(define npm
  (list (def '+ (numbin '+ +))
        (def '- (numbin '- (λ (a b) (max 0 (- a b)))))
        (def 'add1 (numunar 'add1 add1))
        (def 'sub1 (numunar 'sub1 (λ (a) (max 0 (- a 1)))))
        (def 'true tru)
        (def 'false fal)
        (def 'zero? (numunar 'zero? zero?))
        (def 'if ite)))

(define (eval-halp x)
  (match (step x)
    [(normal x) x]
    [(reduce _ x) (eval-halp x)]
    [(rename _ _ x _) (eval-halp x)]))

(define (prnt l)
  (write (format "out: ~a" (unparse (eval-halp (car l)))))
  tru)

(define (numbery? x)
  (match x
    [(other _ (num _)) #t]
    [(app (app (other-fun '+ _ _ _ '()) a) b) (and (numbery? a) (numbery? b))]
    [(app (other-fun '+ _ _ _ (list _)) a) (numbery? a)]
    [_ #f]))

(define (add-together x)
  (match x
    [(other _ (num n)) n]
    [(app (app (other-fun '+ _ _ _ '()) a) b) (+ (add-together a) (add-together b))]
    [(app (other-fun '+ _ _ _ (list a)) b) (+ (add-together a) (add-together b))]))

(define fast+
  (other-fun '+
             2
             (λ (n x) (numbery? x))
             (λ (l)
               (define res (apply + (map add-together l)))
               (other (string->symbol (number->string res)) (num res)))
             '()))

(define real-world (list (def 'print (other-fun 'print 1 (λ (n x) #t) prnt '()))
                         (def '% (numbin '% remainder))
                         (def '= (numbin '= =))
                         (def '+ fast+)
                         (def 'true tru)
                         (def 'false fal)
                         (def 'zero? (numunar 'zero? zero?))
                         (def 'if ite)))


(struct package (name defs) #:transparent)
(define packages
  `#hash((npm . ,(package "Number Package Module" (defs '() npm)))
         (real-world . ,(package "Real-World" (defs '() real-world)))))
