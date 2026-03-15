;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

(in-package #:cl-nonce-track)

;;; Core types for cl-nonce-track
(deftype cl-nonce-track-id () '(unsigned-byte 64))
(deftype cl-nonce-track-status () '(member :ready :active :error :shutdown))
