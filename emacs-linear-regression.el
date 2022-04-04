;;; custom/emacs-linear-regression.el -*- lexical-binding: t; -*-

(setq x-values-original '(140 155 159 179 192 200 212))
(setq y-values-original '(60 62 67 70 71 72 75))
;;(emacs-linear-regression '(140 155 159 179 192 200 212) '(60 62 67 70 71 72 75))
(emacs-linear-regression x-values-original y-values-original)
(defun emacs-linear-regression (x y)
  "Returns the eqution for the linear regression"
  (interactive)
  (message "y = %s + %s * x" (b-zero x y) (b-one x y)))

(defun xy-product-calc (x y)
  "Calcultes the product of x and y"
  (setq x-values (copy-sequence x))
  (setq y-values (copy-sequence y))
  (setq xy-product '())
  (setq counter 0)
  (setq length (length x-values))
  (while (< counter length)
    (push (* (pop x-values) (pop y-values)) xy-product)
    (setq counter (1+ counter)))
  (reverse xy-product))

(defun squared (list)
  "Calculates the square of each element in the list, returning a new list"
  (setq results '())
  (dolist (i list)
    (push (* i i) results))
  (reverse results))


(defun b-zero (x y)
  "Returns the value for b-zero"
  (setq x-values (copy-sequence x))
  (setq y-values (copy-sequence y))
  (setq b0-top (- (* (-sum y-values) (-sum (squared x-values))) (* (-sum x-values) (-sum (xy-product-calc x-values y-values)))))
  (setq b0-bottom (- (* (length x-values) (-sum (squared x-values))) (* (-sum x-values) (-sum x-values))))
  (/ (float b0-top) (float b0-bottom)))

(defun b-one (x y)
  "Returns the value for b-one"
  (setq x-values (copy-sequence x))
  (setq y-values (copy-sequence y))
  (setq b1-top (- (* (length x-values) (-sum (xy-product-calc x-values y-values))) (* (-sum x-values) (-sum y-values))))
  (setq b1-bottom (- (* (length x-values) (-sum (squared x-values))) (* (-sum x-values) (-sum x-values))))
  (/ (float b1-top) (float b1-bottom)))
