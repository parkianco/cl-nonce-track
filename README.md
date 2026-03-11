# cl-nonce-track

Nonce deduplication tracking library for Common Lisp.

## Features

- Track seen nonces with automatic expiration
- Thread-safe operations (SBCL)
- Configurable TTL per nonce or default
- Zero external dependencies

## Installation

```lisp
(asdf:load-system :cl-nonce-track)
```

## Usage

```lisp
(use-package :cl-nonce-track)

;; Create tracker with 1 hour default TTL
(defvar *tracker* (make-nonce-tracker :default-ttl 3600))

;; Check and record nonces
(record-nonce *tracker* #(1 2 3 4))  ; => T (newly recorded)
(nonce-seen-p *tracker* #(1 2 3 4)) ; => T
(record-nonce *tracker* #(1 2 3 4)) ; => NIL (already exists)

;; Use macro for atomic check-and-execute
(with-nonce-tracking (*tracker* nonce)
  (process-message message))

;; Maintenance
(clear-expired-nonces *tracker*)
(nonce-count *tracker*)
```

## API

- `make-nonce-tracker &key default-ttl` - Create tracker
- `nonce-seen-p tracker nonce` - Check if nonce exists
- `record-nonce tracker nonce &key ttl` - Record nonce
- `clear-expired-nonces tracker` - Remove expired entries
- `nonce-count tracker` - Get count
- `with-nonce-tracking (tracker nonce) &body` - Atomic check and execute

## License

BSD-3-Clause. Copyright (c) 2024-2026 Parkian Company LLC
