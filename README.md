# KAYPLE
Flutter 개발자 채용 과제 전형

본 프로젝트는 과제 전형을 미리 대비한 
[basic_project](https://github.com/changs97/basic_project) 코드 기반으로 작성되었습니다.

## 프로젝트 개요
- **Flutter 버전**: 3.32.1
- **Dart 버전**: 3.8.1
- **상태관리**: GetX
- **로컬 저장소**: GetStorage (즐겨찾기)
- **아키텍쳐 패턴**: MVVM
- **코드 생성**: Freezed, Retrofit, JSON Serializable

## 주요 기능
- 📝 게시물 목록 조회 (JSONPlaceholder API)
- 📄 게시물 상세 보기
- ⭐ 즐겨찾기 기능 (GetStorage 기반 로컬 저장)
- 🔄 실시간 상태 동기화 (페이지 간 즐겨찾기 상태 공유)
- 📱 탭 기반 네비게이션 (전체/즐겨찾기)

## 기술 스택

### 상태 관리
- **GetX**: 상태 관리, 의존성 주입, 라우팅
- **UIState 패턴**: 통합된 상태 관리 (idle, loading, success, error)

### 데이터 계층
- **Retrofit**: REST API 클라이언트
- **Dio**: HTTP 클라이언트
- **GetStorage**: 로컬 키-값 저장소 (즐겨찾기)
- **Freezed**: 불변 데이터 클래스 생성

### 아키텍처
- **MVVM**: Model-View-ViewModel 패턴
- **Clean Architecture**: Domain, Data, Presentation 레이어 분리

## 프로젝트 구조
```
lib/
├── base/              # 기본 설정 (로거, 네비게이션, 테마)
├── core/              # 핵심 유틸리티 (Result, Config)
├── data/
│   ├── network/       # API 클라이언트 및 DTO
│   ├── storage/       # GetStorage 기반 저장소
│   └── repositories/  # Repository 구현체
├── domain/
│   ├── entities/     # 도메인 엔티티 (Freezed)
│   └── repository/    # Repository 인터페이스
└── presentation/
    ├── common/        # 공통 위젯
    └── posts/         # 게시물 관련 화면 및 ViewModel
```

## 아키텍처 설계

### 레이어 분리
- **Network DTO** → **Domain Entity** → **Presentation State**
  - 네트워크와 도메인 모델의 독립성 보장
  - 각 레이어의 변경이 다른 레이어에 영향 최소화
  - Freezed를 통한 타입 안전성 확보

### Repository 패턴
- Domain Layer에서 Repository 인터페이스 정의
- Data Layer에서 구현체 제공
- Mock Repository로 쉽게 교체 가능하여 테스트 용이성 확보
- 의존성 방향: Presentation → Domain ← Data

### GetX 상태 관리
- **ViewModel**: `GetxController`를 상속한 ViewModel 구현
- **UIState 패턴**: 통합된 상태 클래스 (idle, loading, success, error)
- **의존성 주입**: `DependencyInjection` 클래스에서 `Get.put()` 사용
- **반응형 UI**: `GetView`와 `Obx()`를 활용한 자동 업데이트
- **라우팅**: `GetMaterialApp`과 `getPages`를 사용한 선언적 라우팅

### 최적화 기법
- **낙관적 업데이트**: UI 즉시 반영 후 서버 응답 대기
- **페이지 간 상태 동기화**: 즐겨찾기 변경 시 관련 ViewModel 자동 업데이트
- **Key 기반 리스트 최적화**: 각 아이템에 고유 key 부여로 불필요한 리빌드 방지
- **공통 위젯**: 에러 처리 UI 공통화로 코드 중복 제거

## 주요 기능 상세

### 즐겨찾기 기능
- GetStorage를 사용한 로컬 저장
- 페이지 간 실시간 동기화
- 낙관적 업데이트로 즉각적인 UI 반응

### 상태 관리
- UIState 패턴으로 상태 통합 관리
- 로딩, 성공, 에러 상태를 하나의 객체로 관리
- 타입 안전한 상태 전환

## 빌드 및 실행

### 필수 사항
- Flutter SDK 3.7.2 이상
- Dart SDK 3.7.2 이상

### 설치 및 실행
```bash
# 의존성 설치
flutter pub get

# 코드 생성 (Freezed, Retrofit 등)
flutter pub run build_runner build --delete-conflicting-outputs

# 앱 실행
flutter run
```

## 참고 사항

### NDK 버전 명시적 설정
Android 빌드를 위해 NDK 버전 `27.0.12077973`을 명시적으로 설정했습니다. 빌드 에러 시 참고 부탁드립니다.

### 코드 생성
프로젝트는 Freezed, Retrofit, JSON Serializable을 사용하므로 코드 변경 후 다음 명령어 실행이 필요합니다:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### UseCase 제거
`basic_project`에는 UseCase가 포함되어 있었으나, 현재 프로젝트에서는 오버 스펙으로 판단하여 제거하였습니다.





