# 자료실 (print-drop)

프린터 연결 PC에서 언제든 접속해서 파일을 다운로드할 수 있도록 만든 개인 자료실.

- 주소: https://a.invastor.pro
- 비밀번호: 별도 메모 (이 문서엔 적지 않음)
- 저장소: https://github.com/pop2875/print-drop

---

## 폴더 구조

- files/ : 실제 공유 파일들
- index.html : 자동 생성되는 목록 페이지 (직접 손대지 말 것)
- generate.sh : index.html 자동 생성 스크립트
- add.sh : 파일 추가+업로드 한 번에 처리하는 스크립트
- CNAME : 커스텀 도메인 설정 (a.invastor.pro)

---

## 자주 쓰는 명령어

### 파일 추가 (제일 많이 쓰는 것)

    cd ~/print-drop
    ./add.sh "파일경로"

예: ./add.sh "/mnt/c/Users/hjpark/Downloads/이력서.pdf"

파일명에 띄어쓰기/한글 있어도 따옴표로 감싸면 문제없음. 1~2분 후 사이트에 반영됨.

### 파일 삭제

    cd ~/print-drop
    rm "files/파일명"
    ./generate.sh
    git add .
    git commit -m "파일 삭제"
    git pull --rebase
    git push

### 비밀번호 변경

    cd ~/print-drop
    vi generate.sh

`var PASSWORD = "..."` 줄 수정 후 저장, 그다음:

    ./generate.sh
    git add . && git commit -m "비밀번호 변경" && git pull --rebase && git push

### 현재 목록 확인

    ls ~/print-drop/files/

---

## 동작 원리

프린터 PC 브라우저 → https://a.invastor.pro → 가비아 DNS (CNAME a → pop2875.github.io) → GitHub Pages (이 저장소를 그대로 호스팅)

노트북이나 WSL이 꺼져 있어도 항상 접속 가능 (GitHub이 서버 역할을 대신 해줌).

---

## 보안 수준 (중요)

- 저장소는 Public, 비밀번호는 웹페이지 자바스크립트 안에 평문으로 존재.
- 개발자도구(F12)로 소스 보면 비밀번호가 그대로 노출됨. 진짜 보안이 아니라 최소한의 잠금 수준.
- 주민번호, 계좌번호 등 진짜 민감한 정보는 절대 올리지 말 것.
- 더 강한 보안이 필요해지면 Cloudflare Access 방식으로 전환 가능 (Claude에게 재문의).

---

## 문제 해결

push가 거부됨 (rejected, fetch first):

    git pull --rebase
    git push

GitHub이 로그인/토큰 요구: Personal Access Token 필요
GitHub → Settings → Developer settings → Personal access tokens 에서 재발급

한글 파일명이 터미널에서 깨져 보임 (표시만 깨짐, 실제 파일은 정상):

    sudo locale-gen ko_KR.UTF-8
    echo 'export LANG=ko_KR.UTF-8' >> ~/.bashrc
    echo 'export LC_ALL=ko_KR.UTF-8' >> ~/.bashrc
    source ~/.bashrc

DNS 연결 상태 확인:

    nslookup a.invastor.pro 8.8.8.8

---

## 참고 - 이 방식을 선택한 이유

처음엔 WSL에 직접 nginx/Filebrowser를 띄우고 청년센터 공유기 포트포워딩으로 뚫으려 했으나:
- WSL 미러링 네트워크 모드가 이 노트북 드라이버와 충돌
- 청년센터 네트워크에 AP 격리(기기 간 통신 차단)가 걸려있어 공유기 관리자 권한 없이는 불가능

그래서 GitHub Pages + 가비아 DNS 방식으로 전환. 포트포워딩/방화벽 설정 전혀 불필요, 노트북을 꺼도 항상 접속 가능한 훨씬 안정적인 구조.
