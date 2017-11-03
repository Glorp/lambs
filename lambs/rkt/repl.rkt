#lang racket
(provide repl)

(require "run.rkt"
         "parse.rkt"
         "packages.rkt"
         "unparse.rkt"
         "structs.rkt"
         "draw-exp.rkt"
         "slides.rkt"
         (only-in 2htdp/image scale image? square))

(define num-parse (compose numify parse))


(define ((write-stuff img scal) x)
  (write 
   (match x
     [(? image?) (img (scale scal x))]
     [(static-image path) `(img ,path)]
     [(? string?) x]
     [_ (~a x)])))

(define (command/rest s)
  (match (regexp-match #rx"^[\t\r ]*(.*?)[\t\r ]+(.*)$" s)
    [(list _ "" c) (cons c "")]
    [(list _ c r) (cons c r)]
    [#f (cons s "")]))

(define (repl img [scal 3/2])
  ((write-stuff img scal) (format ":scale ~a~n" scal))
  (let loop ([it ":)"] [scal scal] [ds (defs '() '())])
    (define write (write-stuff img scal))
    
    (flush-output)
    (define s (read))
    (newline)
    
    (with-handlers
        ([(λ (_) #t)
          (λ (e)
            (write (exn-message e))
            (loop it scal ds))])
      
           
      (match (command/rest s)
        {(cons "" "")
         (write "beep boop")
         (loop it scal ds)}
        
        [(cons ":scale" "")
         (write (format ":scale ~a" scal))
         (loop it scal ds)]
        
        [(cons ":scale" new)
         (define new-scal (string->number new))
         ((write-stuff img new-scal) (square 40 'solid 'blue))
         (loop it new-scal ds)]

        [(cons ":it" "")
         (write it)
         (loop it scal ds)]

        [(cons ":install" x)
         (match (hash-ref packages (string->symbol x))
           [(package n new-ds)
            (write (format "Installing ~a..." n))
            (loop it scal new-ds)])]

        [(cons ":slide" x)
         (for ([y (hash-ref slides (string->symbol x))])
           (write y))
         (loop it scal ds)]
               
        [(cons ":q" "") (void)]

        [(cons ":run1" top-s)
         (define top (num-parse top-s))
         (define new-ds
           (cond [top (run1 top ds)]
                 [else (write ":(")
                       ds]))
         (loop s scal new-ds)]

        [(cons ":run1000" exp-s)
         (define exp (num-parse exp-s))
         (if (exp? exp)
             (run 1000 exp ds)
             (write ":("))
         (loop exp-s scal ds)]

        [(cons ":rename" exp-s)
         (define exp (num-parse exp-s))
         (if (exp? exp)
             (rename-defs exp ds)
             (write ":("))
         (loop exp-s scal ds)]

        [(cons ":draw" exp-s)
         (define exp (parse exp-s))
         (if (exp? exp)
             (write (draw-exp exp))
             (write ":("))
         (loop exp-s scal ds)]))))

