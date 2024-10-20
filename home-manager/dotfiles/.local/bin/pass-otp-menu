#!/usr/bin/env bb
(require '[babashka.process :refer [process shell]])
(require '[clojure.string :as str])

(def home-path (System/getenv "HOME"))
(def pass-path (str home-path "/.password-store"))

(def pass-files
  (->> (shell {:dir pass-path :out :string}
              "find . -type f -name \"*.gpg\"")
       :out
       str/split-lines))

(def pass-otp-entries
  (->> pass-files
       (map #(subs % 2 (- (count %) 4)))
       (filter #(str/starts-with? % "otp"))))

(def chosen-otp-entry
  (->> (shell
         {:in (str/join "\n" pass-otp-entries) :out :string}
         "dmenu")
       :out
       str/trim))

(shell ["pass otp -c" chosen-otp-entry])
