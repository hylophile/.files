#!/usr/bin/env bb

(require '[utils.sway :as sway])
(require '[babashka.process :refer [shell]])

(let [initial-output (:current (sway/outputs))]
  (doseq [ws (:nums (sway/workspaces))]
    (shell (format "swaymsg 'workspace --no-auto-back-and-forth %s'" ws))
    (shell (format "swaymsg move workspace to output %s" (:next (sway/outputs)))))
  (shell (format "swaymsg focus output %s" initial-output)))
