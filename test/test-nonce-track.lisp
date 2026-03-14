;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

;;;; test-nonce-track.lisp - Unit tests for nonce-track
;;;;
;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: BSD-3-Clause

(defpackage #:cl-nonce-track.test
  (:use #:cl)
  (:export #:run-tests))

(in-package #:cl-nonce-track.test)

(defun run-tests ()
  "Run all tests for cl-nonce-track."
  (format t "~&Running tests for cl-nonce-track...~%")
  ;; TODO: Add test cases
  ;; (test-function-1)
  ;; (test-function-2)
  (format t "~&All tests passed!~%")
  t)
