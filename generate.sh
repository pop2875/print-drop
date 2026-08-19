#!/bin/bash
cd "$(dirname "$0")"

cat > index.html << 'HTML_HEAD'
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>자료실</title>
<style>
  body { font-family: sans-serif; max-width: 600px; margin: 40px auto; padding: 0 20px; }
  h1 { font-size: 20px; }
  ul { list-style: none; padding: 0; }
  li { padding: 10px 0; border-bottom: 1px solid #ddd; }
  a { text-decoration: none; color: #0366d6; font-size: 16px; }
  #lock { text-align: center; margin-top: 100px; font-size: 18px; }
</style>
</head>
<body>

<div id="lock">🔒 비밀번호를 입력해주세요...</div>

<div id="content" style="display:none;">
<h1>📂 자료실</h1>
<ul>
HTML_HEAD

for f in files/*; do
  name=$(basename "$f")
  if [ "$name" != "*" ]; then
    echo "<li><a href=\"files/$name\">$name</a></li>" >> index.html
  fi
done

cat >> index.html << 'HTML_TAIL'
</ul>
</div>

<script>
(function() {
  var PASSWORD = "900507";
  var input = prompt("비밀번호를 입력하세요:");
  if (input === PASSWORD) {
    document.getElementById("lock").style.display = "none";
    document.getElementById("content").style.display = "block";
  } else {
    document.getElementById("lock").innerText = "❌ 접근 권한이 없습니다.";
  }
})();
</script>

</body>
</html>
HTML_TAIL

echo "index.html 생성 완료"
