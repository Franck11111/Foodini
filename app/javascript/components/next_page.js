const submitOnChange = () => {
  // 1.wait to check when somebody has selected I'm feeling lucky (event is on change)
  const feelingLuckyButton = document.querySelector("#order_option_category_i_am_feeling_lucky");
  const feelingCautiousButton = document.querySelector("#order_option_category_i_am_feeling_cautious");
  if (feelingLuckyButton) {
    feelingLuckyButton.addEventListener("change", (event) => {
       // 2.if there's a change then submit the form
      console.log(event.currentTarget)
      event.currentTarget.form.submit();
    });

  }
  if (feelingCautiousButton) {
    feelingCautiousButton.addEventListener("change", (event) => {
      console.log(event.currentTarget)
      event.currentTarget.form.submit();
    });
  };


};

export {submitOnChange};
