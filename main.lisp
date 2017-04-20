;;;; main.lisp

(in-package #:yapang)

(defvar *font-face*)
(defvar *title* "(Y)et (A)nother (Pang) game")

(defparameter *dx* 0)
(defparameter *dy* 0)

(defparameter *color* (hex-to-color "#5C5C5C"))

(defclass game ()
  ((drawable :initform nil)
   (time :initform 0)))

(defclass entity ()
  ((x :initarg :x :initform 0)
   (y :initarg :y :initform 0)))

(defclass user (entity))

(defclass ball (entity))

(defun draw-user (x y)
  (with-current-matrix
    (translate *dx* *dy*)
    (ngon 3 x y 30 30 30)))


(defsketch yapang
    ((title *title*) (width 800) (height 600))
  (background +white+)
  (with-pen (make-pen :stroke *color* :weight -5 :fill (hex-to-color "#FFEAEA"))
    (circle (/ width 2) (/ height 3) 100))

  (with-pen (make-pen :stroke *color* :weight -3)
    (draw-user (/ width 2) (- height 15)))
  (with-font (make-font :face *font-face* :size 40 :color *color*)
    (text *title* 165 50))
  (with-font (make-font :face *font-face* :size 30 :color *color*)
    (text "PRESS SPACE TO START" 250 390))
  )

(defmethod setup ((instance yapang) &key &allow-other-keys)
  (setf *font-face* (load-resource (sketch::relative-path "data/HKGrotesk-Regular.otf" 'yapang))))

(defmethod kit.sdl2:keyboard-event ((yapang yapang) state timestamp repeat-p keysym)
  (declare (ignorable timestamp repeat-p keysym))
  (when (eql state :keydown)
    (let ((scancode-value (sdl2:scancode-value keysym)))
      (when (sdl2:scancode= scancode-value :scancode-a)
        (decf *dx* 10))
      (when (sdl2:scancode= scancode-value :scancode-d)
        (incf *dx* 10)))))

(defun yapang ()
  (make-instance 'yapang))

;; (yapang:yapang)
