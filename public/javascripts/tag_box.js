jQuery(function(){
  //wanted box
  jQuery('#wanteds input').on('focusout',function(){    
    console.log(this.value);
    var txt= this.value.replace(/[\,]/g,''); //.replace(/[^a-zA-Z0-9\+\-\.\#]/g,'');
    console.log(txt);
    if(txt) {
      jQuery(this).before('<span class="tag" value="'+ txt.toLowerCase() + '">'+ txt.toLowerCase() +'</span>');
    }
    this.value="";
  }).on('keyup',function( e ){
    // if: comma,enter (delimit more keyCodes with | pipe)
    if(/(188|13)/.test(e.which)) jQuery(this).focusout();     
  });

  jQuery('#wanteds').on('click','.tag',function(){
     if(confirm("Remover Desejo?")) jQuery(this).remove(); 
  });

  //unwanted_box
  jQuery('#unwanteds input').on('focusout',function(){    
    var txt= this.value.replace(/[\,]/g,''); //.replace(/[^a-zA-Z0-9\+\-\.\#]/g,'');
    if(txt) {
      console.log(jQuery(this));
      jQuery(this).before('<span class="tag" value="'+ txt.toLowerCase() + '">'+ txt.toLowerCase() +'</span>');
    }
    this.value="";
  }).on('keyup',function( e ){
    // if: comma,enter (delimit more keyCodes with | pipe)
    if(/(188|13)/.test(e.which)) jQuery(this).focusout();     
  });

  jQuery('#unwanteds').on('click','.tag',function(){
     if(confirm("Remover tag?")) jQuery(this).remove(); 
  });

  //selecting agenda
  jQuery("#new_agenda").submit(function(event){
    fill_hidden_fields();
  });

  //create new google agenda via ajax
  jQuery("#btn_create_google_agenda").click(function(){
    jQuery.ajax({
      url: "/google_agenda/create_google_agenda?agenda_name="+ jQuery("#calendar_name").val(),
      beforeSend: function(){
        jQuery("#modal_div").dialog({dialogClass: "no-close", closeOnEscape: false, draggable: false, modal: true});
      },
      success: function(result){
        console.log("Chegou, jovem!");
      }
    });
  });

});


function fill_hidden_fields()
{
  var wanteds = jQuery("#wanteds .tag").map(function(){return jQuery(this).attr("value")}).get().join();
  var unwanteds = jQuery("#unwanteds .tag").map(function(){return jQuery(this).attr("value")}).get().join();

  jQuery("#agenda_interest_attributes_wanted_regexp").val(wanteds);
  jQuery("#agenda_interest_attributes_unwanted_regexp").val(unwanteds);

}

function fill_name(summary)
{
  jQuery("#agenda_name").val(summary);
}

//reload form on create action loaded
jQuery(document).ready(function() {
  wanteds = jQuery("#agenda_interest_attributes_wanted_regexp").val();
  if(!wanteds.empty())
  {
    wanteds.split(",").forEach(function(wanted){
      jQuery('#wanteds input').before('<span class="tag" value="' + wanted +'">'+ wanted +'</span>');
    });
  }

  unwanteds = jQuery("#agenda_interest_attributes_unwanted_regexp").val();
  if(!unwanteds.empty())
  {
    unwanteds.split(",").forEach(function(unwanted){
      jQuery('#unwanteds input').before('<span class="tag" value="' + unwanted +'">'+ unwanted +'</span>');
    });
  }
});