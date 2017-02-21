;;;
;;; Org Mode
;;;

;; Autoloads functions that are located in files not immediately loaded
;; when Org-mode starts
(require 'org-install)

;; Automatically load Org-mode for files that end with .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; Keybindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; When closing a TODO item, prompt for a closing note
(setq org-log-done 'note)
(setq org-agenda-files (list "~/org/tasks.org" "~/org/tasks.org_archive" "~/org/refile.org"))
(setq org-clock-persist 'history)

;; Additional settings for Capture mode
(setq org-default-notes-file "~/org/refile.org")
;; Capture templates for: TODO tasks, Notes, appointments, and
;; org-protocol
(setq org-capture-templates
    (quote (("t" "todo" entry (file "~/org/refile.org")
             "* TODO %?\n%U\n%a\n %i" :clock-in t :clock-resume t)
            ("n" "note" entry (file "~/org/refile.org")
             "* %? :NOTE:\n%U\n%a\n %i" :clock-in t :clock-resume t)
            ("j" "Journal" entry (file+datetree "~/git/org/diary.org")
             "* %?\n%U\n  %i" :clock-in t :clock-resume t)
            ("w" "org-protocol" entry (file "~/git/org/refile.org")
             "* TODO Review %c\n%U\n  %i" :immediate-finish t)
            ("p" "Phone call" entry (file "~/git/org/refile.org")
             "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
            ("h" "Habit" entry (file "~/git/org/refile.org")
             "* NEXT %?\n%U\n%a\nSCHEDULED: %t .+1d/3d\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n  %i"))))
;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

;; For refiling
; Targets include this file and any file contributing to the agenda - up to 2 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 3)
                                 (org-agenda-files :maxlevel . 3))))
; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

;; Keep clock persisten across program restart
(org-clock-persistence-insinuate)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)

;;;
;;; Emacs specific
;;;
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;;
;;; Ledger
;;;
;;;(load "ledger")
