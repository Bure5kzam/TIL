#!/bin/bash

# 스크립트가 실행될 때 파일명과 sudo 사용 여부를 받아옵니다.
while getopts "f:s" opt; do
  case "$opt" in
    f) file="$OPTARG";;
    s) use_sudo=true;;
  esac
done

# 파일명이 지정되지 않은 경우 에러 메시지를 표시하고 스크립트 종료
if [ -z "$file" ]; then
  echo "사용법: $0 [-s] -f <파일명>"
  exit 1
fi

# 파일명이 존재하는지 확인
if [ ! -f "$file" ]; then
  echo "파일 '$file'을(를) 찾을 수 없습니다."
  exit 1
fi

# sudo 사용 여부에 따라 패키지 설치
while read -r package; do
  if [ -n "$package" ]; then
    echo "패키지 '$package' 설치 중..."
    if [ "$use_sudo" = true ]; then
      sudo apt-get install -y "$package"
    else
      apt-get install -y "$package"
    fi
  fi
done < "$file"

echo "모든 패키지 설치가 완료되었습니다."
