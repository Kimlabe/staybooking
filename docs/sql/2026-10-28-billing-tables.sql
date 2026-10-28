-- 카드 등록 기능을 사용하는 기존 MySQL DB에 한 번 적용한다.
-- 적용 전 DB 전체를 백업하고, 두 테이블이 아직 없는지 확인한다.
-- MySQL DDL은 ROLLBACK으로 되돌릴 수 없다. 키 값은 이 파일에 넣지 않는다.

CREATE TABLE billing_customers (
    user_id BIGINT NOT NULL,
    customer_key VARCHAR(64) NOT NULL,
    created_at DATETIME(6) NOT NULL,
    updated_at DATETIME(6) NOT NULL,
    PRIMARY KEY (user_id),
    CONSTRAINT uk_billing_customers_key UNIQUE (customer_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE billing_cards (
    billing_card_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    customer_key VARCHAR(64) NOT NULL,
    billing_key_encrypted VARCHAR(512) NOT NULL,
    card_company VARCHAR(30) NULL,
    card_number_masked VARCHAR(30) NULL,
    created_at DATETIME(6) NOT NULL,
    updated_at DATETIME(6) NOT NULL,
    PRIMARY KEY (billing_card_id),
    CONSTRAINT uk_billing_cards_user UNIQUE (user_id),
    CONSTRAINT fk_billing_cards_user FOREIGN KEY (user_id) REFERENCES users (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = DATABASE()
  AND table_name IN ('billing_customers', 'billing_cards')
ORDER BY table_name;
