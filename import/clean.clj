(ns recipe-cleaner.core
  (:require [clojure.java.io :as io]
            [clojure.string :as s]))

(def directory (io/file "/Users/ding0057/home/from_goulash_to_gourmet/recipes/"))
(def files (rest (file-seq directory)))

(defn defractionize [recipe]
  (-> (s/replace recipe "½" "1/2")
      (s/replace "⅓" "1/3")
      (s/replace "¼" "1/4")))

(defn collapse-spaces [recipe]
  (s/replace recipe #"(\.)\ {2,}([A-Z])" "$1 $2"))

(defn hynphenate-inches [recipe]
  (s/replace recipe #"(\d+) inch(?!es)" "$1-inch"))

(defn spell-by [recipe]
  (s/replace recipe #"(\d+) x (\d+)" "$1 by $2"))

(defn expand-cups [recipe]
  (-> (s/replace recipe #"([2-]+) C\.? " "$1 cups ")
      (s/replace #"1 C\.? " "1 cup ")))

(defn expand-teaspoons [recipe]
  (-> (s/replace recipe #"([2-]+) tsp\.? " "$1 teaspoons ")
      (s/replace #"1 tsp\.? " "1 teaspoon ")))

(defn expand-tablespoons [recipe]
  (-> (s/replace recipe #"([2-]+) T\.? " "$1 tablespoons ")
      (s/replace #"1 T\.? " "1 tablespoon ")))

(defn expand-measures [recipe]
  (-> (expand-tablespoons recipe)
      expand-cups
      expand-teaspoons))

(defn qualify-degrees [recipe]
  (s/replace recipe #"(\d+) degrees" "$1°F"))

(defn expand-abbr [recipe]
  (-> (s/replace recipe "med." "medium")
      (s/replace "pkg." "package")
      (s/replace "pkgs." "packages")))

(defn clean [recipe]
  (-> (defractionize recipe)
      expand-abbr
      spell-by
      hynphenate-inches
      collapse-spaces
      qualify-degrees
      expand-measures))

(clean (slurp (nth files 16)))
