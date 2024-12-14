;; Завдання №1

(defun group-pairs (list1)
"Result pairs: "
(if (null list1)
	nil
(if (= 1 (list-length list1))
	(cons (list (car list1)) nil)
	(cons (list (car list1) (cadr list1))
		(group-pairs (cddr list1))))))

(defun test_func_1 (test_name enter_list expected_result)
(format t "~:[FAILED~;passed~] ~a~%"
          (equal (group-pairs enter_list) expected_result) test_name))

(defun call_test_func_1 ()
(test_func_1 "Test 1.1" '(A B C D E F G) '((A B) (C D) (E F) (G)))
(test_func_1 "Test 1.2" '(A) '((A)))
(test_func_1 "Test 1.3" '() NIL))

(call_test_func_1)

;; Завдання №2

(defun is-in-list (element list)
(cond
((null list) nil)
((eql (car list) element) t)
(t (is-in-list element (cdr list)))))

(defun list-set-union (list1 list2)
"Result list: "
(cond
((and (null list1) (null list2)) nil)
((null list1) list2)
((null list2) list1)
((is-in-list (car list1) list2)
(list-set-union (cdr list1) list2))
(t (cons (car list1) (list-set-union (cdr list1) list2)))))

(defun test_func_2 (test_name enter_list_1 enter_list_2 expected_result)
(format t "~:[FAILED~;passed~]... ~a~%"
          (equal (list-set-union enter_list_1 enter_list_2) expected_result) test_name))

(defun call_test_func_2 ()
(test_func_2 "Test 2.1" '(1 2 3 4) '(3 4 5 6) '(1 2 3 4 5 6))
(test_func_2 "Test 2.2" '(1 2 3 4 5) '() '(1 2 3 4 5))
(test_func_2 "Test 2.3" '() '() NIL))

(call_test_func_2)
