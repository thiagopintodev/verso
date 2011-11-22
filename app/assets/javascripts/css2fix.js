/*Thiago Almeida css2 fix*/
$(function(){
  $("select").addClass("input-value input-type-select");
  $("input[type='text'], textarea").addClass("input-value input-type-text");
  $("input[type='password']").addClass("input-value input-type-text input-type-password");

  $("input[type='button']").addClass("input-button input-type-button");
  $("input[type='image']").addClass("input-button input-type-image");
  $("input[type='submit']").addClass("input-button input-type-submit");


  $("input[type='checkbox']").addClass("input-value input-type-checkbox");
  $("input[type='radio']").addClass("input-value input-type-radio");

  $("input[type='checkbox']").live('change', function() {
    if ($(this).nodeName == "LABEL") {
      label = $(this);
      checkbox = $("#"+$(this).attr('for'));
    } else {
      checkbox = $(this);
      label = $("label[for='"+$(this).attr('id')+"']");
    }
    if (checkbox.attr('checked')) {
      checkbox.addClass('input-type-checkbox-checked');
      label.addClass('checked');
    } else {
      checkbox.removeClass('input-type-checkbox-checked');
      label.removeClass('checked');
    }
  });

  $("input[type='radio']").live('change', function() {
    $("input[type='radio']").each(function(index, element){
      lbl = $("label[for='"+$(this).attr('id')+"']");
      if ($(this).attr('checked')) {
        $(this).addClass('input-type-radio-checked');
        lbl.addClass('checked');
      } else {
       $(this).removeClass('input-type-radio-checked');
        lbl.removeClass('checked');
      }
    });
  });
});
