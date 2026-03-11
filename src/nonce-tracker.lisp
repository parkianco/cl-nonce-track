;;;; nonce-tracker.lisp
;;;; Nonce deduplication tracking
;;;; Copyright (c) 2024-2026 Parkian Company LLC

(in-package #:cl-nonce-track)

;;; Nonce tracker structure
(defstruct (nonce-tracker (:constructor %make-nonce-tracker))
  "Tracks seen nonces with expiration times."
  (table (make-hash-table :test 'equal) :type hash-table)
  (default-ttl 3600 :type fixnum)     ; Default TTL in seconds
  (lock nil))                          ; For thread safety (SBCL)

(defun make-nonce-tracker (&key (default-ttl 3600))
  "Create a new nonce tracker.
   DEFAULT-TTL: Time-to-live in seconds for nonces (default 3600 = 1 hour)."
  (let ((tracker (%make-nonce-tracker :default-ttl default-ttl)))
    ;; Create lock if SBCL threading available
    #+sbcl (setf (nonce-tracker-lock tracker)
                 (sb-thread:make-mutex :name "nonce-tracker-lock"))
    tracker))

(defmacro with-tracker-lock ((tracker) &body body)
  "Execute body with tracker lock held."
  #+sbcl
  `(sb-thread:with-mutex ((nonce-tracker-lock ,tracker))
     ,@body)
  #-sbcl
  `(progn ,@body))

(defun current-time-seconds ()
  "Get current Unix timestamp."
  (- (get-universal-time) 2208988800)) ; Convert to Unix epoch

(defun nonce-seen-p (tracker nonce)
  "Check if a nonce has been seen and is not expired.
   Returns T if the nonce was previously recorded and hasn't expired."
  (with-tracker-lock (tracker)
    (let ((entry (gethash nonce (nonce-tracker-table tracker))))
      (when entry
        (let ((expiry (car entry)))
          (if (> expiry (current-time-seconds))
              t
              (progn
                ;; Remove expired entry
                (remhash nonce (nonce-tracker-table tracker))
                nil)))))))

(defun record-nonce (tracker nonce &key ttl)
  "Record a nonce in the tracker.
   TTL: Time-to-live in seconds (uses tracker default if not specified).
   Returns T if the nonce was newly recorded, NIL if it was already present."
  (let ((actual-ttl (or ttl (nonce-tracker-default-ttl tracker)))
        (now (current-time-seconds)))
    (with-tracker-lock (tracker)
      (let ((existing (gethash nonce (nonce-tracker-table tracker))))
        (if (and existing (> (car existing) now))
            ;; Already exists and not expired
            nil
            ;; Record new or expired entry
            (progn
              (setf (gethash nonce (nonce-tracker-table tracker))
                    (cons (+ now actual-ttl) now))
              t))))))

(defun clear-expired-nonces (tracker)
  "Remove all expired nonces from the tracker.
   Returns the number of nonces removed."
  (let ((now (current-time-seconds))
        (removed 0))
    (with-tracker-lock (tracker)
      (maphash (lambda (nonce entry)
                 (when (<= (car entry) now)
                   (remhash nonce (nonce-tracker-table tracker))
                   (incf removed)))
               (nonce-tracker-table tracker)))
    removed))

(defun nonce-count (tracker)
  "Return the current number of tracked nonces (including expired)."
  (with-tracker-lock (tracker)
    (hash-table-count (nonce-tracker-table tracker))))

(defmacro with-nonce-tracking ((tracker nonce &key ttl on-duplicate) &body body)
  "Execute body only if nonce hasn't been seen.
   Records the nonce before executing body.
   ON-DUPLICATE: Form to evaluate if nonce was already seen (default: return NIL)."
  (let ((tracker-var (gensym "TRACKER"))
        (nonce-var (gensym "NONCE"))
        (ttl-var (gensym "TTL")))
    `(let ((,tracker-var ,tracker)
           (,nonce-var ,nonce)
           (,ttl-var ,ttl))
       (if (nonce-seen-p ,tracker-var ,nonce-var)
           ,(or on-duplicate nil)
           (progn
             (record-nonce ,tracker-var ,nonce-var :ttl ,ttl-var)
             ,@body)))))
