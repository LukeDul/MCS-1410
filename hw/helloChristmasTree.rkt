;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname helloChristmasTree) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(overlay
 
 (overlay/offset

  ;red ornament
  (overlay
   (ellipse 5 15 70 'red)
   (ellipse 10 10 40 'red)
   (ellipse 15 5 70 'red)
  )

  9 11 ;ornament offset values 
  
  ;silver ornament
  (overlay 
   (ellipse 5 15 100 (make-color 208 209 216))
   (ellipse 10 10 40 (make-color 208 209 216))
   (ellipse 15 5 100 (make-color 208 209 216))
  )
 )
 
 (overlay/offset
  (star 7 'solid (make-color 231 208 154))
  
  0 30 ; star + christmas tree offset values 

  ;branches + trunk
  (above
   (overlay/offset 

     (triangle 50 'solid (make-color 51 74 63))
     0 10
     (triangle 40 'solid (make-color 51 74 63)))

   (rectangle 11 15 'solid (make-color 45 19 21))
  )
 )
) 

