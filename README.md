# KAYPLE
Flutter 개발자 채용 과제 전형

본 프로젝트는 과제 전형을 미리 대비한 
[basic_project](https://github.com/changs97/basic_project) 코드 기반으로 작성되었습니다.

## 프로젝트 개요
- **Flutter 버전**: 3.32.1
- **Dart 버전**: 3.8.1
- **상태관리**: Riverpod 
- **로컬 데이터베이스**: Drift
- **아키텍쳐 패턴**: MVVM


## 참고 사항
### NDK 버전 명시적 설정 
Android 빌드를 위해 NDK 버전 `27.0.12077973`을 명시적으로 설정했습니다. 빌드 에러 시 참고 부탁드립니다.

**설정 이유**:
- Drift는 `sqlite3_flutter_libs` 패키지를 사용하여 네이티브 SQLite 라이브러리를 포함
- Android 빌드 시 네이티브 라이브러리 컴파일을 위해 NDK 필요

### 아키텍처 설계
- **Network DTO** → **Domain Entity** → **Local DB Model**을 각각 별도 클래스로 구성
  - 네트워크와 DB 모델은 요구사항 변경에 따라 변동성이 큼
  - 각 레이어의 독립성과 유지보수성 향상
  - 데이터 소스 변경 시 다른 레이어에 영향 최소화


- **Repository 인터페이스**를 Domain Layer에서 정의
  - Data Layer의 `PostRepositoryImpl`이 Domain의 `PostRepository` 인터페이스를 구현
  - Mock Repository로 쉽게 교체 가능하여 테스트 용이성 확보
  - 의존성 방향: Presentation → Domain ← Data

- `basic_project`에는 UseCase가 포함되어 있었으나, 현재 프로젝트에서는 오버 스펙으로 판단하여 제거하였습니다.





