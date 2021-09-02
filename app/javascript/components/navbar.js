const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector(".navbar");
  if (navbar) {
    window.addEventListener("scroll", () => {
      if (window.scrollY >= 100) {
        navbar.classList.add("navbar-lewagon-white");
      } else {
        navbar.classList.remove("navbar-lewagon-white");
      }
    });
  }
};

export { initUpdateNavbarOnScroll };
