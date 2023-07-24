#!/usr/bin/env bb

(ns utils.sway)

(require '[cheshire.core :as json])
(require '[clojure.string :as str])
(require '[clojure.core.match :refer [match]])
(require '[babashka.process :refer [shell]])

(defn msg [& args]
  (->> args
       (cons "swaymsg")
       (str/join " ")
       (shell {:out :string})
       :out
       (json/parse-string)))

(defn outputs [& args]
  (let [outputs-json (msg "-t get_outputs")]
    (match (first args)
      'current (as-> outputs-json $
                 (filter #(% "focused") $)
                 (first $)
                 ($ "name"))
      'names (map #(% "name") outputs-json)
      :else "Unknown argument provided.")))

; (pprint (swaymsg-outputs 'names))

(defn workspaces [& args]
  (let [outputs-json (msg "-t get_workspaces")
        option (first args)]
    (cond
    ; (= option 'current) (as-> outputs-json $
    ;                       (filter #(% "focused") $)
    ;                       (first $)
    ;                       ($ "name"))
    ;                               
      (= option 'nums) (map #(% "num") outputs-json)
      :else "Unknown argument provided.")))

()
; (pprint (swaymsg-workspaces 'nums))
