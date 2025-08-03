#!/usr/bin/env bb

(ns utils.sway)

(require '[cheshire.core :as json])
(require '[clojure.string :as str])
(require '[babashka.process :refer [shell]])

(defn msg [& args]
  (->> args
       (cons "swaymsg")
       (str/join " ")
       (shell {:out :string})
       :out
       (json/parse-string)))

(defn outputs []
  (let [outputs-json (msg "-t get_outputs")
        current (as-> outputs-json $
                  (filter #(% "focused") $)
                  (first $)
                  ($ "name"))
        names (as-> outputs-json $
                (filter #(% "active") $)
                (map #(% "name") $))
        outputs-list (->> names
                          (repeat 2)
                          flatten)
        succ (fn [xs] (second (drop-while #(not= current %) xs)))
        next (-> outputs-list succ)
        prev (-> outputs-list reverse succ)]
      {:current current
       :names names
       :next next
       :prev prev}))

(defn workspaces []
  (let [outputs-json (msg "-t get_workspaces")]
    {:current (as-> outputs-json $
                (filter #(% "focused") $)
                (first $)
                ($ "name"))
     :nums (map #(% "num") outputs-json)
     :visible-nums (->> outputs-json
                        (filter #(% "visible"))
                        (map #(% "num")))}))

(printf (str(outputs)))
