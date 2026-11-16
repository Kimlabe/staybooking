// [LAB ONLY] Drives the isolated SQL-injection training page against /api/v1/lab/injection.
// These routes exist only on the local H2 profile with injection-lab-enabled=true and are
// restricted to loopback. The production search/login/signup forms do NOT use any of this.
(function () {
  'use strict';

  var BASE = '/api/v1/lab/injection';

  function show(el, data) {
    if (Array.isArray(data)) {
      el.textContent = data.length ? data.join('\n') : '(결과 없음)';
    } else if (data && typeof data === 'object' && 'injectionSucceeded' in data) {
      var lines = [data.injectionSucceeded ? 'SQL 인젝션 성공' : 'SQL 인젝션 성공 확인 안 됨'];
      if ('matchedRows' in data) {
        lines.push('안전한 조회: ' + (data.safeMatched ? '일치' : '불일치'));
        lines.push('취약한 조회: ' + (data.unsafeMatched ? '일치' : '불일치'));
        lines.push('조회된 계정: ' + (data.matchedRows.length ? data.matchedRows.join(', ') : '(없음)'));
      } else {
        lines.push('안전한 중복 확인: ' + data.safeCount + '건');
        lines.push('취약한 중복 확인: ' + data.unsafeCount + '건');
      }
      el.textContent = lines.join('\n');
    } else {
      el.textContent = String(data);
    }
  }

  async function call(path, params, resultEl, method) {
    resultEl.textContent = '실행 중...';
    try {
      var isPost = method === 'POST';
      var qs = isPost ? '' : '?' + new URLSearchParams(params).toString();
      var res = await fetch(BASE + path + qs, {
        method: isPost ? 'POST' : 'GET',
        headers: isPost ? { Accept: 'application/json', 'Content-Type': 'application/json' }
          : { Accept: 'application/json' },
        body: isPost ? JSON.stringify(params) : undefined,
        cache: 'no-store'
      });
      var body = await res.json().catch(function () { return null; });
      if (!res.ok) {
        show(resultEl, (body && (body.message || body.error)) || ('HTTP ' + res.status));
        return;
      }
      show(resultEl, body);
    } catch (err) {
      show(resultEl, '요청 실패: ' + (err && err.message ? err.message : err));
    }
  }

  // Confirm the lab is actually enabled before wiring the buttons.
  fetch(BASE + '/status', { cache: 'no-store' })
    .then(function (res) {
      if (!res.ok) throw new Error('lab disabled');
      wire();
    })
    .catch(function () {
      document.querySelectorAll('.lab-result').forEach(function (el) {
        el.textContent = '실습 환경이 비활성화되어 있습니다. (local 프로필 + injection-lab-enabled=true + localhost 필요)';
      });
    });

  function wire() {
    document.getElementById('search-run').addEventListener('click', function () {
      call('/search', { keyword: document.getElementById('search-keyword').value },
        document.getElementById('search-result'));
    });
    document.getElementById('login-run').addEventListener('click', function () {
      call('/login', {
        loginId: document.getElementById('login-id').value,
        password: document.getElementById('login-pw').value
      }, document.getElementById('login-result'), 'POST');
    });
    document.getElementById('signup-run').addEventListener('click', function () {
      call('/signup-check', { loginId: document.getElementById('signup-id').value },
        document.getElementById('signup-result'), 'POST');
    });
  }
})();
