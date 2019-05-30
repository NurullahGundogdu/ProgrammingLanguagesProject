(load "csv-parser.lisp")
(in-package :csv-parser)

;; (read-from-string STRING)
;; This function converts the input STRING to a lisp object.
;; In this code, I use this function to convert lists (in string format) from csv file to real lists.

;; (nth INDEX LIST)
;; This function allows us to access value at INDEX of LIST.
;; Example: (nth 0 '(a b c)) => a

;; !!! VERY VERY VERY IMPORTANT NOTE !!!
;; FOR EACH ARGUMENT IN CSV FILE
;; USE THE CODE (read-from-string (nth ARGUMENT-INDEX line))
;; Example: (mypart1-funct (read-from-string (nth 0 line)) (read-from-string (nth 1 line)))

;; DEFINE YOUR FUNCTION(S) HERE

(defun insert-n (list item index)
  (cond
    ((< index 0) (error "Index too small ~A" index)) 		;;if index smaller than 0 it doesnt add
    ((= index 0) (cons item list))							;;if index equal 0 it adds to 0 index
    ((endp list) (error "Index too big"))					;;if index bigger than list length it doesnt add
    (t (cons (first list) (insert-n (rest list) item (- index 1))))		;;it adds to index
   )
)

;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part3.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%" (insert-n (read-from-string (nth 0 line)) (read-from-string (nth 1 line)) (read-from-string (nth 2 line)))
      ;; CALL YOUR (MAIN) FUNCTION HERE



      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)
