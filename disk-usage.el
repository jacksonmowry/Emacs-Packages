;;; custom/disk-usage.el -*- lexical-binding: t; -*-

(defun edf ()
  "Displays usage of specified mount point"
  (interactive)
  (df-dir)
  (edf-df)
  (edf-output))


(defun df-dir ()
  "Select a directory for edf"
  (interactive)
  (setq edf-mnt (read-directory-name "Disk Usage of: " "/")))

(defun edf-df ()
  "Runs df async"
  (setq edf-output-string (shell-command-to-string (format "df -hl %s | awk 'NR== 2{print $5}'" df-mnt))))

(defun edf-output ()
  "Outputs specified disk usage as a percentage"
  (message "Disk: %s | Usage: %s" edf-mnt edf-output-string))
