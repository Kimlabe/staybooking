// SQL 인젝션 실습 화면: 중복 확인 쿼리만 호출하며 실제 계정을 만들지 않는다.
(function () {
  'use strict';

  var form = document.getElementById('signup-form');
  var email = document.getElementById('email');
  var checkButton = document.getElementById('check-email');
  var submit = document.getElementById('signup-submit');
  var alertBox = document.getElementById('signup-alert');
  var status = document.getElementById('email-status');
  var result = document.getElementById('lab-signup-result');
  var enabled = false;

  Ui.bindPasswordToggles();
  checkButton.disabled = true;
  submit.disabled = true;
  fetch('/api/v1/lab/injection/status', { cache: 'no-store' })
    .then(function (response) {
      if (!response.ok) throw new Error('실습 API가 비활성화되어 있습니다.');
      enabled = true;
      checkButton.disabled = false;
      submit.disabled = false;
    })
    .catch(function () {
      Ui.showAlert(alertBox, 'localhost에서 로컬 실습 빌드를 실행해 주세요.', 'warning');
    });

  async function checkEmail() {
    if (!enabled) return;
    Ui.hideAlert(alertBox);
    result.hidden = true;
    if (!email.value.trim()) {
      Ui.setFieldError(email, '이메일을 입력해 주세요.');
      return;
    }
    Ui.setFieldError(email, '');
    Ui.setLoading(checkButton, true, '확인 중');
    try {
      var response = await fetch('/api/v1/lab/injection/signup-check', {
        method: 'POST',
        headers: { Accept: 'application/json', 'Content-Type': 'application/json' },
        body: JSON.stringify({ loginId: email.value }),
        cache: 'no-store'
      });
      var body = await response.json();
      if (!response.ok) throw new Error(body.message || '실습 요청에 실패했습니다.');
      status.textContent = body.unsafeCount ? '실습 쿼리: 사용 중으로 판정' : '실습 쿼리: 사용 가능으로 판정';
      status.className = 'field-status ' + (body.unsafeCount ? '' : 'ok');
      status.hidden = false;
      Ui.showAlert(alertBox, body.injectionSucceeded
        ? 'SQL 인젝션 성공: 안전한 조회와 취약한 조회의 중복 확인 결과가 다릅니다.'
        : 'SQL 인젝션 성공이 확인되지 않았습니다. 계정은 생성되지 않습니다.',
        body.injectionSucceeded ? 'success' : 'warning');
      result.textContent = '안전한 조회: ' + body.safeCount + '건'
        + '\n취약한 조회: ' + body.unsafeCount + '건'
        + '\n계정은 생성되지 않습니다.';
      result.hidden = false;
    } catch (error) {
      Ui.showAlert(alertBox, error.message || '실습 요청에 실패했습니다.', 'error');
    } finally {
      Ui.setLoading(checkButton, false);
    }
  }

  checkButton.addEventListener('click', checkEmail);
  form.addEventListener('submit', function (event) {
    event.preventDefault();
    checkEmail();
  });
})();
