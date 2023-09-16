#!/usr/bin/env bb
(require '[babashka.process :as p :refer [shell process destroy-tree]]
         '[clojure.java.io :as io])

(def window-stream
  (process
   {:err :inherit
    :shutdown destroy-tree}
   (str "swaymsg -t subscribe -m \"['window']\"")))

(with-open [rdr (io/reader (:out window-stream))]
  (binding [*in* rdr]
    (loop []
      (when-let [line (-> (read-line) (json/parse-string true))]
          ;; (println line)
          ;; (println)
          (when (or (= (:change line) "focus")
                    (= (:change line) "title")
                    (= (:change line) "floating"))
              (let [container (:container line)
                    name (:name container)
                    app-id (:app_id container)]
               (if (or (= (:type container) "floating_con")
                       (= app-id "neovide")
                       (= app-id "emacs")
                       (= app-id "org.wezfurlong.wezterm")
                       (and
                           (= app-id "firefoxdeveloperedition")
                           (str/includes? name "YouTube")))
                 (shell "swaymsg opacity set 1.0")
                 (shell "swaymsg opacity set 0.95"))))
        (recur)))))
