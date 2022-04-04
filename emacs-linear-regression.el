;;; custom/emacs-linear-regression.el -*- lexical-binding: t; -*-

(defvar x-values-original '(1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49))
(defvar y-values-original '(160.6
162.2
161.8
161.8
161.6
162
162.8
162.2
162
162.2
162.2
164
164.2
163.8
163.6
164.4
164.6
165.6
165.4
165.6
164.6
165.2
166.4
167.6
168.2
164.8
166
166.4
166
168
167
166.4
166.8
169.6
167.2
166.8
168.2
168.4
169.6
169.4
167.7
169.2
168.6
168.2
167.4
169.2
169
167
169.8))
;;(emacs-linear-regression '(140 155 159 179 192 200 212) '(60 62 67 70 71 72 75))
(defun emacs-linear-regression (x y)
  "Returns the eqution for the linear regression"
  (interactive)
  (message "y = %s*x + %s" (b-one x y) (b-zero x y)))

(emacs-linear-regression x-values-original y-values-original)

(defun xy-product-calc (x y)
  "Calcultes the product of x and y"
  (let ((x-values x) (y-values y))
    (setq xy-product '())
    (setq counter 0)
    (setq length (length x-values))
    (while (< counter length)
      (push (* (pop x-values) (pop y-values)) xy-product)
      (setq counter (1+ counter))))
  xy-product)

(defun squared (list)
  "Calculates the square of each element in the list, returning a new list"
  (setq results '())
  (let ((copy list))
    (dolist (i copy)
      (push (* i i) results)))
  results)

(defun b-zero (x y)
  "Returns the value for b-zero"
  (let ((x-values x) (y-values y))
    (setq b0-top (- (* (-sum y-values) (-sum (squared x-values))) (* (-sum x-values) (-sum (xy-product-calc x-values y-values)))))
    (setq b0-bottom (- (* (length x-values) (-sum (squared x-values))) (* (-sum x-values) (-sum x-values)))))
  (/ (float b0-top) (float b0-bottom)))

(defun b-one (x y)
  "Returns the value for b-one"
  (let ((x-values x) (y-values y))
    (setq b1-top (- (* (length x-values) (-sum (xy-product-calc x-values y-values))) (* (-sum x-values) (-sum y-values))))
    (setq b1-bottom (- (* (length x-values) (-sum (squared x-values))) (* (-sum x-values) (-sum x-values)))))
  (/ (float b1-top) (float b1-bottom)))
