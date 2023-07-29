#!/usr/bin/env bb

(require '[babashka.process :refer [process shell]])

(when-not (->> "swaymsg '[app_id=\"^emacs$\"]' focus" 
              (shell {:continue true})
              :exit
              zero?)
  (process "emacs"))
