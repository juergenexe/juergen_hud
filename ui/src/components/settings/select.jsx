import { React, useState } from "react";
import { nuicallback } from "../../utils/nuicallback";




const Select = (data) => {

  const handleinput = (state,option) => {

    nuicallback("settings",{option: option,value: state})
  };

  return (
    <>
      <div className='option'>
        <div>{data.title}</div>
        <div style={{color: '#88cfcd'}}  className='select-value'>
          <div
            onClick={() => handleinput(true,data.name)}
            style={{ opacity: data.value == true ? "100%" : "50%" }}
          >
            {data.option1}
          </div>
          <div
            onClick={() => handleinput(false,data.name)}
            style={{ opacity: data.value == false ? "100%" : "50%" }}
          >
           {data.option2}
          </div>
        </div>
      </div>
    </>
  );
};

export default Select;
