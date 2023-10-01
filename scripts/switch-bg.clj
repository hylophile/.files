#!/usr/bin/env bb
(require '[babashka.fs :as fs])
(require '[clojure.string :as str])
(require '[cheshire.core :as json])
(require '[clojure.java.io :as io])
(require '[babashka.process :refer [process shell]])
(require '[utils.sway :as sway])

(def wallpapers-path (let [laptop-path (str (System/getenv "HOME") "/wallpapers/all/")
                           tower-path "/media/wallpapers/all/"]
                       (if (fs/directory? laptop-path)
                         laptop-path
                         tower-path)))

(def wallpapers-config (str (System/getenv "HOME") "/sync/wallpapers.json"))

(def wallpaper-data (->>  wallpapers-config
                          (io/reader)
                          (json/parse-stream)
                          (into [])))

(def candidate-ids (->> wallpaper-data
                        (map-indexed vector)
                        (filter #(and (not ((second %) "used"))
                                      (not ((second %) "discarded"))))
                        (map first)
                        (shuffle)))

(defn id->name [id]
  (as-> wallpaper-data $
    (nth $ id)
    ($ "name")))

(defn replace-swaybg-on-output [output id]
  (shell {:continue true} (format "pkill -f 'swaybg --output %s'"
                                  output))
  (process (format "swaybg --output %s --mode fill --image %s"
                   output
                   (str wallpapers-path (id->name id)))))

(defn set-keys-for-ids [wallpapers ids & {:keys [used discarded] :or {used true discarded false}}]
  (let [set-key-val (fn [wss idx k v]
                      (update-in wss [idx k] (constantly v)))]
    (as-> wallpapers $
      (reduce #(set-key-val %1 %2 "used" used) $ ids)
      (reduce #(set-key-val %1 %2 "discarded" discarded) $ ids))))

(defn write-config [wallpapers]
  (json/generate-stream wallpapers (io/writer wallpapers-config))
  wallpapers)

(defn new-wallpapers-on-outputs [wallpapers outputs]
  (if-let [output-id-pairs (seq (zipmap outputs candidate-ids))]
    (do
      (doseq [[output id] output-id-pairs]
        (replace-swaybg-on-output output id)
        (process (format "notify-send 'New wallpaper on %s' '%s'" output (id->name id))))
      (write-config (set-keys-for-ids wallpapers (map second output-id-pairs))))
    (process "notify-send --urgency=critical 'EOW' 'End of wallpapers'")))

(defn discard-on-output [wallpapers output]
  (let [filename (-> (shell {:out :string} (format "pgrep -af 'swaybg --output %s'" output))
                     :out
                     str/trim
                     (str/split #"/")
                     last)
        id (-> (map #(% "name") wallpapers)
               (zipmap (range))
               (get filename))]
    (process (format "notify-send 'Discarded wallpaper on %s' '%s'" output filename))
    (set-keys-for-ids wallpapers [id] :discarded true)))

(let [{current-output :current all-outputs :names} (sway/outputs)
      help (fn [] (println (str "Available commands:\n"
                                "  new all\n"
                                "  new current\n"
                                "\n"
                                "  discard current\n"
                                "\n"
                                "  reset-used")))]
  (condp = (first *command-line-args*)
    "new" (condp = (second *command-line-args*)
            "all" (new-wallpapers-on-outputs wallpaper-data all-outputs)
            "current" (new-wallpapers-on-outputs wallpaper-data [current-output])
            (help))
    "discard" (condp = (second *command-line-args*)
                "current" (-> wallpaper-data
                              (discard-on-output current-output)
                              (new-wallpapers-on-outputs [current-output])
                              (write-config))
                (help))
    "reset-used" (-> wallpaper-data
                     (set-keys-for-ids (range (count wallpaper-data)) :used false)
                     write-config)
    (help)))



