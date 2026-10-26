-- 개발·시연 전용 숙소 30곳. 숙소마다 객실 유형 4~5개, 판매 가능 객실 수량 20개 이상.
-- [샘플] 접두어로 실제 숙소와 구분한다. 재실행해도 같은 이름의 숙소·객실은 중복 생성하지 않는다.
-- 로컬 H2: staybooking.demo-data.enabled=true 때 자동 적용. DB01 MySQL: 별도 실행.

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 강남 시티 스테이', '서울특별시 강남구 테헤란로 101 (체험용)', '개발·시연용 숙소입니다. 강남 시티 스테이의 객실과 예약 흐름을 확인할 수 있습니다.', '16:00:00', '10:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 강남 시티 스테이');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 99000, 2, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 강남 시티 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 129000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 강남 시티 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 144000, 3, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 강남 시티 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 169000, 4, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 강남 시티 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 홍대 어반 하우스', '서울특별시 마포구 양화로 102 (체험용)', '개발·시연용 숙소입니다. 홍대 어반 하우스의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 홍대 어반 하우스');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 89000, 2, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 홍대 어반 하우스' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 114000, 2, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 홍대 어반 하우스' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 144000, 3, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 홍대 어반 하우스' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 169000, 4, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 홍대 어반 하우스' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 224000, 5, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 홍대 어반 하우스' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 명동 센트럴 호텔', '서울특별시 중구 명동길 103 (체험용)', '개발·시연용 숙소입니다. 명동 센트럴 호텔의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 명동 센트럴 호텔');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 104000, 2, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 명동 센트럴 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 134000, 2, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 명동 센트럴 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 144000, 3, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 명동 센트럴 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 194000, 4, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 명동 센트럴 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 239000, 5, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 명동 센트럴 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 잠실 레이크 호텔', '서울특별시 송파구 올림픽로 104 (체험용)', '개발·시연용 숙소입니다. 잠실 레이크 호텔의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 잠실 레이크 호텔');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 119000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 잠실 레이크 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 144000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 잠실 레이크 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 159000, 3, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 잠실 레이크 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 209000, 4, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 잠실 레이크 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 239000, 5, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 잠실 레이크 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 성수 리버 스테이', '서울특별시 성동구 연무장길 105 (체험용)', '개발·시연용 숙소입니다. 성수 리버 스테이의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 성수 리버 스테이');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 85000, 2, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 성수 리버 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 120000, 2, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 성수 리버 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 145000, 3, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 성수 리버 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 190000, 4, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 성수 리버 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 210000, 5, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 성수 리버 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 인사동 한옥 쉼', '서울특별시 종로구 인사동길 106 (체험용)', '개발·시연용 숙소입니다. 인사동 한옥 쉼의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 인사동 한옥 쉼');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 139000, 2, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 인사동 한옥 쉼' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 159000, 2, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 인사동 한옥 쉼' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 164000, 3, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 인사동 한옥 쉼' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 214000, 4, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 인사동 한옥 쉼' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 해운대 오션 라운지', '부산광역시 해운대구 해운대로 107 (체험용)', '개발·시연용 숙소입니다. 해운대 오션 라운지의 객실과 예약 흐름을 확인할 수 있습니다.', '16:00:00', '10:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 해운대 오션 라운지');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 144000, 2, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 해운대 오션 라운지' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 179000, 2, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 해운대 오션 라운지' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 194000, 3, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 해운대 오션 라운지' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 219000, 4, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 해운대 오션 라운지' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 264000, 5, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 해운대 오션 라운지' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 광안리 블루 스테이', '부산광역시 수영구 광안해변로 108 (체험용)', '개발·시연용 숙소입니다. 광안리 블루 스테이의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 광안리 블루 스테이');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 134000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 광안리 블루 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 164000, 2, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 광안리 블루 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 174000, 3, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 광안리 블루 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 209000, 4, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 광안리 블루 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 서면 시티 호텔', '부산광역시 부산진구 중앙대로 109 (체험용)', '개발·시연용 숙소입니다. 서면 시티 호텔의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 서면 시티 호텔');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 89000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 서면 시티 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 114000, 2, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 서면 시티 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 129000, 3, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 서면 시티 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 159000, 4, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 서면 시티 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 송도 마리나 스테이', '인천광역시 연수구 센트럴로 110 (체험용)', '개발·시연용 숙소입니다. 송도 마리나 스테이의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 송도 마리나 스테이');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 109000, 2, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 송도 마리나 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 144000, 2, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 송도 마리나 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 154000, 3, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 송도 마리나 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 204000, 4, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 송도 마리나 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 249000, 5, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 송도 마리나 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 을왕리 선셋 하우스', '인천광역시 중구 용유서로 111 (체험용)', '개발·시연용 숙소입니다. 을왕리 선셋 하우스의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 을왕리 선셋 하우스');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 124000, 2, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 을왕리 선셋 하우스' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 134000, 2, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 을왕리 선셋 하우스' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 149000, 3, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 을왕리 선셋 하우스' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 184000, 4, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 을왕리 선셋 하우스' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 234000, 5, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 을왕리 선셋 하우스' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 제주 바람 정원', '제주특별자치도 제주시 애월읍 애월로 112 (체험용)', '개발·시연용 숙소입니다. 제주 바람 정원의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 제주 바람 정원');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 129000, 2, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 제주 바람 정원' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 159000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 제주 바람 정원' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 194000, 3, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 제주 바람 정원' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 214000, 4, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 제주 바람 정원' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 함덕 코랄 호텔', '제주특별자치도 제주시 조천읍 함덕로 113 (체험용)', '개발·시연용 숙소입니다. 함덕 코랄 호텔의 객실과 예약 흐름을 확인할 수 있습니다.', '16:00:00', '10:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 함덕 코랄 호텔');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 159000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 함덕 코랄 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 189000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 함덕 코랄 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 209000, 3, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 함덕 코랄 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 224000, 4, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 함덕 코랄 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 서귀포 귤빛 스테이', '제주특별자치도 서귀포시 중정로 114 (체험용)', '개발·시연용 숙소입니다. 서귀포 귤빛 스테이의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 서귀포 귤빛 스테이');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 134000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 서귀포 귤빛 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 144000, 2, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 서귀포 귤빛 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 179000, 3, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 서귀포 귤빛 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 199000, 4, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 서귀포 귤빛 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 254000, 5, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 서귀포 귤빛 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 중문 오션 리조트', '제주특별자치도 서귀포시 중문관광로 115 (체험용)', '개발·시연용 숙소입니다. 중문 오션 리조트의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 중문 오션 리조트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 174000, 2, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 중문 오션 리조트' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 209000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 중문 오션 리조트' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 209000, 3, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 중문 오션 리조트' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 249000, 4, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 중문 오션 리조트' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 강릉 솔향 펜션', '강원특별자치도 강릉시 경포로 116 (체험용)', '개발·시연용 숙소입니다. 강릉 솔향 펜션의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 강릉 솔향 펜션');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 114000, 2, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 강릉 솔향 펜션' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 134000, 2, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 강릉 솔향 펜션' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 159000, 3, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 강릉 솔향 펜션' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 214000, 4, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 강릉 솔향 펜션' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 229000, 5, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 강릉 솔향 펜션' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 속초 설악 뷰 호텔', '강원특별자치도 속초시 청초호반로 117 (체험용)', '개발·시연용 숙소입니다. 속초 설악 뷰 호텔의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 속초 설악 뷰 호텔');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 144000, 2, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 속초 설악 뷰 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 159000, 2, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 속초 설악 뷰 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 164000, 3, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 속초 설악 뷰 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 214000, 4, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 속초 설악 뷰 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 249000, 5, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 속초 설악 뷰 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 춘천 호수 스테이', '강원특별자치도 춘천시 스포츠타운길 118 (체험용)', '개발·시연용 숙소입니다. 춘천 호수 스테이의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 춘천 호수 스테이');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 114000, 2, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 춘천 호수 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 144000, 2, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 춘천 호수 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 169000, 3, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 춘천 호수 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 204000, 4, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 춘천 호수 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 평창 포레스트 로지', '강원특별자치도 평창군 대관령면 올림픽로 119 (체험용)', '개발·시연용 숙소입니다. 평창 포레스트 로지의 객실과 예약 흐름을 확인할 수 있습니다.', '16:00:00', '10:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 평창 포레스트 로지');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 154000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 평창 포레스트 로지' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 164000, 2, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 평창 포레스트 로지' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 189000, 3, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 평창 포레스트 로지' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 209000, 4, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 평창 포레스트 로지' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 249000, 5, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 평창 포레스트 로지' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 경주 달빛 한옥', '경상북도 경주시 첨성로 120 (체험용)', '개발·시연용 숙소입니다. 경주 달빛 한옥의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 경주 달빛 한옥');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 139000, 2, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 경주 달빛 한옥' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 164000, 2, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 경주 달빛 한옥' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 184000, 3, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 경주 달빛 한옥' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 224000, 4, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 경주 달빛 한옥' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 포항 영일대 스테이', '경상북도 포항시 북구 해안로 121 (체험용)', '개발·시연용 숙소입니다. 포항 영일대 스테이의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 포항 영일대 스테이');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 124000, 2, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 포항 영일대 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 149000, 2, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 포항 영일대 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 149000, 3, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 포항 영일대 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 179000, 4, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 포항 영일대 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 244000, 5, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 포항 영일대 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 대구 동성로 호텔', '대구광역시 중구 동성로 122 (체험용)', '개발·시연용 숙소입니다. 대구 동성로 호텔의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 대구 동성로 호텔');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 99000, 2, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 대구 동성로 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 129000, 2, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 대구 동성로 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 144000, 3, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 대구 동성로 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 169000, 4, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 대구 동성로 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 울산 태화강 호텔', '울산광역시 중구 태화강국가정원길 123 (체험용)', '개발·시연용 숙소입니다. 울산 태화강 호텔의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 울산 태화강 호텔');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 89000, 2, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 울산 태화강 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 139000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 울산 태화강 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 149000, 3, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 울산 태화강 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 184000, 4, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 울산 태화강 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 대전 과학도시 스테이', '대전광역시 유성구 대학로 124 (체험용)', '개발·시연용 숙소입니다. 대전 과학도시 스테이의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 대전 과학도시 스테이');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 84000, 2, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 대전 과학도시 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 114000, 2, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 대전 과학도시 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 144000, 3, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 대전 과학도시 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 184000, 4, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 대전 과학도시 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 전주 한옥마을 쉼터', '전북특별자치도 전주시 완산구 은행로 125 (체험용)', '개발·시연용 숙소입니다. 전주 한옥마을 쉼터의 객실과 예약 흐름을 확인할 수 있습니다.', '16:00:00', '10:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 전주 한옥마을 쉼터');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 124000, 2, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 전주 한옥마을 쉼터' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 144000, 2, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 전주 한옥마을 쉼터' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 179000, 3, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 전주 한옥마을 쉼터' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 199000, 4, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 전주 한옥마을 쉼터' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 군산 근대항 스테이', '전북특별자치도 군산시 해망로 126 (체험용)', '개발·시연용 숙소입니다. 군산 근대항 스테이의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 군산 근대항 스테이');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 109000, 2, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 군산 근대항 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 114000, 2, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 군산 근대항 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 144000, 3, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 군산 근대항 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 179000, 4, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 군산 근대항 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 229000, 5, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 군산 근대항 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 여수 밤바다 호텔', '전라남도 여수시 이순신광장로 127 (체험용)', '개발·시연용 숙소입니다. 여수 밤바다 호텔의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 여수 밤바다 호텔');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 139000, 2, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 여수 밤바다 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 179000, 2, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 여수 밤바다 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 189000, 3, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 여수 밤바다 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 229000, 4, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 여수 밤바다 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 순천 정원 스테이', '전라남도 순천시 국가정원1호길 128 (체험용)', '개발·시연용 숙소입니다. 순천 정원 스테이의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 순천 정원 스테이');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 104000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 순천 정원 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 149000, 2, 10, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 순천 정원 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 154000, 3, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 순천 정원 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 184000, 4, 5, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 순천 정원 스테이' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 청주 터미널 호텔', '충청북도 청주시 흥덕구 풍산로 129 (체험용)', '개발·시연용 숙소입니다. 청주 터미널 호텔의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 청주 터미널 호텔');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 100000, 2, 8, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 청주 터미널 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 110000, 2, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 청주 터미널 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 140000, 3, 6, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 청주 터미널 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 160000, 4, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 청주 터미널 호텔' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');

