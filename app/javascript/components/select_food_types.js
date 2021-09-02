const selectFoodTypes = async () => {
  const area_wrapper = document.querySelector("#category_area_input");
  console.log(area_wrapper)
  if(area_wrapper){
    const type_wrapper = document.querySelector("#category_type_input");
    const area_to_category = JSON.parse(area_wrapper.dataset.categoryArea)
    const inputs = area_wrapper.querySelectorAll("input")
    console.log(area_to_category)
    inputs.forEach((input)  => {
      input.addEventListener("click",(event) => {
        let name = "order[food_categories][]";
        let selected_inputs = []
        area_wrapper.querySelectorAll(`input`).forEach((div) => {
          if (div.checked){
            selected_inputs.push(div)
          }
        });
        type_wrapper.querySelectorAll("input").forEach((div) => div.parentElement.classList.add("d-none"))
        selected_inputs.forEach((id) => {
          let food_types = area_to_category[id.value]
          console.log(food_types)
          show_food_area(food_types, type_wrapper);
        })
      })
    })
  }
}

const show_food_area = (array_ids, type_wrapper) => {
  type_wrapper.querySelectorAll("input").forEach((div) => {
    if (array_ids.includes(+div.value)){
    console.log(div.parentElement)
      div.parentElement.classList.remove("d-none");
    }
  });
}
export{selectFoodTypes}
