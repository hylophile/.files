
(map! :ni "C-+" #'doom/increase-font-size)
(map! :ni "C-=" #'doom/reset-font-size)
(map! :ni "C--" #'doom/decrease-font-size)

(map! :leader
      :desc "Magit push"
      "g p" #'magit-push)

;; home row : nrtd
;; remapping
;;   n[ext]    to l[ook] (ahead/back)
;;   r[eplace] to j
;;   t[ill]    to h
;;   d[elete]  to k[ill],
;; (map! :after evil
;;       :nv "n" #'evil-backward-char
;;       :nv "r" #'evil-next-line
;;       :nv "t" #'evil-previous-line
;;       :nv "d" #'evil-forward-char

;;       :n  "R" #'evil-join
;;       :nv "l" #'evil-ex-search-next
;;       :nv "L" #'evil-ex-search-previous
;;       :nv "j" #'evil-replace
;;       :nv "h" #'evil-snipe-t
;;       :nv "k" #'evil-delete)

;; (map! :map magit-mode-map
;;       :after magit
;;       :n "r" #'magit-next-line
;;       :n "t" #'magit-previous-line
;;       :n "j" #'magit-rebase
;;       :n "k" #'magit-tag)

;; (setq flycheck-indication-mode 'right-fringe)
;; (setq-default right-margin-width 1)

;; (setq-default right-fringe-width 20)

;;     (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
;;       [16 48 112 240 112 48 16] nil nil 'center)

;; 0001 0000
;; 0011 0000
;; 1111 0000
;; 0011 0000
;; 0001 0000


(setq avy-keys '(?t ?n ?s ?e ?r ?i ?a ?o ?d ?h ?f ?u ?p ?l ?w ?y ?c ?, ?x ?. ?g ?m ?v ?k))

(map! :leader
      "|" #'+popup/raise)

(defun insert-primary ()
  (interactive)
  (insert-for-yank (gui-get-primary-selection)))

;; (map! :nv "s" #'avy-goto-char-2)

(map! :niv "<269025133>" #'insert-primary)

(map! :map evil-window-map
      "n" #'evil-window-left
      "r" #'evil-window-down
      "t" #'evil-window-up
      "d" #'evil-window-right

      "S-n" #'+evil/window-move-left
      "S-r" #'+evil/window-move-down
      "S-t" #'+evil/window-move-up
      "S-d" #'+evil/window-move-right

      ;; "n" #'evil-window-new
      ;; "r" #'evil-window-rotate-downwards
      ;; "R" #'evil-window-rotate-upwards
      ;; "t" #'evil-window-top-left
      ;; "T" #'tear-off-window
      ;; "k" #'+workspace/close-window-or-workspace

      "k" #'evil-window-delete

      "v" #'+evil/window-vsplit-and-follow
      "V" #'evil-window-vsplit
      "h" #'+evil/window-split-and-follow
      "H" #'evil-window-split
      "C-h" nil
      "j" nil
      "J" nil
      "C-j" nil
      "k" nil
      "K" nil
      "C-k" nil
      "l" nil
      "L" nil
      "C-l" nil
      "s" nil
      "S" nil
      "C-s" nil)

;; (map! :map org-mode-map
;;       :after org
;;       :localleader
;;       "a" #'org-archive-subtree
;;       )
;;       ;; (:prefix ("A" . "attachments")
;;       ;;  "a" #'org-attach
;;       ;;  "d" #'org-attach-delete-one
;;       ;;  "D" #'org-attach-delete-all
;;       ;;  "f" #'+org/find-file-in-attachments
;;       ;;  "l" #'+org/attach-file-and-insert-link
;;       ;;  "n" #'org-attach-new
;;       ;;  "o" #'org-attach-open
;;       ;;  "O" #'org-attach-open-in-emacs
;;       ;;  "r" #'org-attach-reveal
;;       ;;  "R" #'org-attach-reveal-in-emacs
;;       ;;  "u" #'org-attach-url
;;       ;;  "s" #'org-attach-set-directory
;;       ;;  "S" #'org-attach-sync
;;       ;;  (:when (featurep! +dragndrop)
;;       ;;   "c" #'org-download-screenshot
;;       ;;   "p" #'org-download-clipboard
;;       ;;   "P" #'org-download-yank))

(map! :leader "TAB p" #'+workspace/other)
