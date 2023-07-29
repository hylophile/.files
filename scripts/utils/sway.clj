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
  (let [outputs-json (msg "-t get_outputs")
        current (as-> outputs-json $
                  (filter #(% "focused") $)
                  (first $)
                  ($ "name"))
        names (map #(% "name") outputs-json)
        outputs-list (->> names
                          (repeat 2)
                          flatten)
        succ (fn [xs] (second (drop-while #(not= current %) xs)))
        next (-> outputs-list succ)
        prev (-> outputs-list reverse succ)]
    (condp = (first args)
      'current current
      'names names
      'next next
      'prev prev
      "Unknown argument provided.")))

; (pprint (swaymsg-outputs 'names))

(defn workspaces [& args]
  (let [outputs-json (msg "-t get_workspaces")]
    (condp = (first args)
      'current (as-> outputs-json $
                 (filter #(% "focused") $)
                 (first $)
                 ($ "name"))
      'nums (map #(% "num") outputs-json)
      'visible-nums (->> outputs-json
                         (filter #(% "visible"))
                         (map #(% "num")))
      "Unknown argument provided.")))

; (print (workspaces 'visible-nums))


