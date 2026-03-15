;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

;;;; cl-nonce-track.asd
;;;; Nonce deduplication tracking library
;;;; Copyright (c) 2024-2026 Parkian Company LLC

(asdf:defsystem #:cl-nonce-track
  :description "Nonce deduplication tracking with expiration support"
  :author "Park Ian Co"
  :license "Apache-2.0"
  :version "0.1.0"
  :serial t
  :components ((:file "package")
               (:module "src"
                :components ((:file "nonce-tracker")))))

(asdf:defsystem #:cl-nonce-track/test
  :description "Tests for cl-nonce-track"
  :depends-on (#:cl-nonce-track)
  :serial t
  :components ((:module "test"
                :components ((:file "test-nonce-track"))))
  :perform (asdf:test-op (o c)
             (let ((result (uiop:symbol-call :cl-nonce-track.test :run-tests)))
               (unless result
                 (error "Tests failed")))))
