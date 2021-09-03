const selectsFoodCategoriesBoxed = ()=> {
      var ele=document.getElementsByName('chk');
      for(var i=0; i<ele.length; i++){
          if(ele[i].type=='checkbox')
              ele[i].checked=true;
      }
  }
  function deSelect(){
      var ele=document.getElementsByName('chk');
      for(var i=0; i<ele.length; i++){
          if(ele[i].type=='checkbox')
              ele[i].checked=false;

      }
  }
