
(map! :ni "C-+" #'doom/increase-font-size)
(map! :ni "C-=" #'doom/reset-font-size)
(map! :ni "C--" #'doom/decrease-font-size)

(map! :leader
      :desc "Magit push"
      "g p" #'magit-push)

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

(map! :leader "TAB p" #'+workspace/other)
