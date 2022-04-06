;;; Emacs-Packages/csv-stat-analysis.el -*- lexical-binding: t; -*-




(setq csv-output (pcsv-parse-buffer "insurance.csv"))
(setq waiting (format "%s" (car csv-output)))
(setq enter-to-cont (read-string waiting))
(setq x-column (read-number "Which column represents the x data: "))
(setq y-column (read-number "Which column represents the y data: "))

(setq x-data (vertical-csv-parse csv-output x-column))
(setq y-data (vertical-csv-parse csv-output y-column))

(defun vertical-csv-parse (csv column)
  "Collects an entire column of csv into one list"
  (setq output '())
  (dolist (i csv)
    (push (nth (- column 1) i) output))
  (cdr (reverse output)))

;; choose a csv file
;; choose x/y column
;; choose statistical analysis program
;; BOOM results
