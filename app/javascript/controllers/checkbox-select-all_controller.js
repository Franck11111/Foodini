import CheckboxSelectAll from "stimulus-checkbox-select-all";

export default class extends CheckboxSelectAll {
  connect() {
    super.connect();
    console.log("Do what you want here.");

    // Get all checked checkboxes
    this.checked;

    // Get all unchecked checkboxes
    this.unchecked;
  }
}
