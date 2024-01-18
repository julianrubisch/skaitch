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
