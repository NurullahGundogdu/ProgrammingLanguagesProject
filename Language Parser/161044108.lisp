
(setq nextI 0)
(setq liste '())
(setq lexeme_list '())

(defun getNext ()

	(if (eq nextI (list-length lexeme_list))
		(progn
            (setq nextChar "eof")
			nil
		)
	)
    (setq nextChar (string (car (nth nextI lexeme_list)))) ; To take token part
    (setq nextChar2 (string (car (cdr (nth nextI lexeme_list))))) ; To take lexeme part
    (setq nextI (+ nextI 1)) ; to take next one 
    t
)

(defun spaces(i)
	(cond ( (> i 0)
		  	(format wrt " ")
			(spaces (- i 1))
		  )   
	)
)



(defun parse(lexeme)
	(setq lexeme_list lexeme)
	(start)    
)
(defun parser (liste_deneme)
    (with-open-file (str "161044108.tree"
    :direction :output
    :if-exists :supersede
    :if-does-not-exist :create)
    (setq wrt str)
    (parse liste_deneme))
    
)


(defun expb(i)

    (spaces i)
    (format wrt "EXPB~%")
		  	    
    (if (eq t (openParen(+ i 1)))
        (if (eq t (and_operator (+ i 1)))
        	(progn
        	 (expb (+ i 1)) 
        	 (expb (+ i 1)) 
        	 (closeParen (+ i 1))
             t
            )
            (if (eq t (or_operator (+ i 1)))
         		(progn
				 (expb (+ i 1)) 
				 (expb (+ i 1)) 
				 (closeParen (+ i 1))
 		           t
	            )
	            (if (eq t (not_operator (+ i 1)))
	            	(progn
	            		(expb (+ i 1)) 
	            		(closeParen (+ i 1))
	            		t
	            	)
	                (if (eq t (equal_operation (+ i 1)))
	                    (if (eq t (expb (+ i 1))) 
	                    	(progn
	                    		 (expb (+ i 1)) 
	                    		 (closeParen (+ i 1))
	                        	t
	                        )
	                        (if (eq t (expi (+ i 1))) 
	                        	(progn
	                        		(expi (+ i 1))
	                        		(closeParen (+ i 1))
	                            	t
	                            )
	                            nil
	                        )
	                    )

	                )
	            )
        	)
        )

    )
)

(defun explisti(i)

    (spaces i)
    (format wrt "EXPLISTI~%") 

        (if(eq t (openParen (+ i 1)) )
            (if (eq t (concat_operation(+ i 1) )) 
                (progn
                	(explisti (+ i 1)) 
                	(explisti (+ i 1)) 
                	(closeParen (+ i 1))
                	t
                )
                (if (eq t (append_operation (+ i 1)))
                    (progn
	                    (expi (+ i 1)) 
	                    (explisti (+ i 1)) 
	                  	(closeParen (+ i 1))
	                    t
                    )
                )
            )
            (if (equal nextChar "null")
                (progn
                     (spaces i)
                     (format wrt"~a~%" nextChar)
                     (getNext)
                    t 
                )
                (if (equal t (comma_operator (+ i 1))) 
                    (progn
                    	(openParen(+ i 1)) 
                    	(closeParen (+ i 1)) 
                    	t
                    )
                    (if (equal  t (comma_operator (+ i 1)))
                        (progn
	                        (openParen(+ i 1))
	                        (space_values (+ i 1))
	                        (closeParen (+ i 1)) 
	                        t
                        )
                        (if (eq t (expi (+ i 1)))
                            t   
                        )
                    ) 
                )
            )
        ) 
)


(defun comma_operator(i)
	(cond ((equal nextChar2 "'")
			(spaces i)
    		(format wrt "'~%")
            (getNext)
            t
		  )
	)

)

(defun arithmetic_operations(i)
	(cond ( (equal nextChar2 "+")
		  	    (spaces i)
    			(format wrt "INPUT~%")
	            (getNext)
	            t
		  )
	)
	(cond ( (equal nextChar2 "-")
		  	 (spaces i)
    	     (format wrt "INPUT~%")
	         (getNext)
	          t
		  )
	)
	(cond ( (equal nextChar2 "*")
		  	 (spaces i)
    		 (format wrt "INPUT~%")
	         (getNext)
		  	  t
		  )
	)
	(cond ( (equal nextChar2 "/")
		  	 (spaces i)
    	     (format wrt "INPUT~%")
	         (getNext)
		  	  t
		  )
	)
)

(defun def_fun(i)
	(cond ((equal nextChar2 "deffun")
			(spaces i)
    		(format wrt "deffun~%")
            (getNext)
            t
		  )
	)
)

(defun def_var(i)
	(cond ((equal nextChar2 "defvar")
			(spaces i)
    		(format wrt "defvar~%")
            (getNext)
            t
		  )
	)
)

(defun Conditions(i)
	(cond ((equal nextChar2 "if")
			(spaces i)
    		(format wrt "if~%")		  	    
            (getNext)
            t
		  )
	)
)

(defun not_operator(i)
	(cond ((equal nextChar2 "not")
			(spaces i)
    		(format wrt "not~%")  
            (getNext)
            t
		  )
	)
)

(defun equal_operation(i)
	(cond ((equal nextChar2 "equal")
			(spaces i)
    		(format wrt "equal~%") 
            (getNext)
            t
		  )
	)
)

(defun concat_operation(i)
	(cond ((equal nextChar2 "concat")
			(spaces i)
    		(format wrt "concat~%")		  	    
            (getNext)
            t
		  )
	)
)

(defun append_operation(i)
	(cond ((equal nextChar2 "append")
			(spaces i)
    		(format wrt "append~%")    
            (getNext)
            t
		  )
	)
)

(defun and_operator(i)
		(cond ((equal nextChar "keyword")
			(cond ((equal nextChar2 "and")
					(spaces i)
    				(format wrt "and~%") 
		            (getNext)
		            t
	            )
		  	)
		  	)
		)
)

(defun or_operator(i)
		(cond ( (equal nextChar "keyword")
				(cond ((equal nextChar2 "or")
					(spaces i)
    				(format wrt "or~%")		  	    
-		            (getNext)
		            t
	            	)
		  		) 
		  	  )
		)
)


(defun space_Num(i)
	(cond ((equal nextChar "integer")
			(spaces i)
    		(format wrt "integer~%") 	
            (getNext)
            t
		  )
	)
)

(defun ID(i)
	(cond ((equal nextChar "identifier")
			(spaces i)
    		(format wrt "identifier~%")
            (getNext)
            t
		  )
	)
)

(defun openParen(i)
    (Operators i "(")
)

(defun closeParen (i)
    (Operators i ")")
)

(defun idlist(i)
    (spaces i)
    (format wrt "IDLIST~%")
    (setq variable "false")
 	(cond ((eq t (openParen(+ i 1)))		
		 	(cond ((eq t (idlist(+ i 1)))
		 			(cond ((eq t (closeParen(+ i 1)))
							(setq variable "true")				
							t		 			
			 			)
				 	) 			
		 		  )
		 	) 			
 		  )
 		  ((not (eq variable "true"))
 			 (cond ((eq t (ID (+ i 1)))
 			 	   		(idlist (+ i 1))
 			 	   		(setq variable "true")	
 			 	   		t
 			 	   )
 			 )	  	
 		  )
 	)
)

(defun Operators(i o)
	(cond ((string= nextChar "operator")
			(cond ((string= nextChar2 o)
					(spaces i)
					(format wrt "~a~%" o)
		            (getNext)
		            t
	              )
		  	)
		  )
	)
)

(defun space_values(i)

	(spaces i)
    (format wrt "VALUES~%")	  	    
    (cond ((eq t (space_Num (+ i 1)))
    		(values (+ i 1))
    		t
    	  )
    )
)


(defun start()
	(setq i 1)
	(format wrt ";Directive: parse tree~%")
    (format wrt "START~%")
    (spaces i)
    (format wrt "INPUT~%")
    (getNext)
    (expi (+ i 1))
)



(defun expi(i)
    (spaces i)
    (format wrt "EXPI~%")

    (if(eq t (ID (+ i 1)))
        t
        (if (eq t (space_Num (+ i 1)))
          t 
          (if (eq t (openParen (+ i 1)))
                (if (eq t (arithmetic_operations (+ i 1)))
                	(progn
                	 	(expi (+ i 1))  
                	 	(expi (+ i 1)) 
                	 	(closeParen (+ i 1)) 
                	 	t
                	 )
                    (if (eq t (ID (+ i 1)))
                        (progn
	                        (explisti (+ i 1)) 
	                        (closeParen (+ i 1)) 
	                        t
                        )
                        (if (and (def_fun (+ i 1)) (and (ID(+ i 1)) (and (idlist(+ i 1)) (and (explisti(+ i 1)) (closeParen(+ i 1))))))
                        	t
                           (if (and (def_var (+ i 1)) (and (ID (+ i 1)) (and (expi (+ i 1)) (closeParen (+ i 1)) )))
                                t
                                (if (and (Conditions (+ i 1)) (and (expb (+ i 1)) (explisti (+ i 1)) ))
                                    (if (and (explisti (+ i 1)) (closeParen (+ i 1)))
                                        t
                                        (if (eq t (closeParen (+ i 1)))
                                            t
                                            ;nil
                                        )
                                    )
                                )
                            )
                        )
                    )
                ) 
            )          
        )   
    )    
)
