#!/usr/bin/env bb

(require '[babashka.http-client :as http])
(require '[cheshire.core :as json])


(def temperature (-> (http/get "https://api.brightsky.dev/current_weather?lat=52.52&lon=13.29")
                     :body
                     (json/parse-string true)
                     :weather
                     :temperature))

(println (str (if (> temperature 0) "+" "-") temperature "°C"))

