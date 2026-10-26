-- DB01에 2026-10-26 적용한 accommodations 편의시설·이용 규칙 컬럼 추가용 1회 SQL.
-- DB01에 재실행 금지. 다른 DB에 적용할 때는 백업과 두 컬럼이 없는지 확인한다.
ALTER TABLE accommodations
    ADD COLUMN amenities TEXT NULL,
    ADD COLUMN rules TEXT NULL;

SELECT column_name, column_type, is_nullable
FROM information_schema.columns
WHERE table_schema = DATABASE()
  AND table_name = 'accommodations'
  AND column_name IN ('amenities', 'rules')
ORDER BY column_name;