INSERT INTO accommodations (name, address, description, check_in_time, check_out_time, amenities, rules, status, created_at, updated_at)
SELECT '[샘플] 공주 백제 한옥', '충청남도 공주시 관광단지길 130 (체험용)', '개발·시연용 숙소입니다. 공주 백제 한옥의 객실과 예약 흐름을 확인할 수 있습니다.', '15:00:00', '11:00:00', '무료 Wi-Fi, 금연 객실, 주차 가능', '체크인 시 예약자 확인, 실내 금연', 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM accommodations WHERE name = '[샘플] 공주 백제 한옥');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '스탠다드 더블', '퀸 침대 1개 · 기본형', 124000, 2, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 공주 백제 한옥' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '스탠다드 더블');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '디럭스 트윈', '싱글 침대 2개 · 넓은 객실', 139000, 2, 9, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 공주 백제 한옥' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '디럭스 트윈');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '프리미어 킹', '킹 침대 1개 · 프리미어형', 174000, 3, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 공주 백제 한옥' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '프리미어 킹');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '패밀리 스위트', '가족 여행용 · 침실과 거실', 214000, 4, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 공주 백제 한옥' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '패밀리 스위트');
INSERT INTO rooms (accommodation_id, name, description, price, capacity, total_quantity, status, created_at, updated_at)
SELECT a.accommodation_id, '그랜드 스위트', '넓은 거실 · 최대 5명', 249000, 5, 7, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
FROM accommodations a WHERE a.name = '[샘플] 공주 백제 한옥' AND NOT EXISTS
(SELECT 1 FROM rooms r WHERE r.accommodation_id = a.accommodation_id AND r.name = '그랜드 스위트');

