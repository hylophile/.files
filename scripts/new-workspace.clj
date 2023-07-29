#!/usr/bin/env bb

(require '[utils.sway :as sway])

(def new-workspace (as-> (range 1 20) $
                     (remove (set (sway/workspaces 'nums)) $)
                     (first $)))

(condp = (first *command-line-args*)
  "focus" (sway/msg "workspace" new-workspace)
  "move-to" (sway/msg "move container to workspace number" new-workspace)
  :else (do (prn "Available commands:\n  focus\n  move-to")
            (System/exit 1)))

