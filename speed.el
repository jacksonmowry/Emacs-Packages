;;; Emacs-Packages/speed.el -*- lexical-binding: t; -*-
(defmacro measure-time (&rest body)
  "measure the time it take to evaluate body."
  `(let ((time (current-time)))
     ,@body
     (message "%.06f" (float-time (time-since time)))))
;; (measure-time (command))
