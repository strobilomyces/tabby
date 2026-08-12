// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//
// If you have dependencies that try to import CSS, esbuild will generate a separate `app.css` file.
// To load it, simply add a second `<link>` to your `root.html.heex` file.

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import {hooks as colocatedHooks} from "phoenix-colocated/tabby"
import topbar from "../vendor/topbar"

const DropdownDisplay = {
  mounted: function() {
    var self = this;
    this.buttonText = this.el.querySelector('.selected-display-text');
    this.searchInput = this.el.querySelector('.dropdown-search-input');
    this.items = Array.from(this.el.querySelectorAll('.dropdown-item-row'));
    this.searchTimeout = null;
    
    var cleanId = this.el.id.replace('dropdown-wrapper-', '');
    this.menuElement = document.getElementById('menu-' + cleanId);
    
    this.el.addEventListener('change', function(e) {
      if (e.target.type === 'checkbox') {
        self.updateButtonText();
        self.resetSearchField();
      }
    });

    if (this.searchInput) {
      this.searchInput.addEventListener('input', function(e) {
        var value = e.target.value.trim();

        if (value.length === 0) {
          clearTimeout(self.searchTimeout);
          if (self.menuElement) self.menuElement.classList.add('hidden');
          self.resetAllRows();
          return;
        }

        if (self.menuElement && self.menuElement.classList.contains('hidden')) {
          self.menuElement.classList.remove('hidden');
        }

        clearTimeout(self.searchTimeout);
        self.searchTimeout = setTimeout(function() {
          self.filterOptions(value);
        }, 250);
      });
    }
  },

  updateButtonText: function() {
    if (!this.buttonText || !this.searchInput) return;

    var checkedBoxes = Array.from(this.el.querySelectorAll('input[type="checkbox"]:checked'));
    
    if (checkedBoxes.length === 0) {
      this.buttonText.textContent = "";
      this.searchInput.placeholder = "Search artists...";
      return;
    }

    var selectedNames = checkedBoxes.map(function(checkbox) {
      return checkbox.closest('label').querySelector('.item-label-text').textContent.trim();
    });

    this.buttonText.textContent = selectedNames.join(", ");
    this.searchInput.placeholder = "";
  },

  filterOptions: function(searchTerm) {
    if (!this.menuElement) return;

    var cleanTerm = searchTerm.toLowerCase().trim();
    var visibleCount = 0;

    this.items.forEach(function(item) {
      var labelText = item.querySelector('.item-label-text').textContent.toLowerCase().trim();
      
      if (labelText.indexOf(cleanTerm) === 0) { // Equivalent to startsWith
        item.style.display = 'flex';
        visibleCount++;
      } else {
        item.style.display = 'none';
      }
    });

    if (visibleCount === 0 && this.menuElement) {
      this.menuElement.classList.add('hidden');
    }
  },

  resetSearchField: function() {
    if (this.searchInput) {
      this.searchInput.value = "";
    }
    clearTimeout(this.searchTimeout);
    this.resetAllRows();
  },

  resetAllRows: function() {
    this.items.forEach(function(item) {
      item.style.display = 'flex';
    });
  }
};




const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
const liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: {...colocatedHooks, DropdownDisplay},
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

// The lines below enable quality of life phoenix_live_reload
// development features:
//
//     1. stream server logs to the browser console
//     2. click on elements to jump to their definitions in your code editor
//
if (process.env.NODE_ENV === "development") {
  window.addEventListener("phx:live_reload:attached", ({detail: reloader}) => {
    // Enable server log streaming to client.
    // Disable with reloader.disableServerLogs()
    reloader.enableServerLogs()

    // Open configured PLUG_EDITOR at file:line of the clicked element's HEEx component
    //
    //   * click with "c" key pressed to open at caller location
    //   * click with "d" key pressed to open at function component definition location
    let keyDown
    window.addEventListener("keydown", e => keyDown = e.key)
    window.addEventListener("keyup", _e => keyDown = null)
    window.addEventListener("click", e => {
      if(keyDown === "c"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtCaller(e.target)
      } else if(keyDown === "d"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtDef(e.target)
      }
    }, true)

    window.liveReloader = reloader
  })
}

