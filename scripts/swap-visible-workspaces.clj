#!/usr/bin/env bb

(require '[utils.sway :as sway])
(require '[babashka.process :refer [shell]])

(let [initial-output (sway/outputs 'current)]
  (doseq [ws (sway/workspaces 'visible-nums)]
    (shell (format "swaymsg 'workspace --no-auto-back-and-forth %s'" ws))
    (shell (format "swaymsg move workspace to output %s" (sway/outputs 'next))))
  (shell (format "swaymsg focus output %s" initial-output)))
