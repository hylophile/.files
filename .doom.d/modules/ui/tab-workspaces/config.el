;;; ui/tab-workspaces/config.el -*- lexical-binding: t; -*-

;; TODO: find the correct doom hook
(use-package tabspaces
  :hook (after-init . tabspaces-mode)
  :init (setq tabspaces-keymap-prefix "C-c TAB")
  :config (when (modulep! :editor evil)
            (map! :leader
                  :desc "Tab workspaces" "TAB" tabspaces-command-map))
  (define-key tabspaces-command-map (kbd "O") #'tabspaces-project-switch-project-open-file)
  :custom
  (tabspaces-use-filtered-buffers-as-default t)
  (tabspaces-default-tab "Main")
  (tabspaces-remove-to-default t)
  (tabspaces-include-buffers '("*scratch*")))

(when (modulep! :completion vertico)
  (with-eval-after-load 'consult
    ;; hide full buffer list (still available with "b" prefix)
    (consult-customize consult--source-buffer :hidden t :default nil)
    ;; set consult-workspace buffer list
    (defvar consult--source-workspace
      (list :name     "Workspace Buffers"
            :narrow   ?w
            :history  'buffer-name-history
            :category 'buffer
            :state    #'consult--buffer-state
            :default  t
            :items    (lambda () (consult--buffer-query
                             :predicate #'tabspaces--local-buffer-p
                             :sort 'visibility
                             :as #'buffer-name)))

      "Set workspace buffer list for consult-buffer.")
    (add-to-list 'consult-buffer-sources 'consult--source-workspace)))

(when (modulep! :completion ivy)
  (defun tabspaces-ivy-switch-buffer (buffer)
    "Display the local buffer BUFFER in the selected window.
This is the frame/tab-local equivilant to `switch-to-buffer'."
    (interactive
     (list
      (let ((blst (mapcar #'buffer-name (tabspaces-buffer-list))))
        (read-buffer
         "Switch to local buffer: " blst nil
         (lambda (b) (member (if (stringp b) b (car b)) blst))))))
    (ivy-switch-buffer buffer)))

;; Advising tab-bar.el to apply emacs commit eef6626b55e59d4a76e8666108cc68a578fac793
;;
;; Without this advice, tabspaces-switch-or-create-workspace cannot create
;; a new workspace

(defadvice! doom-tab-workspaces--upstream-tab-bar-switch-to-tab-a (orig-fn name)
  "Switch to the tab by NAME.
Default values are tab names sorted by recency, so you can use \
\\<minibuffer-local-map>\\[next-history-element]
to get the name of the most recently visited tab, the second
most recent, and so on.
When the tab with that NAME doesn't exist, create a new tab
and rename it to NAME."
  :around #'tab-bar-switch-to-tab
  (interactive
   (let* ((recent-tabs (mapcar (lambda (tab)
                                 (alist-get 'name tab))
                               (tab-bar--tabs-recent))))
     (list (completing-read (format-prompt "Switch to tab by name"
                                           (car recent-tabs))
                            recent-tabs nil nil nil nil recent-tabs))))
  (let ((tab-index (tab-bar--tab-index-by-name name)))
    (if tab-index
        (tab-bar-select-tab (1+ tab-index))
      (tab-bar-new-tab)
      (tab-bar-rename-tab name))))
