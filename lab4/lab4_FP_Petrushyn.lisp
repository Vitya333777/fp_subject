;; Завдання №1

(defun sort-func (lst &key (key #'identity) (test #'>=))
  (labels ((exchange-func (unsorted)
    (if (null (cdr unsorted)) 	; якщо список має 1 або 0 елементів
              unsorted
              (let* ((first (car unsorted))
		     (second (cadr unsorted))
		     (first-key (funcall key first))
                     (second-key (funcall key second)))
                (if (funcall test first-key second-key)  	; якщо перший елемент більший рівний другому 
                    (cons second (exchange-func (cons first (cddr unsorted)))) ; міняємо місцями
                    (cons first (exchange-func (cdr unsorted))))))) ; якщо не треба міняти, просто продовжуємо
           (exchange-rec (lst n)
             (if (< n 2)  	; якщо залишилося менше 2 елементів для перевірки
                 lst
               (exchange-rec (exchange-func lst) (- n 1))))) ; рекурсивно викликаємо з новим списком
  (exchange-rec lst (length lst)))) ; починаємо рекурсію з початкового списку та його довжини


(defun test-func-1 (test-name enter-list expected-result &key (key #'identity) (test #'>=))
  (format t "~:[FAILED~;passed~] ~a~%"
    (equal (sort-func enter-list :key key :test test) expected-result) test-name))

(defun call-test-func-1 ()
  (test-func-1 "Test 1.1" '(5 4 3 2 1) '(1 2 3 4 5))
  (test-func-1 "Test 1.2" '(6 7 7 3 5 5 2 1) '(1 2 3 5 5 6 7 7))
  (test-func-1 "Test 1.3" '(-8 7 -3 -5 5 2 -1) '(-1 2 -3 -5 5 7 -8) :key #'abs)
  (test-func-1 "Test 1.4" '(-8 7 -3 -5 5 2 -1) '(-1 2 -3 -5 5 7 -8) :key #'abs :test #'>)
  (test-func-1 "Test 1.5" '(7) '(7))
  (test-func-1 "Test 1.6" '() NIL))

(call-test-func-1)


;; Завдання №2

(defun rpropagation-reducer (&key (comparator #'<))
  (lambda (element result)
    (if (null result)	; якщо в результаті ще немає жодного елемента
        (list element)
        (if (funcall comparator element (car result))	; якщо поточний елемент "кращий", ніж попередній
            (cons element result)	; додаємо до результату поточний елемент
            (cons (car result) result)))))	; якщо не "кращий" - дублюємо попередній елемент

(defun call-rpropagation-reducer (enter-list &key comparator)	; функція для виклику з конкретними значеннями ключових парамерів 
  (reduce (rpropagation-reducer :comparator comparator) enter-list :initial-value '() :from-end t))

(defun test-func-2 (test-name enter-list expected-result &key (comparator #'<))
  (format t "~:[FAILED~;passed~] ~a~%"
    (equal (call-rpropagation-reducer enter-list :comparator comparator) expected-result) test-name))

(defun call-test-func-2 ()
  (test-func-2 "Test 2.1" '(3 2 1 2 3) '(1 1 1 2 3))
  (test-func-2 "Test 2.2" '(3 1 4 2) '(1 1 2 2))
  (test-func-2 "Test 2.3" '(1 5 7) '(7 7 7) :comparator #'>)
  (test-func-2 "Test 2.4" '(7 7 7) '(7 7 7))
  (test-func-2 "Test 2.5" '(7) '(7))
  (test-func-2 "Test 2.6" '(1 2 3 7) '(7 7 7 7) :comparator #'=)
  (test-func-2 "Test 2.7" '() nil))

(call-test-func-2)


