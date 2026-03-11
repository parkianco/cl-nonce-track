;;;; cl-nonce-track.asd
;;;; Nonce deduplication tracking library
;;;; Copyright (c) 2024-2026 Parkian Company LLC

(asdf:defsystem #:cl-nonce-track
  :description "Nonce deduplication tracking with expiration support"
  :author "Parkian Company LLC"
  :license "BSD-3-Clause"
  :version "1.0.0"
  :serial t
  :components ((:file "package")
               (:module "src"
                :components ((:file "nonce-tracker")))))
