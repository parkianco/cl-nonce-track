;;;; package.lisp
;;;; Package definition for cl-nonce-track
;;;; Copyright (c) 2024-2026 Parkian Company LLC

(defpackage #:cl-nonce-track
  (:use #:cl)
  (:export
   ;; Tracker operations
   #:make-nonce-tracker
   #:nonce-seen-p
   #:record-nonce
   #:clear-expired-nonces
   #:nonce-count
   ;; Macro
   #:with-nonce-tracking
   ;; Tracker structure
   #:nonce-tracker-p))
