#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]])
(require '[clojure.pprint :refer [pprint]])

(defn subshell [cmd]
  (:out (sh "sh" "-c" cmd)))


; (pprint (type(first (take 1 a))))
;
; ; (pprint (get a "window"))o
;
; (as-> a v
;      (map #(select-keys % ["name","focused"]) v)
;      (filter #(get % "focused") v)
;      (first v)
;      (get v "name")
;      (pprint v))
;      
;
; (as-> a $
;      (filter #(% "focused") $)
;      (first $)
;      ($ "name")
;      (pprint $))
;

(defn process-optional-argument [& args]
  (def sway-outputs (json/parse-string (subshell "swaymsg -t get_outputs")))
  (def a 32)
  (def option (first args))
  (cond
   (= option 'foo) a
   (= option 'bar) "You provided the 'bar' symbol."
   :else "Unknown symbol provided."))

(pprint (process-optional-argument 'foo))
