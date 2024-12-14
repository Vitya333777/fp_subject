;; Функціональний варіант реалізації

(defun sort_func (lst)
  (labels ((exchange_func (unsorted)
             (if (null (cdr unsorted)) ; якщо список має 1 або 0 елементів
                 unsorted
                 (let ((first (car unsorted))
                       (second (cadr unsorted)))
                   (if (>= first second)  ; якщо перший елемент більший за другий
                       (cons second (exchange_func (cons first (cddr unsorted)))) ; міняємо місцями
                       (cons first (exchange_func (cdr unsorted))))))) ; якщо не треба міняти, просто продовжуємо
           (exchange_rec (lst)
             (let ((new_lst (exchange_func lst))) ; викликаємо exchange_func для поточного списку
               (if (equal new_lst lst)  ; якщо список не змінився (вже відсортований)
                   lst
                   (exchange_rec new_lst))))) ; рекурсивно викликаємо, поки не отримаємо відсортований список
    (exchange_rec lst))) ; викликаємо exchange_rec для початкового списку

(defun test_func_1 (test_name enter_list expected_result)
(format t "~:[FAILED~;passed~] ~a~%"
          (equal (sort_func enter_list) expected_result) test_name))

(defun call_test_func_1 ()
(test_func_1 "Test 1.1" '(5 4 3 2 1) '(1 2 3 4 5))
(test_func_1 "Test 1.2" '(6 7 7 3 5 5 2 1) '(1 2 3 5 5 6 7 7))
(test_func_1 "Test 1.3" '() NIL))

(call_test_func_1)

;; Імперативний варіант реалізації

(defun exchange_swap (lst i j) ; Функція для обміну елементів на позиціях i та j
  (let ((tmp (nth i lst)))
    (setf (nth i lst) (nth j lst))
    (setf (nth j lst) tmp)))

(defun sort_imp (lst)
  (let ((lst_copy (copy-list lst)) ; Створюємо копію списку
        (n (length lst)))
    (do ((i 0 (+ i 1)))               ; Проходимо по всіх елементах
        ((>= i (- n 1)))              ; Коли i досягає n-1, виходимо з циклу
      (do ((j 0 (+ j 1)))             ; Вкладений цикл для порівняння пар елементів
          ((>= j (- n 1 i)))          ; Коли j досягає n-1-i, виходимо з циклу
        (when (>= (nth j lst_copy) (nth (+ j 1) lst_copy)) ; Якщо елементи в неправильному порядку
          (exchange_swap lst_copy j (+ j 1))))) ; Обмінюємо їх місцями
    lst_copy)) 

(defun test_func_2 (test_name enter_list expected_result)
(format t "~:[FAILED~;passed~] ~a~%"
          (equal (sort_imp enter_list) expected_result) test_name))

(defun call_test_func_2 ()
(test_func_2 "Test 2.1" '(5 4 3 2 1) '(1 2 3 4 5))
(test_func_2 "Test 2.2" '(6 7 7 3 5 5 2 1) '(1 2 3 5 5 6 7 7))
(test_func_2 "Test 2.3" '() NIL))

(call_test_func_2)
