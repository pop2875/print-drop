#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "사용법: ./add.sh 파일경로"
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "파일을 찾을 수 없습니다: $1"
  exit 1
fi

cd "$(dirname "$0")"

cp "$1" files/
echo "복사 완료: $(basename "$1")"

./generate.sh

git add .
git commit -m "파일 추가: $(basename "$1")"
git push

echo ""
echo "완료! 잠시 후 https://a.invastor.pro 에서 확인 가능합니다."
