;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

(in-package #:cl-nonce-track)

(define-condition cl-nonce-track-error (error)
  ((message :initarg :message :reader cl-nonce-track-error-message))
  (:report (lambda (condition stream)
             (format stream "cl-nonce-track error: ~A" (cl-nonce-track-error-message condition)))))
