;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

;;;; package.lisp
;;;; Package definition for cl-nonce-track
;;;; Copyright (c) 2024-2026 Parkian Company LLC

(defpackage #:cl-nonce-track
  (:use #:cl)
  (:export
   #:identity-list
   #:flatten
   #:map-keys
   #:now-timestamp
#:with-nonce-track-timing
   #:nonce-track-batch-process
   #:nonce-track-health-check;; Tracker operations
   #:make-nonce-tracker
   #:nonce-seen-p
   #:record-nonce
   #:clear-expired-nonces
   #:nonce-count
   ;; Macro
   #:with-nonce-tracking
   ;; Tracker structure
   #:nonce-tracker-p))
