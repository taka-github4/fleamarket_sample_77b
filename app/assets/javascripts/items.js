$(document).on('turbolinks:load', ()=> {
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[photos_attributes][${num}][image]"
                    id="item_photos_attributes_${num}_image"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }
  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }

  const buildSelectInnerOption = (category)=>{
    const html = `<option value="${category.id}">${category.name}</option>`
    return html;
  }
  const buildSelect = (insertHTML)=>{
    const html = `<div class="category__children"><select id="children_category"><option value="">選択してください</option>${insertHTML}</select></div>`
    return html;
  }

  const buildSelectGrandChild = (insertHTML)=>{
    const html = `<div class="category__grandchildren"><select name="item[category_id]" id="grandchildren_category"><option value="">選択してください</option>${insertHTML}</select></div>`
    return html;
  }

  const buildSelectSize = ()=>{
    const html = `<div class="product-content__detail__size"><label>サイズ<span class="require">必須</span></label>
                    <div>
                      <select name="item[size_id]" id="item_item_condition_id">
                        <option value="">選択してください</option>
                        <option value="1">XXS以下</option>
                        <option value="2">XS(SS)</option>
                        <option value="3">S</option>
                        <option value="4">M</option>
                        <option value="5">L</option>
                        <option value="6">XL(LL)</option>
                        <option value="7">2XL(3L)</option>
                        <option value="8">3XL(4L)</option>
                        <option value="9">4XL(5L)</option>
                        <option value="10">FREESIZE</option>
                      </select>
                    </div>
                  </div>`
    return html;
  }

  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);
  $('.hidden-destroy').hide();
  $('#photo-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {
      $('#previews').append(buildImg(targetIndex, blobUrl));
      $('#photo-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
  });

  $('#photo-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();
    if ($('.js-file').length == 0) $('#photo-box').append(buildFileField(fileIndex[0]));
  });

  $(".product__text__field--wide").on("keyup", function () {
    $(".count-up").text($(this).val().length + '/1000');
  });

  $('#item_category_id').change(function(){
    $('#children_category').remove();
    $('#grandchildren_category').remove();
    $('.product-content__detail__size').remove();
    var parents_id = $(this).val();
    if (parents_id){
      $.ajax({
        type: 'GET',
        url:"/items/children",
        data:{id: parents_id},
        dataType: 'json'
      })
      .done(function(children) {
        var insertHTML = '';
        $.each(children, function(i,child) {
          insertHTML += buildSelectInnerOption(child)
        });
        $('#category-box').append(buildSelect(insertHTML));
      })
      .fail(function() {
        alert('error');
      });
    }
  });

  $('#category-box').on('change','#children_category',function(){
    $('.product-content__detail__size').remove();
    $('#grandchildren_category').remove();
    var parents_id = $(this).val()
    if (parents_id){
      $.ajax({
        type: 'GET',
        url:"/items/grandchildren",
        data:{id: parents_id},
        dataType: 'json'
      })
      .done(function(children) {
        var insertHTML = '';
        $.each(children, function(i,child) {
          insertHTML += buildSelectInnerOption(child)
        });
        $('#category-box').append(buildSelectGrandChild(insertHTML));;
        $()
      })
      .fail(function() {
        alert('error');
      });
    }
  })

  $('#category-box').on('change','#grandchildren_category',function(){
    $('.product-content__detail__size').remove();
    var parents_id = $(this).val();
    if (parents_id && $('#item_category_id').val() <= 3 ){
      $('#category-box').append(buildSelectSize());
    }
  })

  $(function () {
    $('.product__num__field').change('input', function () {
      var data = $('.product__num__field').val();
      var profit = Math.round(data * 0.9)
      var fee = (data - profit)
      $(".product__num__field").val().length
      if ($(".product__num__field").val().length > 7 || $(".product__num__field").val() < 300) {
        alert("¥300以上¥9,999,999以下で入力してください")
      }
      $('.fee__right').html(fee)
      $('.fee__right').prepend('¥')
      $('.profit__right').html(profit)
      $('.profit__right').prepend('¥')
      $('#price').val(profit)
      if (profit == '') {
        $('.profit__right').html('');
        $('.fee__right').html('');
      }
    })
  })
});