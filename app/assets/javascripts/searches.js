$(document).on('turbolinks:load', ()=> {


  const buildSearchSelectInnerOption = (parents_id,category)=>{
    const html = `<option value="${parents_id}/${category.id}">${category.name}</option>`
    return html;
  }
  const buildSearchSelect = (parents_id,insertHTML)=>{
    const html = `<select name="q[category_ancestry_start]" id="q_category_children_ancestry_start"><option value="${parents_id}/">選択してください</option>${insertHTML}</select>`
    return html;
  }

  const buildGrandchildSearchSelectInnerOption = (category)=>{
    const html = `<option value="${category.id}">${category.name}</option>`
    return html;
  }
  const buildGrandchildSearchSelect = (insertHTML)=>{
    const html = `<select name="q[category_id_eq_any]" id="q_category_grandchildren_id_eq_any"><option value="">選択してください</option>${insertHTML}</select>`
    return html;
  }

    $(document).on('change','#q_category_ancestry_start',function(){
    $('#q_category_children_ancestry_start').remove();
    $('#q_category_grandchildren_id_eq_any').remove();
    var parents_id = $(this).val();
    if (parents_id){
      $.ajax({
        type: 'GET',
        url:"/items/children",
        data:{id: parents_id},
        dataType: 'json'
      })
      .done(function(children) {
        $('#q_category_children_ancestry_start').remove();
        $('#q_category_grandchildren_id_eq_any').remove();
          var insertHTML = '';
          $.each(children, function(i,child) {
            insertHTML += buildSearchSelectInnerOption(parents_id,child)
          });
          $('#search__category').append(buildSearchSelect(parents_id,insertHTML));
      })
      .fail(function() {
        alert('error');
      });
    }
  });

  $(document).on('change','#q_category_children_ancestry_start',function(){
    $('#q_category_grandchildren_id_eq_any').remove();
    var parents_ancestry = $(this).val();
    if (parents_ancestry){
      $.ajax({
        type: 'GET',
        url:"/items/grandchildrenancestry",
        data:{ancestry: parents_ancestry},
        dataType: 'json'
      })
      .done(function(children) {
        $('#q_category_grandchildren_id_eq_any').remove();
        parent_val = $('#q_category_ancestry_start').val() + "/"
        if ($('#q_category_children_ancestry_start').val() != parent_val){
          var insertHTML = '';
          $.each(children, function(i,child) {
            insertHTML += buildGrandchildSearchSelectInnerOption(child)
          });
          $('#search__category').append(buildGrandchildSearchSelect(insertHTML));
        }
      })
      .fail(function() {
        alert('error');
      });
    }
  });

  $(document).on('change','#price_range',function(){
    var min_price =[,300,1000,5000,10000,30000,50000,100000]
    var max_price =[,1000,5000,10000,30000,50000,100000,]
    $('#q_price_gteq').val(min_price[$(this).val()])
    $('#q_price_lteq').val(max_price[$(this).val()])
  })
});