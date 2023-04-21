const ReactWellPlates = require("react-well-plates/lib-es/src/index");
const { useState } = require('react');
const { InputAdapter } = require('@/shiny.react')

const MultiWellPicker = InputAdapter(ReactWellPlates.MultiWellPicker, (value, setValue) => ({
  value: value,
  onChange: setValue
}));

function ColorfullWellPickerFun({value, onChange, rows, columns, colors, ...props}) {
  const wellPickerStyle = ({ index, booked, disabled, selected, wellPlate }) => {
    let styles = {};
    styles.borderColor = 'grey';
    if (booked) {
      styles.borderColor = 'orange';
    }
    if (disabled) {
      styles.backgroundColor = 'lightgray';
    }
    if (selected) {
      styles.borderColor = 'orange';
      styles.backgroundColor = 'lightgreen';
    } else {
      styles.backgroundColor = colors[index];
    }
    return styles;
  };

  const wellPickerText = ({index, label, wellPlate, booked, position, selected, disabled}) => {
    return null;
  };
  const wellpicker = ReactWellPlates.MultiWellPicker({
    value: value,
    onChange: onChange,
    rows: rows,
    columns: columns,
    style: wellPickerStyle,
    renderText: wellPickerText,
    ...props
  }
  );
  return wellpicker;
}

const ColorfullWellPicker = InputAdapter(ColorfullWellPickerFun, (value, setValue) => ({
  value: value,
  onChange: setValue
}));

window.jsmodule = {
  ...window.jsmodule,
  'react-well-plates': ReactWellPlates,
  '@/shiny.wellplates': { MultiWellPicker, ColorfullWellPicker },
};
