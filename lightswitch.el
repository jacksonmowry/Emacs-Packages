;;; custom/lightswitch.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Description
;;; Code:

(defvar lightswitch-light-theme 'doom-one-light
  "The user's specified light theme.")
(defvar lightswitch-dark-theme 'doom-one
  "The user's spcified dark theme.")

(defun lightswitch-toggle ()
  "Change between light and dark themes."
  (interactive)
  (if (equal doom-theme lightswitch-dark-theme)
      (load-theme lightswitch-light-theme)
    (load-theme lightswitch-dark-theme)))


(provide 'lightswitch)
;;; lightswitch.el ends here
