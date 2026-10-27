package com.kisia.staybooking.accommodation;

import com.kisia.staybooking.room.RoomEntity;

// 개발·시연 데이터의 대표 사진. 실제 업로드 사진이 있으면 업로드 사진을 우선한다.
final class DemoAccommodationImages {
    private static final String BASE = "/assets/img/demo/";

    private DemoAccommodationImages() {
    }

    static String imageUrl(AccommodationEntity accommodation) {
        if (!accommodation.getAddress().endsWith("(체험용)")) {
            return null;
        }
        String name = accommodation.getName();
        if (name.contains("한옥") || name.contains("인사동") || name.contains("경주")
                || name.contains("백제")) {
            return BASE + "hanok-guesthouse.jpg";
        }
        if (name.contains("오션") || name.contains("바다") || name.contains("해변")
                || name.contains("해운대") || name.contains("광안리") || name.contains("함덕")
                || name.contains("을왕리") || name.contains("양양") || name.contains("영일대")
                || name.contains("마리나")) {
            return BASE + "seaside-resort.jpg";
        }
        if (name.contains("숲") || name.contains("포레스트") || name.contains("미륵산")
                || name.contains("설악")
                || name.contains("정원") || name.contains("호수") || name.contains("레이크")
                || name.contains("펜션") || name.contains("로지")) {
            return BASE + "forest-lodge.jpg";
        }
        return BASE + "city-hotel.jpg";
    }

    static String roomImageUrl(RoomEntity room, AccommodationEntity accommodation) {
        if (!accommodation.getAddress().endsWith("(체험용)")) {
            return null;
        }
        String name = room.getName();
        if (name.contains("트윈")) {
            return BASE + "room-twin.jpg";
        }
        if (name.contains("스위트") || name.contains("패밀리") || name.contains("그랜드")) {
            return BASE + "room-suite.jpg";
        }
        return BASE + "room-double.jpg";
    }
}
