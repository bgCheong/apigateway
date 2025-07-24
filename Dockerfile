# =================
# STAGE 1: Build
# 소스 코드를 빌드하여 JAR 파일을 생성하는 단계
# =================
FROM eclipse-temurin:17-jdk-jammy as builder

# 작업 디렉토리 설정
WORKDIR /workspace

# Gradle 관련 파일들을 먼저 복사하여 의존성 캐싱 활용
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# 의존성 다운로드 (소스 코드 변경 없이 의존성만 변경되었을 때 이 단계만 다시 실행됨)
RUN ./gradlew dependencies

# 전체 소스 코드를 복사
COPY src src

# 애플리케이션 빌드 (테스트 포함)
RUN ./gradlew build -x test --no-daemon


# =================
# STAGE 2: Release
# 실제 배포될 최종 이미지를 만드는 단계
# =================
FROM eclipse-temurin:17-jre-jammy

# non-root 사용자 생성 (보안 강화)
ARG USERNAME=gateway
ARG UID=1001
ARG GID=1001
RUN groupadd --gid ${GID} ${USERNAME}
RUN useradd --uid ${UID} --gid ${GID} -m ${USERNAME}

# 작업 디렉토리 설정
WORKDIR /app

# builder 스테이지에서 빌드된 JAR 파일만 복사
COPY --from=builder /workspace/build/libs/*.jar gateway-service-app.jar

# 파일 소유권을 non-root 사용자로 변경
RUN chown ${USERNAME}:${USERNAME} gateway-service-app.jar

# non-root 사용자로 전환
USER ${USERNAME}

#HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  #CMD curl -f http://localhost:8080/actuator/health || exit 1

# 컨테이너 실행 명령어
ENTRYPOINT ["java", "-jar", "gateway-service-app"]