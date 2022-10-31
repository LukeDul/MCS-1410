#lang racket

(require racket/draw)

(require racket/gui)

(define canvas (make-bitmap 100 100))

(define dc (new bitmap-dc% [bitmap canvas]))

(send dc set-pen "white" 2 'solid)

(define ap (new dc-path%))

(send ap move-to 50 60)

(send ap line-to 56 68)

(send ap line-to 56 68)

(send ap line-to 56 68)



(define waypoint-list (empty))

; Given a number of waypoints and radius
; produce an asteroid 
(define (make-asteroid num-of-waypoints)

(send dc draw-path ap)

(make-object image-snip% canvas)