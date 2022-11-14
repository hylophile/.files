#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]])
(require '[clojure.pprint :refer [pprint]])

(defn subshell [cmd]
  (:out (sh "sh" "-c" cmd)))

(let [all-outputs (str/split-lines (subshell "swaymsg -t get_outputs | jq -r '.[] | .name'"))
      current-output (str/trim (subshell  "swaymsg -t get_outputs | jq -r '.[] | select(.focused==true).name'"))
      a (vec (concat all-outputs all-outputs))
      next (nth a (+ 1 (.indexOf a current-output)))
      ra (vec (rseq a))
      prev (nth ra (+ 1 (.indexOf ra current-output)))
      param (first *command-line-args*)]
  (cond
    (= param "next") (subshell (str "swaymsg focus output " next))
    (= param "prev") (subshell (str "swaymsg focus output " prev))
    :else (pprint "fail")))

;; (defn is-connected [name]
;;   "Given a NAME, check if the display is connected"
;;   (< 0 (count (->> (str/split-lines (:out (sh "xrandr")))
;;                    (filter #(.contains %1 (format "%s connected" name)))))))

;; (let* (
;;        ;; (all-outputs-str (subshell "swaymsg -t get_outputs | jq -r '.[] | .name'"))
;;        ;; (all-outputs (string-split all-outputs-str #\newline))
;;        ;; (current-output (subshell "swaymsg -t get_outputs | jq -r '.[] | select(.focused==true).name'"))
;;        (params (cdr (command-line))))
;;   (when (null? params)
;;     (println "No params given (use 'next' or 'prev'). Exiting")
;;     (exit 1))
;;   (cond
;;     ; is there a more elegant way, something like (safe-cadr (command-line))?
;;     ;; ((equal? (car params) "next") (swaymsg-focus-output (next-output all-outputs current-output)))
;;     ;; ((equal? (car params) "prev") (swaymsg-focus-output (prev-output all-outputs current-output)))
;;     ; why does (#t) not work here?
;;     ((eq? #t #t) (println "Invalid parameter. Use 'next' or 'prev'."))))

;; (let [monitor-config [{:name "eDP-1" :primary true :resolution [1920 1080]}
;;                       {:name "DP-2" :primary false :resolution [2560 1440]}
;;                       {:name "DP-3" :primary false :resolution [2560 1080]}]
;;       displays (for [cfg monitor-config]
;;             (if (is-connected (:name cfg))
;;               (list
;;                "--output"
;;                (:name cfg)
;;                (when (:primary cfg) "--primary")
;;                "--mode"
;;                (format "%dx%d" (first (:resolution cfg)) (second (:resolution cfg)))
;;                "--pos"
;;                (format "%dx0" (reduce
;;                                       #(+ %1 (first (:resolution %2)))
;;                                       0
;;                                       (take-while #(not= % cfg) monitor-config))))
;;               (list
;;                "--output"
;;                (:name cfg)
;;                "--off")))
;;       cmd (cons "xrandr" (remove nil? (flatten displays)))]
;;   (apply sh cmd)
;;   (pprint (str/join " " cmd)))
