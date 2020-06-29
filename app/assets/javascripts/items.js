$(document).on('turbolinks:load', ()=> {
  const buildFileField = (targetIndex,count)=> {
    var width = 570 - ((count % 5) * 114)
    const html = `<label for="item_photos_attributes_${targetIndex}_image" class="image__add" id="${targetIndex}">
                    <div class="image__addbox--add" style="width:${width}px;">
                      <div class="image__addbox--textbox">
                        <i class="fas fa-camera"></i>
                        <p>画像を追加</p>
                      </div>
                    </div>
                    <div data-index="${targetIndex}" class="js-file_group">
                      <input class="js-file" type="file" style="display:none;" name="item[photos_attributes][${targetIndex}][image]" id="item_photos_attributes_${targetIndex}_image">
                    </div>
                  </label>`;
    return html;
  }
  const buildImg = (index, url)=> {
    const html = `<div class="buildImg"><div class="buildImg__edit">編集</div><img data-index="${index}" src="${url}" width="112px" height="112px"><div class="js-remove">削除</div></div>`;
    return html;
  }

  const buildSelectInnerOption = (category)=>{
    const html = `<option value="${category.id}">${category.name}</option>`
    return html;
  }
  const buildSelect = (insertHTML)=>{
    const html = `<div id="category__children"><select id="item_category_id" name="item[category_id]" ><option value>選択してください</option>${insertHTML}</select></div>`
    return html;
  }

  const buildSelectGrandChild = (insertHTML)=>{
    const html = `<div id="category__grandchildren"><select id="item_category_id" name="item[category_id]" ><option value>選択してください</option>${insertHTML}</select></div>`
    return html;
  }

  const buildSelectSize = ()=>{
    const html = `<div class="product-content__detail__size"><label>サイズ<span class="require--gray">任意</span></label>
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


  $('#photo-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    var fix_box = $('#image-boxes').children().length
    if (fix_box !== 1){
      for(var i = 1;  i < fix_box;  i++){
        $('#image-box:last').remove();
      }
    }
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {
      var lastLabelFor =$('#image-box').children('.image__add:last').attr('for');
      var nextId = parseInt(lastLabelFor.replace(/[^0-9]/g, '')) + 1
      $('div').find('.image__startbox').remove();
      $('div').find('.image__addbox--add').remove();
        $('#' + targetIndex).append(buildImg(targetIndex, blobUrl));
      var nowImageboxCount = $('#image-box').children('.image__add').length;
      if (nowImageboxCount < 10){
      $('#image-box').append(buildFileField(nextId,nowImageboxCount));
      }
    }
  });

  $('#image-box').on('click', '.js-remove', function(e) {
    e.preventDefault();
    var targetId = $(this).parent().parent().attr('id')
    var lastLabelFor =$('#image-box').children('.image__add:last').attr('for');
    var nextId = parseInt(lastLabelFor.replace(/[^0-9]/g, '')) + 1
    $(this).parent().parent().remove();
    $('#image-box').find('#' + targetId).remove();
    $('div').find('.image__addbox--add').parent().remove();
    var destroyCheck = $(`input[data-index="${targetId}"].destroyCheck`);
    if (destroyCheck){
      destroyCheck.prop('checked', true)
    };
    var nowImageboxCount = $('#image-box').children('.image__add').length;
    $('#image-box').append(buildFileField(nextId,nowImageboxCount));
    });        

  $(".product__text__field--wide").on("keyup", function () {
    $(".count-up").text($(this).val().length + '/1000');
  });

  $(document).on('change','#category__parents select',function(){
    $('#category__children').remove();
    $('#category__grandchildren').remove();
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
        $('#category__children').remove();
        $('#category__grandchildren').remove();
        $('.product-content__detail__size').remove();
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

  $(document).on('change','#category__children select',function(){
    $('#category__grandchildren').remove();
    $('.product-content__detail__size').remove();
    var parents_id = $(this).val()
    if (parents_id){
      $.ajax({
        type: 'GET',
        url:"/items/grandchildren",
        data:{id: parents_id},
        dataType: 'json'
      })
      .done(function(children) {
        $('#category__grandchildren').remove();
        $('.product-content__detail__size').remove();
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

  $(document).on('change','#category__grandchildren select',function(){
    $('.product-content__detail__size').remove();
    var parents_id = $(this).val();
    if (parents_id && $('#item_category_id').val() <= 3 ){
      $('.product-content__detail__size').remove();
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