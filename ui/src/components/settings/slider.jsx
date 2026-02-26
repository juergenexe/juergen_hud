import { React, useState } from "react";
import { nuicallback } from "../../utils/nuicallback";
import RangeSlider from 'react-range-slider-input';
import 'react-range-slider-input/dist/style.css';
import reseticon from '../../assets/images/reset.png'

const Sliders = (data) => {

    const handleinput = (event) => {
        let value = event[1]
        nuicallback("settings",{option: data.name,value: value})
    };





  return (
    <>
      <div className='option'>
        <div>{data.title}</div>
        <div style={{width: '10vw'}} className='range-container'>
        <div>{data.value}</div>
        <div className="slider">
        <img onClick={() => setinput(data.value)} className="fas" src={reseticon} alt="" />
       <RangeSlider className="single-thumb"   id="slider"  value={[0,data.value]} onInput={handleinput}    defaultValue={[0, data.value]}    rangeSlideDisabled={true}     thumbsDisabled={[true, false]} />
       </div>
        </div>
      </div>
    </>
  );
};

export default Sliders;
