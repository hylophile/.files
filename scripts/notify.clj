#!/usr/bin/env bb
(require '[babashka.process :as p :refer [shell process destroy-tree]]
         '[clojure.java.io :as io])

(def workspace-stream
  (process
   {:err :inherit
    :shutdown destroy-tree}
   (str "swaymsg -t subscribe -m \"['window']\"")))

(defn process-window [window]
  (let [container (:container window)]
    (when (some-> container :name (str/includes? "(1)"))
      (println (format "Enabling urgent for '%s'" (:name container)))
      (shell (format "swaymsg [con_id=%s] urgent enable" (:id container))))))

(with-open [rdr (io/reader (:out workspace-stream))]
  (binding [*in* rdr]
    (loop []
      (when-let [line (-> (read-line) (json/parse-string true))]
        (process-window line)
        (recur)))))
