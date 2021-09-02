const selectFoodTypes = () => {
  const area_wrapper = document.querySelector("#category_area_input");
  if(area_wrapper){
    const type_wrapper = document.querySelector("#category_type_input");
    const area_to_category = JSON.parse(area_wrapper.dataset.categoryArea)
    const inputs = area_wrapper.querySelectorAll("input")
    inputs.forEach((input)  => {
      input.addEventListener("click",(event) => {
        let name = "order[food_categories][]";
        let selected_inputs = []
        area_wrapper.querySelectorAll(`input`).forEach((div) => {
          if (div.checked){
            selected_inputs.push(div)
          }
        });
        type_wrapper
          .querySelectorAll("input")
          .forEach((div) => div.parentNode.classList.add("d-none"))
            type_wrapper.querySelector("fieldset").classList.remove("d-none")
            selected_inputs.forEach((id) => {
              let food_types = area_to_category[id.value];
              show_food_area(food_types, type_wrapper);
            });
      })
    })
  }
}

const show_food_area = (array_ids, type_wrapper) => {
  type_wrapper.querySelectorAll("input").forEach((div) => {
    if (array_ids.includes(+div.value)){
      div.parentNode.classList.remove("d-none");
    }
  });
}
export{selectFoodTypes}
