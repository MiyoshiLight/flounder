(function() {
  function setupFormBehavior() {
    const fileInput = document.querySelector(".file-input");
    const newPreview = document.getElementById("new-files-preview");
    const templateEl = document.getElementById("new-file-item-template");

    if (fileInput && newPreview && templateEl) {
      fileInput.addEventListener("change", function(e) {
        newPreview.innerHTML = "";
        const files = e.target.files;
        if (files.length > 0) {
          const templateText = newPreview.dataset.templateTitle;
          const titleText = templateText.replace("__count__", files.length);

          const title = document.createElement("div");
          title.className = "new-files-title";
          title.innerText = titleText;
          newPreview.appendChild(title);

          const grid = document.createElement("div");
          grid.className = "new-files-grid";

          Array.from(files).forEach(file => {
            let sizeText = "";
            if (file.size > 1024 * 1024) {
              sizeText = `${(file.size / (1024 * 1024)).toFixed(2)} MB`;
            } else {
              sizeText = `${(file.size / 1024).toFixed(1)} KB`;
            }

            const clone = templateEl.content.cloneNode(true);
            const nameEl = clone.querySelector(".new-file-name");
            nameEl.textContent = file.name;
            nameEl.setAttribute("title", file.name);
            clone.querySelector(".new-file-size").textContent = sizeText;
            grid.appendChild(clone);
          });
          newPreview.appendChild(grid);
        }
      });
    }

    const attachedSection = document.querySelector(".attached-files-section");
    const purgeContainer = document.getElementById("purge-fields-container");

    if (attachedSection && purgeContainer) {
      attachedSection.addEventListener("click", function(e) {
        const button = e.target.closest(".btn-toggle-delete");
        if (!button) return;

        e.preventDefault();
        const fileId = button.dataset.id;
        const fileItem = button.closest(".attached-file-item");

        if (fileItem) {
          const isMarked = fileItem.classList.toggle("marked-for-delete");
          
          if (isMarked) {
            const input = document.createElement("input");
            input.type = "hidden";
            input.name = "purge_file_ids[]";
            input.value = fileId;
            input.id = `purge-input-${fileId}`;
            purgeContainer.appendChild(input);
            
            button.title = button.dataset.titleUndo;
            button.classList.add("marked");
          } else {
            const input = document.getElementById(`purge-input-${fileId}`);
            if (input) input.remove();
            
            button.title = button.dataset.titleDelete;
            button.classList.remove("marked");
          }
        }
      });
    }
  }

  document.addEventListener("turbo:load", setupFormBehavior);
  if (document.readyState === "interactive" || document.readyState === "complete") {
    setupFormBehavior();
  } else {
    document.addEventListener("DOMContentLoaded", setupFormBehavior);
  }
})();
