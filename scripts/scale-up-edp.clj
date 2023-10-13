#!/usr/bin/env bb

(require '[utils.sway :as sway])

(let [outputs (-> (sway/outputs) :names)]
   (when (some #(= "eDP-1" %) outputs)
       (sway/msg (format "output eDP-1 scale %s"
                         (if (= (count outputs) 3) "1.5" "1")))))
