jQuery(function(){

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

});

jQuery(function(){

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
});

jQuery(function(){
  jQuery("#new_agenda").submit(function(event){
    fill_hidden_fields();
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