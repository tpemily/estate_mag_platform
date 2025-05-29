(define-constant token-decimals u6)
(define-constant total-supply u1000000) ;; 1,000,000 tokens max

(define-map balances principal uint) ;; token balances
(define-data-var total-rent-collected uint u0)
(define-data-var total-distributed uint u0)

(define-data-var manager principal tx-sender)

(define-map maintenance-log
  { id: uint }
  { description: (string-ascii 200), timestamp: uint })

(define-data-var log-counter uint u0)

;; Error constants
(define-constant err-unauthorized u401)
(define-constant err-insufficient-balance u402)
(define-constant err-invalid-amount u403)

;; Token transfer
(define-public (transfer (to principal) (amount uint))
  (let ((sender tx-sender))
    (let ((sender-balance (default-to u0 (map-get? balances sender)))
          (recipient-balance (default-to u0 (map-get? balances to))))
      (begin
        (asserts! (> amount u0) (err err-invalid-amount))
        (asserts! (>= sender-balance amount) (err err-insufficient-balance))
        (asserts! (<= (+ recipient-balance amount) total-supply) (err err-invalid-amount))
        (map-set balances sender (- sender-balance amount))
        (map-set balances to (+ recipient-balance amount))
        (print {event: "transfer", from: sender, to: to, amount: amount})
        (ok true)))))

;; Initial mint - only callable once by the manager
(define-public (mint-tokens (recipient principal) (amount uint))
  (begin
    (asserts! (is-eq tx-sender (var-get manager)) (err err-unauthorized))
    (asserts! (> amount u0) (err err-invalid-amount))
    (let ((existing (default-to u0 (map-get? balances recipient))))
      (asserts! (<= (+ existing amount) total-supply) (err err-invalid-amount))
      (map-set balances recipient (+ existing amount))
      (print {event: "mint", recipient: recipient, amount: amount})
      (ok true))))

;; Manager deposits rental income into contract
(define-public (deposit-rent (amount uint))
  (begin
    (asserts! (is-eq tx-sender (var-get manager)) (err err-unauthorized))
    (asserts! (> amount u0) (err err-invalid-amount))
    (let ((current-total (var-get total-rent-collected)))
      (asserts! (<= (+ current-total amount) u340282366920938463463374607431768211455) (err err-invalid-amount))
      (var-set total-rent-collected (+ current-total amount))
      (print {event: "rent-deposited", amount: amount})
      (ok true))))

;; Distribute rent to all investors
(define-public (distribute-rent)
  (begin
    (asserts! (is-eq tx-sender (var-get manager)) (err err-unauthorized))
    (let ((rent-amount (var-get total-rent-collected)))
      (begin
        (var-set total-distributed (+ (var-get total-distributed) rent-amount))
        (var-set total-rent-collected u0)
        (print {event: "rent-distributed", amount: rent-amount})
        (ok rent-amount)))))

;; Add maintenance log entry
(define-public (add-maintenance-log (description (string-ascii 200)))
  (begin
    (asserts! (is-eq tx-sender (var-get manager)) (err err-unauthorized))
    (let ((log-id (+ (var-get log-counter) u1)))
      (map-set maintenance-log
        {id: log-id}
        {description: description, timestamp: stacks-block-height})
      (var-set log-counter log-id)
      (print {event: "maintenance-added", id: log-id})
      (ok log-id))))

;; Read-only functions
(define-read-only (get-balance (account principal))
  (default-to u0 (map-get? balances account)))

(define-read-only (get-total-rent-collected)
  (var-get total-rent-collected))

(define-read-only (get-total-distributed)
  (var-get total-distributed))

(define-read-only (get-manager)
  (var-get manager))

(define-read-only (get-maintenance-log (log-id uint))
  (map-get? maintenance-log {id: log-id}))

(define-read-only (get-log-counter)
  (var-get log-counter))
