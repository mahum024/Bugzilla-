window.onload = function(){
  document.getElementById("bug_type_of_bug").addEventListener('change',function(){
    debugger
    var status =  document.getElementById("bug_status")
    status.remove(2)
    option = document.createElement('option');
  
   if (this.value==='bug') {  
     option.setAttribute('value', "resolved");
     option.appendChild(document.createTextNode("resolved"));
     status.add(option);
   } else {
     option.setAttribute('value', "completed");
     option.appendChild(document.createTextNode("completed"));
     status.add(option);
   }
  });
};

 