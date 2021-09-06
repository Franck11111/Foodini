function checkAll(check_all) {
  // Pass in a named "Check All" checkbox that appears on the same form where all
  // checkboxes should be checked.

  // Loop through an array containing ALL inputs on same form as check_all

  var inputs = check_all.form.getElementsByTagName("input");
  for (var i = 0; i < inputs.length; i++) {
    // Only work on checkboxes, and NOT on the "Check All" checkbox
    if (inputs[i].type == "checkbox" && inputs[i].name != check_all.name) {
      if (check_all.checked == true) {
        inputs[i].checked = true;
      } else {
        inputs[i].checked = false;
      }
    }
  }
}
