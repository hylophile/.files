#!/usr/bin/env bb

(require '[utils.sway :as sway])

(let [outputs (->> (sway/outputs 'names)
                   (repeat 2)
                   flatten)
      current (sway/outputs 'current)
      succ (fn [xs] (second (drop-while #(not= current %) xs)))
      focus (fn [x] (sway/msg "focus output" x))]
    (condp = (first *command-line-args*)
      "next" (-> outputs succ focus)
      "prev" (-> outputs reverse succ focus)
      (do (println "Available commands:\n  next\n  prev")
          (System/exit 1))))   


