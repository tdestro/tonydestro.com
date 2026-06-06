document.documentElement.classList.add("js");

const filterButtons = document.querySelectorAll("[data-filter]");
const cards = document.querySelectorAll("[data-tags]");

filterButtons.forEach((button) => {
  button.addEventListener("click", () => {
    const filter = button.dataset.filter;

    filterButtons.forEach((item) => item.classList.remove("active"));
    button.classList.add("active");

    cards.forEach((card) => {
      const tags = card.dataset.tags.split("||");
      card.hidden = filter !== "all" && !tags.includes(filter);
    });
  });
});

document.querySelectorAll("[data-lightbox]").forEach((button) => {
  button.addEventListener("click", () => {
    const source = button.dataset.lightbox;
    const overlay = document.createElement("div");
    overlay.className = "lightbox";
    overlay.innerHTML = `
      <button type="button" aria-label="Close image">Close</button>
      <img src="${source}" alt="">
    `;
    overlay.addEventListener("click", () => overlay.remove());
    overlay.querySelector("button").addEventListener("click", (event) => {
      event.stopPropagation();
      overlay.remove();
    });
    document.body.appendChild(overlay);
  });
});

document.addEventListener("keydown", (event) => {
  if (event.key === "Escape") {
    document.querySelector(".lightbox")?.remove();
  }
});

window.addEventListener("load", () => {
  const target = window.location.hash ? document.querySelector(window.location.hash) : null;
  target?.scrollIntoView({ block: "start", behavior: "auto" });
});

const revealTargets = document.querySelectorAll(
  ".page-header, .section-heading, .focus-card, .delivery-card, .source-card, .project-card, .timeline article, .contact-card, .evidence-card, .project-hero-image"
);

revealTargets.forEach((target) => target.setAttribute("data-reveal", ""));

if ("IntersectionObserver" in window) {
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-visible");
          observer.unobserve(entry.target);
        }
      });
    },
    { rootMargin: "0px 0px -12% 0px", threshold: 0.12 }
  );

  revealTargets.forEach((target) => observer.observe(target));
} else {
  revealTargets.forEach((target) => target.classList.add("is-visible"));
}
