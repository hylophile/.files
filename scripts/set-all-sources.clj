#!/usr/bin/env bb

(require '[babashka.process :refer [shell]])
(require '[clojure.string :as str])

(def source-ids 
  (as-> (shell {:out :string} "pactl list sources short") $
    (:out $)
    (str/split $ #"\n")
    (map #(str/split % #"\t") $)
    (map first $)))

(def is-default-source-muted 
  (as-> (shell {:out :string} "pactl get-source-mute @DEFAULT_SOURCE@") $
    (:out $)
    (str/includes? $ "Mute: yes")))

(defn set-sources-mute [state]
  (doseq [source source-ids]
    (shell (format "pactl set-source-mute %s %s" 
                   source 
                   (if (true? state) "on" "off")))))

(condp = (first *command-line-args*)
  "mute" (set-sources-mute true)
  "unmute" (set-sources-mute false)
  "toggle-mute" (set-sources-mute (not is-default-source-muted))
  (println "Available commands:\n  mute\n  unmute\n  toggle-mute"))

