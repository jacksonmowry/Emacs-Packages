;;; custom/emacs-stats.el -*- lexical-binding: t; -*-


(defun emacs-stats ()
  "Main function to interact with the emacs stats program"
  (interactive)
  (switch-to-buffer "emacs-stats")
  (stats-mode)
  (stats-init)
  (setq file (stats-file-picker))
  (setq csv-data (pcsv-parse-file file))
  (clear-screen)
  (stats-print (column-format))
  (setq x-data (list-to-numbers (vertical-csv-parse csv-data (stats-column-picker "x"))))
  (setq y-data (list-to-numbers (vertical-csv-parse csv-data (stats-column-picker "y"))))
  (clear-screen)
  (stats-print (stats-display-options))
  (setq stats-func (read-number "Select a Function: "))
;;  (stats-print (stats-dispatcher))
  (stats-print (emacs-linear-regression x-data y-data))
  )


(define-derived-mode stats-mode special-mode
  "emacs-stats"
  (define-key stats-mode-map (kbd "SPC")
    'stats-mark))

(defun stats-init ()
  "Welcome screen to choose csv file and analysis to do"
  (clear-screen)
  (stats-print "Welcome to emacs statistical analysis!\n")
  (stats-print "Please choose a csv file to get started"))

(defun clear-screen ()
  "Clears the buffer"
  (let ((inhibit-read-only t))
    (erase-buffer)))

(defun list-to-numbers (list-of-strings)
  "Converts a list of Strings to a list of Numbers"
  (setq result '())
  (dolist (i list-of-strings)
    (push (string-to-number i) result))
  result)

(defun stats-print (string)
  "Prints to the stats-mode buffer"
  (let ((inhibit-read-only t))
    (insert string)))

(defun stats-file-picker ()
  "Lets the uder specify a path to the csv file"
  (setq file (read-file-name "CSV File: " "~/Downloads/"))
  file)

(defun column-format ()
  "Displays a formatted view of the first two lines of csv"
  (setq part-one (format "Please use column numbers 1-%s to select x/y data\n\n" (length (car csv-data))))
  (format "%s%s\n%s\n" part-one (nth 0 csv-data) (nth 1 csv-data)))

(defun stats-column-picker (xy)
  "Allows the user to select columns for xy data"
  (read-number (format "Column for %s data: " xy)))

(defun vertical-csv-parse (csv column)
  "Collects an entire column of csv into one list"
  (setq output '())
  (dolist (i csv)
    (push (nth (- column 1) i) output))
  (cdr (reverse output)))

(defun stats-display-options ()
  "Displays options for stat functions"
  (format "Please Choose a Function\n[1] Linear Regression\n[2] ???\n[3] ???\n[4] Coming Soon\n"))

(defun stats-dispatcher ()
  "Allows the user to select which stat function to use"
  (if (eql stats-func 1)
      (emacs-linear-regression x-data y-data)))

(defun emacs-linear-regression (x y)
  "Returns the eqution for the linear regression"
  (interactive)
  (format "y = %s*x + %s" (b-one x y) (b-zero x y)))

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
