; Оголошення ключів для проектів і моделей
(defvar *project-keys*
  '(:id :project-name :start-date :project-manager :description))

(defvar *ai-model-keys*
  '(:id :ai-model-name :creation-date :intelligence-level :description))

; Функція для очищення рядків від пробілів, табуляцій та нових рядків
(defun clean-string (str)
  (string-trim '(#\Space #\Tab #\Newline #\Return) str))

; Функція для розбиття рядка на частини
(defun line-to-parts (line)
  (let ((start 0)  	; Початкова позиція
        (result nil))  	; Результуючий список
    (loop for sep = (position #\, line :start start)  ; Знаходимо позицію наступної коми
          while sep
          do (push (clean-string (subseq line start sep)) result)  	; Додаємо частину до списку
             (setf start (1+ sep)))  					; Зсуваємо початкову позицію
    (push (clean-string (subseq line start)) result)  			; Додаємо останню частину
    (nreverse result)))  				; Повертаємо список у правильному порядку

; Функція для перетворення рядка на асоціативний список за шаблоном keys
(defun line-to-record (line keys)
  (let ((parts (line-to-parts line)))  	; Розбиваємо рядок на частини
    (loop for key in keys  		; Ітеруємося по ключах
          for value in parts  		; Ітеруємся по значеннях
          collect (cons key value))))  	; Створюємо пари ключ-значення

; Функція для зчитування таблиць з CSV-файлу
(defun read-csv (file-path keys)
  (with-open-file (stream file-path)  	; Відкриваємо файл для читання
    (loop for line = (read-line stream nil)  ; Зчитуємо кожен рядок
          while line  			; Поки рядки не закінчились
          collect (line-to-record line keys))))  ; Перетворюємо рядки на записи

; Функція для виведення асоціативних списків у вигляді таблиці
(defun print-table (records keys) 
  (let ((headers (mapcar (lambda (key) (string-upcase (symbol-name key))) keys))  ; Заголовки таблиці
        (rows (mapcar (lambda (record)  	; Для кожного запису в списку records
                        (mapcar (lambda (key) 	; Для кожного ключа в списку keys
                                  (let ((value (cdr (assoc key record))))  	; Отримуємо значення для поточного ключа в записі
                                    (if value (princ-to-string value) "")))  	; Якщо значення є, перетворюємо його на рядок
                                keys)) 		; Для кожного ключа виконуємо перетворення значення
                      records))) 		; Рухаємось по всіх записах у списку records
    (format t "~{~a~^ | ~}~%" headers)
    (format t "~{~a~^~}~%" (make-list (length headers) :initial-element "----------------"))
    (dolist (row rows)
      (format t "~{~a~^ | ~}~%" row))
    (format t "~{~a~^~}~%" (make-list (length headers) :initial-element "----------------"))
    (format t "~%")))

; Функція для вибірки записів з файлу
(defun select (file-path keys &optional filters)
  (let ((records (read-csv file-path keys)))  	; Зчитуємо всі записи з CSV-файлу, перетворюючи їх на асоціативні списки
    (if (not filters)  				; Якщо фільтри не задано
        records  			; Повтертаємо всі записи, без фільтрації
        (remove-if-not  		; Якщо фільтри є, то використовуєм функцію remove-if-not для фільтрації записів
         (lambda (record)  		; Для всіх записів
           (every (lambda (filter)  	; Застосовуємо кожен фільтр
                    (let ((key (car filter))  	; Отримуємо ключ фільтра
                          (value (cdr filter))) ; Отримуємо значення фільтру
                      (equal (cdr (assoc key record)) value)))  	; Перевіряємо чи значення по даному ключу в записі співпадає з фільтром
                  filters))
         records))))  		; Повертаємо записи які відповідають усім фільтрам

; Функція для запису асоціативних списків у CSV-файл
(defun write-csv (file-path records keys)
  (with-open-file (stream file-path :direction :output :if-exists :overwrite :element-type 'character)  ; Відкриваємо файл для запису
    (dolist (record records)  		; Ітеруємось по кожному запису в списку records
      (format stream "~{~a~^,~}~%"  
              (mapcar (lambda (key)  	; Для кожного ключа зі списку кейс
                        (let ((value (cdr (assoc key record))))  	; Отримуємо значення, яке відповідає ключу в записі
                          (if value (princ-to-string value) "")))  	; Якщо значення є - перетворюємо його в рядок
                      keys)))))  	; Для кожного запису проходимось по всіх ключах


; Функція для перетворення асоціативного списку в хеш-таблицю
(defun alist-to-hash-table (alist)
  (let ((hash (make-hash-table :test 'equal)))  	; Створюємо нову хеш-таблицю
    (dolist (pair alist)  				; Ітеруємось по всіх елементах списку
      (setf (gethash (car pair) hash) (cdr pair)))  	; Додаємо пари ключ-значення в таблицю
    hash))		; Повертаємо хеш-таблицю

(defun test-print-table (file-path keys)
  (let ((records (read-csv file-path keys)))
    (print-table records keys)))

(defun test-alist-to-hash-table ()
  (let* ((alist '((:id . 1)
                  (:ai-model-name . "Tasco")
                  (:creation-date . "10-08-2019")
                  (:intelligence-level . "Medium")
                  (:description . "AI bot for researching info")))
         (hash-table (alist-to-hash-table alist)))
    (format t "~%Alist: ~a~%" alist)
    (format t "~%Hash table:~%")
    (maphash (lambda (key value) 	; Ітеруємось по всіх елементах хеш-таблиці
               (format t "~a => ~a~%" key value))
             hash-table)))	; Хеш-таблиця, по якій ми ітеруємось

(format t "~%Reading and output Projects table from file:~%")
(test-print-table "D:/fp_lab5/Projects-table.csv" *project-keys*)

(format t "Reading and output AI-Models table from file:~%")
(test-print-table "D:/fp_lab5/AI-Models-table.csv" *ai-model-keys*)

(format t "Select function using output:~%")
(let ((filtered-records (select "D:/fp_lab5/AI-Models-table.csv" *ai-model-keys* '((:intelligence-level . "High")))))
  (print-table filtered-records *ai-model-keys*))

(format t "Select function using and writing results in file successfully!~%")
(let ((filtered-records (select "D:/fp_lab5/Projects-table.csv" *project-keys* '((:start-date . "05-05-2024")))))
  (write-csv "D:/fp_lab5/Projects-filtered.csv" filtered-records *project-keys*))

(format t "~%Converting alist to hash-table:~%")
(test-alist-to-hash-table)
