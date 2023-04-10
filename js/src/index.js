const ReactWellPlates = require("react-well-plates/lib-es/src/index");
const { InputAdapter } = require('@/shiny.react')

const MultiWellPicker = InputAdapter(ReactWellPlates.MultiWellPicker, (value, setValue) => ({
  value: value,
  onChange: setValue
}));

window.jsmodule = {
  ...window.jsmodule,
  'react-well-plates': ReactWellPlates,
  '@/shiny.wellplates': { MultiWellPicker },
};
