;;; Emacs-Packages/csv-stat-analysis.el -*- lexical-binding: t; -*-


(setq csv-output (pcsv-parse-buffer "insurance.csv"))
(car csv-output)
(setq x-column (read-number "Which column represents the x data: "))
(setq y-column (read-number "Which column represents the y data: "))
(setq x-data '())
(dolist (i csv-output)
        (push (nth (- x-column 1) i) x-data))
(message "%s" x-data)

;; choose a csv file
;; choose x/y column
;; choose statistical analysis program
;; BOOM results
