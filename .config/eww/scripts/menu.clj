#!/usr/bin/env bb
(require '[babashka.process :refer [process shell]])
(require '[cheshire.core :as json])

(defn zoom [output] 
  (as-> (shell {:out :string} "swaymsg -t get_outputs") $
        (:out $) 
        (json/parse-string $ true)
        (filter #(= output (:name %)) $)
        (first $)
        (:scale $)
        [output (if (< $ 1.75)
                  (* 2 $)
                  (/ $ 2))]))

(defn gamma []
  (if (-> (shell {:continue :true} "pgrep gammastep") :exit (= 0))
    (shell "pkill gammastep")
    (process "gammastep")))

(def menu-items {:rofi ["rofi -show-icons -combi-modi window#drun -show combi"]
                 :zoom ["sh -c 'swaymsg output %s scale %s && eww reload'" zoom]
                 :gamma ["echo side-effect" gamma]
                 :keyboard ["sh -c 'kill -s 34 $(pidof wvkbd-mobintl) && eww reload'"]
                 :next-output ["swaymsg focus output left"]})


(shell {:continue :true} "eww close menu-0 menu-1")

(let [[cmd & args] *command-line-args*
      [cmd func] (->> cmd keyword (get menu-items))]
 (shell (apply format cmd (if func (apply func args)
                                   args))))


