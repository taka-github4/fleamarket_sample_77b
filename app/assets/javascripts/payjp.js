$(document).on('turbolinks:load', ()=> {
  $('#token_submit').on('click', function (e) {
    e.preventDefault();
    Payjp.setPublicKey("pk_test_e58090c01c48530e024bc527");
    let card = {
      number: document.getElementById("card_number").value,
      cvc: document.getElementById("cvc").value,
      exp_month: document.getElementById("exp_month").value,
      exp_year: document.getElementById("exp_year").value
    };
    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        $("#card_token").append(
          $('<input type="hidden" name="payjp-token">').val(response.id)
        );
        $("#card_number").val("")
        $("#cvc").val("")
        $("#exp_month").val("")
        $("#exp_year").val("")
        alert("登録が完了しました");
      } else {
        alert("カード情報が正しくありません。");
      }
      document.inputForm.submit();
    });
  });
})