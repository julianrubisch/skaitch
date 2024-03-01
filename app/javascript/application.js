// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import "trix";
import "@rails/actiontext";

import { setBasePath } from "@shoelace-style/shoelace";

setBasePath("/");

document
  .querySelector("sl-input[name=search]")
  .addEventListener("keyup", (event) => {
    document.querySelector(
      "#prompts"
    ).src = `/prompts?query=${encodeURIComponent(event.target.value)}`;
  });

document
  .querySelector("turbo-frame#prompts")
  .addEventListener("turbo:before-frame-render", (event) => {
    event.preventDefault();

    const newHTML = event.detail.newFrame.innerHTML;

    const query = document.querySelector("sl-input[name=search]").value;
    if (!!query) {
      event.detail.newFrame.innerHTML = newHTML.replace(
        new RegExp(`(${query})`, "ig"),
        "<em>$1</em>"
      );
    }

    event.detail.resume();
  });
