;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname txt-file-processing) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/batch-io)
(require racket/string)

; Problem 1: Seventeenth Item in a List
; Write a function to find the 17th item in a list.

; List, Number -> Element
; Given a list, lst, and a number, start-index, returns the 17th element in the list.
(define (seventeenth-helper lst start-index)
  (local
    [(define index (+ start-index 1))]
    (cond
      [(empty? lst) 0]
      [(= index 17) (first lst)]
      [else (seventeenth-helper (rest lst) index)])))  
    


; List -> Element
; Given a list, lst, returns the 17th element in the list.
(define (seventeenth lst)
  (seventeenth-helper lst 0))




; Problem 2: Longest Word in the Text
; Write a function to find the longest word in the file given by the parameter filename.
; Note the given check-expects, and the included small test file.
; Your code does not need to worry about punctuation.


; List of Strings, String -> String
; Given a list of strings, words, and a string, word, returns the longest string. 
(define (longest-word-helper word words)
  (cond
    [(empty? words) ""]
    [(empty? (rest words)) word]
    [(> (string-length word) (string-length (first words))) (longest-word-helper word (rest words))]
    [else (longest-word-helper (first words) (rest words))]))


; Text File -> String
; Given a textfile, filename, returns the longest string. 
(define (longest-word-in-a-file filename)
  (local
    [(define words (read-words filename))]
    (longest-word-helper "" words)))
  

(check-expect (longest-word-in-a-file "txt-files/txt-file-processing/problem2/test1.txt") "love")
(check-expect (longest-word-in-a-file "txt-files/txt-file-processing/problem2/test2.txt") "farmhouse")





; Problem 3: Shortest Line in a File
; For this problem, produce the line in the file that has the least number of words.
; Again, no need to worry about punctuation. Your function should produce a list of the words on that line

; List of a Lists, List -> List
; Given a list of a lists, 2d-list, and a list, lst, returns the shortest list.
(define (shortest-line-helper lst 2d-list)
  (cond
    [(empty? 2d-list) empty]
    [(empty? (rest 2d-list)) lst]
    [(empty? lst) (shortest-line-helper (first 2d-list) (rest 2d-list))]
    [(< (length lst) (length (first 2d-list))) (shortest-line-helper lst (rest 2d-list))]
    [else (shortest-line-helper (first 2d-list) (rest 2d-list))]))


; Text File -> List of Strings  
; Given a text file, filename, returns the shortest line as a list of strings. 
(define (shortest-line-in-a-file filename)
  (local
    [(define 2d-list (read-words/line filename))]
    (shortest-line-helper empty 2d-list )))

(check-expect (shortest-line-in-a-file "txt-files/txt-file-processing/problem3/test1.txt") (list "Such" "indomitable" "effervescence" "accomplishes" "magnificance"))
(check-expect (shortest-line-in-a-file "txt-files/txt-file-processing/problem3/test2.txt") (list "Hourglass") )




; Problem 4: Find Lines with So-Many Words
; Write a function that takes a filename and a number k as input,
; and produces a list containing all the lines of the text that contain exactly k words in the line.
; You may find the string-join function useful.

; List of Lists, Number -> List of Lists
; Given a list of lists, 2d-list, and a number, z, returns the list of lists populated with lists that have a length of x.
(define (list-length-filter 2d-list x)
  (cond
    [(empty? 2d-list) empty]
    [(= x (length (first 2d-list))) (cons (first 2d-list) (list-length-filter (rest 2d-list) x))]
    [else  (list-length-filter (rest 2d-list) x)]))


; Text File, Number -> List of Strings
; Given a text file path, filename, and number, k,
; returns a list of strings that has every line with k amount of strings. 
(define (lines-with-k-words filename k)
  (local
    [(define 2d-list (read-words/line filename))
    (define filtered-list (list-length-filter 2d-list k))]
    (map string-join filtered-list)))
    
    

(check-expect (lines-with-k-words "txt-files/txt-file-processing/problem4/test1.txt" 7)
    (list
    "Where the quiet-coloured end of evening smiles,"
    "On the solitary pastures where our sheep"
    "Of our country's very capital, its prince"
    "To distinguish slopes of verdure, certain rills"
    "O'er the hundred-gated circuit of a wall"
    "Such a carpet as, this summer-time, o'er-spreads"
    "Every vestige of the city, guessed alone,"
    "By the caper overrooted, by the gourd"
    "To their folding, all our many-tinkling fleece"))
(check-expect (lines-with-k-words "txt-files/txt-file-processing/problem4/test2.txt" 4)
    (list "An ancient childhood thing" "Is always the same"))




; Problem 5: Delete Words with More Than Three Letters
; Reproduce the file as a list of strings, in which every word of length > 3 has been deleted.


; Text File -> List of Strings
; Given a text file, filename, produces a list of strings containing only words from the textfile of length <= 3. 
(define (delete>3 filename)
  (local
    [(define 2d-list (read-words/line filename))]

    (map string-join (delete>3-helper 2d-list))))


; List of Lists of Strings -> List of Strings
; Given a list of lists of strings, 2d-list, returns a list of lists of strings without the words with length > 3.
(define (delete>3-helper 2d-list)
  (map (lambda (line) (filter (lambda (item) (<= (string-length item) 3)) line)) 2d-list))



; Problems 6: Bar Graph
; Turn a file into a bar graph. Each word in the file becomes a rectangle whose width is 5 and whose height is the number of letters in the word. Each line becomes a beside of its word-rectangles, and the whole text becomes the above of its bar-graph lines.
; The results for the three files given in the Template are shown below.

; Text File -> Image
; Given a text file produces a bar graph based upon the length of each word. 
(define (file2barGraph filename)
  (local
    [(define 2d-list (read-words/line filename))]
    (stack (file2barGraph-helper 2d-list))))

(define (file2barGraph-helper 2d-list)
  (map (lambda (x) (squeeze (string->image x))) 2d-list))

; List of Images -> Image
; Given a list of images, loi, returns an image of each image beside the other.
(define (squeeze loi)
  (if (empty? loi)
      empty-image
      (beside (first loi) (squeeze (rest loi)))))

; List of Images -> Image
; Given a list of images, loi, returns an image of each image above the other.
(define (stack loi)
  (if (empty? loi)
      empty-image
      (above (first loi) (stack (rest loi)))))


; List of Strings -> List of Images
; Given a list of strings, los, returns a list of rectangles with height equal to the length of each string. 
(define (string->image los) (map (lambda (word) (rectangle 5 (string-length word) 'solid 'red)) los))


