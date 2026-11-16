// SQL 인젝션 실습 화면: 실제 인증 API를 호출하거나 토큰을 저장하지 않는다.
(function () {
  'use strict';

  var form = document.getElementById('login-form');
  var email = document.getElementById('email');
  var password = document.getElementById('password');
  var submit = document.getElementById('login-submit');
  var alertBox = document.getElementById('login-alert');
  var result = document.getElementById('lab-login-result');
  var enabled = false;

  Ui.bindPasswordToggles();
  submit.disabled = true;
  fetch('/api/v1/lab/injection/status', { cache: 'no-store' })
    .then(function (response) {
      if (!response.ok) throw new Error('실습 API가 비활성화되어 있습니다.');
      enabled = true;
      submit.disabled = false;
    })
    .catch(function () {
      Ui.showAlert(alertBox, 'localhost에서 로컬 실습 빌드를 실행해 주세요.', 'warning');
    });

  form.addEventListener('submit', async function (event) {
    event.preventDefault();
    if (!enabled) return;
    Ui.hideAlert(alertBox);
    result.hidden = true;

    // 입력을 가공하면 SQL 인젝션 비교가 달라지므로 그대로 전달한다.
    if (!email.value.trim()) {
      Ui.setFieldError(email, '이메일을 입력해 주세요.');
      return;
    }
    Ui.setFieldError(email, '');
    Ui.setLoading(submit, true, '확인 중...');
    try {
      var response = await fetch('/api/v1/lab/injection/login', {
        method: 'POST',
        headers: { Accept: 'application/json', 'Content-Type': 'application/json' },
        body: JSON.stringify({ loginId: email.value, password: password.value }),
        cache: 'no-store'
      });
      var body = await response.json();
      if (!response.ok) throw new Error(body.message || '실습 요청에 실패했습니다.');
      Ui.showAlert(alertBox,
        '실습 쿼리 결과: ' + body.length + '건 조회. 실제 로그인과 토큰 발급은 수행하지 않았습니다.',
        body.length ? 'warning' : 'error');
      result.textContent = body.length ? body.join('\n') : '(조회 결과 없음)';
      result.hidden = false;
    } catch (error) {
      Ui.showAlert(alertBox, error.message || '실습 요청에 실패했습니다.', 'error');
    } finally {
      Ui.setLoading(submit, false);
    }
  });
})();
