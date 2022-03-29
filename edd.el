;;; custom/edd.el -*- lexical-binding: t; -*-

(defun edd ()
  "Simple dd interface within emacs"
  (interactive)
  (switch-to-buffer "edd")
  (edd-mode)
  (edd-init))

(define-derived-mode edd-mode special-mode
  "emacs dd tool")

(defun edd-init ()
  "Display device list from lsblk"
  (edd-print-devices)
  (edd-output-path)
  (edd-input-path)
  (edd-print-args)
  (edd-test-dd)
  (edd-confirm-command)
  (edd-dd))

(defun edd-print-devices ()
       (let ((inhibit-read-only t))
         (erase-buffer)
         (edd-print (format "%s" (shell-command-to-string "lsblk")))))

(defun edd-output-path ()
    "Command to set the output file for dd"
  (interactive)
  (setq output-path (read-file-name "Output Device Path: " "/dev/")))

(defun edd-input-path ()
  "Command to select the iso file for dd"
  (interactive)
  (setq input-path (read-file-name "Input ISO File: " "~/Downloads/")))


(defun edd-print-args ()
    "Will print the if/of args passed to edd"
      (edd-print (format "\nOutput Device Path: %s\n" output-path))
      (edd-print (format "Input ISO File: %s\n" input-path)))

(defun edd-test-dd ()
  "Replace this later when dd gets implemented"
  (edd-print (format "\ndd if=%s of=%s status=progress\n" input-path output-path)))

(defun edd-dd ()
  "Runs dd with user specified paths"
  (async-shell-command (format "sudo dd if=%s of=%s status=progress" input-path output-path) "edd")
  (setq proc (get-buffer-process "edd"))
  (if (process-live-p proc)
      ()
    (message "dd complete!")))

(defun edd-confirm-command ()
  "Asks the user to confirm the exact dd command to be run"
  (if (y-or-n-p "Is the above command correct?")
      (edd-print "\ndd starting")
    (progn
      (edd-print "\ndd aborting")
      (error "Please Try Again"))))

(defun edd-print (string)
  "Prints to the edd buffer with each string passed"
  (let ((inhibit-read-only t))
    (insert string)))
