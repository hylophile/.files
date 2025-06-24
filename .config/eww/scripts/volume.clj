#!/usr/bin/env bb
(require '[babashka.process :refer [process shell destroy-tree]]
         '[cheshire.core :as json]
         '[clojure.java.io :as io]
         '[clojure.string :as str])

(defn cmd [cmd]
  (->> cmd
       (shell {:out :string})
       :out
       str/split-lines
       first))

(defn sink-status []
  (cmd "wpctl get-volume @DEFAULT_AUDIO_SINK@"))

(defn source-status []
  (cmd "wpctl get-volume @DEFAULT_AUDIO_SOURCE@"))

(defn status->volume [status]
  (let [[_ volume muted] (str/split status #" ")]
    (if (nil? muted)
      (-> volume
          parse-double
          (* 100)
          int)
      -1)))

(try
  (let [source (first *command-line-args*)
        volume (-> *command-line-args* second parse-long)]
    (when (and source volume (> volume 0.0))
      (println
       (format
        "wpctl set-volume -l 1.0 %s %.2f"
        source
        (/ volume 100.0)))
      (shell
       (format
        "wpctl set-volume -l 1.0 %s %.2f "
        source
        (/ volume 100.0))))
    (System/exit 0))
  (catch Exception _))


(defn volume-status []
  (-> (try
        {:error false
         :sink (status->volume (sink-status))
         :source (status->volume (source-status))
         :source_is_mic (-> (shell {:out :string} "wpctl inspect @DEFAULT_AUDIO_SOURCE@")
                            :out
                            (str/includes? "source"))
         :bt (-> (shell {:out :string} "wpctl inspect @DEFAULT_AUDIO_SINK@")
                 :out
                 (str/includes? "bluez"))}
        (catch Exception _ {:error true}))
      json/generate-string
      println))

(volume-status)

(def pipewire-stream
  (process
   {:err :inherit
    :shutdown destroy-tree}
   (str "pw-mon")))

(def last-event-time (atom 0))
(def debounce-delay 0)

(defn debounce-volume-status []
  (let [now (System/currentTimeMillis)]
    (future
      (Thread/sleep debounce-delay)
      (when (>= (- (System/currentTimeMillis) @last-event-time) debounce-delay)
        (volume-status)))))

(with-open [rdr (io/reader (:out pipewire-stream))]
  (binding [*in* rdr]
    (loop []
      (when-let [line (read-line)]
        (when (str/includes? line "changed")
          (reset! last-event-time (System/currentTimeMillis))
          (debounce-volume-status))
        (recur)))))
