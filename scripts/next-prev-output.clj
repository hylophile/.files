#!/usr/bin/env bb

(require '[utils.sway :as sway])

(let [focus (fn [x] (sway/msg "focus output" x))]
    (condp = (first *command-line-args*)
      "next" (focus (:next (sway/outputs))) 
      "prev" (focus (:prev (sway/outputs)))
      (do (println "Available commands:\n  next\n  prev")
          (System/exit 1))))   


