<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 1</b><br/>
"Обробка списків з використанням базових функцій"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент</b>: Петрушин Віктор Борисович КВ-12</p>
<p align="right"><b>Рік</b>: 2024</p>

### Загальне завдання  
1. Створіть список з п'яти елементів, використовуючи функції `LIST` і `CONS`. Форма створення списку має бути одна — використання `SET` чи `SETQ` (або інших допоміжних форм) для збереження проміжних значень не допускається. Загальна кількість елементів (включно з підсписками та їх елементами) не має перевищувати 10-12 шт. (дуже великий список робити не потрібно). Збережіть створений список у якусь змінну з `SET` або `SETQ`. Список має містити (напряму або у підсписках):  
   - хоча б один символ  
   - хоча б одне число  
   - хоча б один не пустий підсписок  
   - хоча б один пустий підсписок  
2. Отримайте голову списку.  
3. Отримайте хвіст списку.  
4. Отримайте третій елемент списку.  
5. Отримайте останній елемент списку.  
6. Використайте предикати `ATOM` та `LISTP` на різних елементах списку (по 2-3 приклади для кожної функції).  
7. Використайте на елементах списку 2-3 інших предикати з розглянутих у розділі 4 навчального посібника.  
8. Об'єднайте створений список з одним із його непустих підсписків. Для цього використайте функцію `APPEND`.  


```lisp
CL-USER> ;; Пункт 1 (A 7 (KPI ALPHA BETA) NIL K (33 777 55) GAMMA)
(defvar list1 nil)
(setq list1 (cons 'a 
		(cons 7 
		    (cons (list 'kpi 'alpha 'beta)
			  (cons '()
			 	(cons 'k (cons (list 33 777 55) (cons 'gamma nil))))))))
(format t "~%1. list1: ")
(print list1)
(format t "~%2. Head of list1 (A): ")
(print (car list1))
(format t "~%3. Tail of list1 ((7 (KPI ALPHA BETA) NIL K (33 777 55) GAMMA)):")
(print (cdr list1))
(format t "~%4. Third element of list1 ((KPI ALPHA BETA)): ")
(print (third list1))
(format t "~%5. The last element of list1 (GAMMA): ")
(print (car (last list1)))
(format t "~%6.1.1. Check atomarity of the first element of list1 (A): ")
(print (atom (car list1)))
(format t "~%6.1.2. Check atomarity of the third element of list1 ((KPI ALPHA BETA)): ")
(print (atom (third list1)))
(format t "~%6.1.3. Check atomarity of the fourth element of list1 (NIL): ")
(print (atom (nth 3 list1)))
(format t "~%6.2.1. LISTP check of the first element of list1 (A): ")
(print (listp (car list1)))
(format t "~%6.2.2. LISTP check of the third element of list1 ((KPI ALPHA BETA)): ")
(print (listp (third list1)))
(format t "~%6.2.3. LISTP check of the sixth element of list1 ((33 777 55)): ")
(print (listp (nth 5 list1)))
(format t "~%7.1.1. EQUALP check of the first element of list1 (A) and value 'a': ")
(print (equalp (car list1) 'a))
(format t "~%7.1.2. EQUALP check of the second element of list1 (7) and value 7.0: ")
(print (equalp (second list1) 7.0))
(format t "~%7.2.1. NULL check of the third element of list1 ((KPI ALPHA BETA)): ")
(print (null (third list1)))
(format t "~%7.2.2. NULL check of the fourth element of list1 (NIL):")
(print (null (nth 3 list1)))
(format t "~%8. APPEND list1 with it's sixth element ((33 777 55)): ")
(print (append list1 (nth 5 list1)))

1. list1: 
(A 7 (KPI ALPHA BETA) NIL K (33 777 55) GAMMA) 
2. Head of list1 (A): 
A 
3. Tail of list1 ((7 (KPI ALPHA BETA) NIL K (33 777 55) GAMMA)):
(7 (KPI ALPHA BETA) NIL K (33 777 55) GAMMA) 
4. Third element of list1 ((KPI ALPHA BETA)): 
(KPI ALPHA BETA) 
5. The last element of list1 (GAMMA): 
GAMMA 
6.1.1. Check atomarity of the first element of list1 (A): 
T 
6.1.2. Check atomarity of the third element of list1 ((KPI ALPHA BETA)): 
NIL 
6.1.3. Check atomarity of the fourth element of list1 (NIL): 
T 
6.2.1. LISTP check of the first element of list1 (A): 
NIL 
6.2.2. LISTP check of the third element of list1 ((KPI ALPHA BETA)): 
T 
6.2.3. LISTP check of the sixth element of list1 ((33 777 55)): 
T 
7.1.1. EQUALP check of the first element of list1 (A) and value 'a': 
T 
7.1.2. EQUALP check of the second element of list1 (7) and value 7.0: 
T 
7.2.1. NULL check of the third element of list1 ((KPI ALPHA BETA)): 
NIL 
7.2.2. NULL check of the fourth element of list1 (NIL):
T 
8. APPEND list1 with it's sixth element ((33 777 55)): 
(A 7 (KPI ALPHA BETA) NIL K (33 777 55) GAMMA 33 777 55)
```
### Варіант 2 (18)
Створіть список, що відповідає структурі списку, наведеній на рисунку (за варіантом). Для цього допускається використання не більше двох форм конструювання списку на "верхньому рівні". Але аргументами цих форм можуть бути результати інших викликів форм конструювання списків. Номер варіанту обирається як номер у списку групи, який надсилає викладач на початку семестру (на випадок, якщо протягом семестру стануться зміни в складі групи), за модулем 8: 1 -> 1, 2 -> 2, ..., 9 -> 1, 10 -> 2, ...
<p align="center">
    <img src="images/fp_lab1.png" alt="fp_lab1">
</p>

```lisp
CL-USER> ;; Пункт 2
(defvar list2 nil)
(setq list2 (cons (list 'A 2 1) (cons 'B (cons (list 2 1) (cons 'C nil)))))
(format t "~%List2: ")
(print list2)

List2: 
((A 2 1) B (2 1) C)
```

