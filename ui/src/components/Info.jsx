import { React, useState, useEffect } from "react";
import Fade from "../utils/Fade";
import { NuiEvent } from "../hooks/NuiEvent";
import { useSelector } from "react-redux";
import AnimatedNumber from "animated-number-react";


const Info = () => {
  const [info, setInfo] = useState({
    bank: 2000,
    cash: 140,
    job: "Police - Officer",
    show: {
      bank: true,
      cash: true,
      job: true,
    }
  });

  const settings = useSelector((state) => state.settings);

  const handleinfo = (data) => {
    setInfo(data);
  };
  NuiEvent("info", handleinfo);


  const formatValue = (value) => value.toFixed(0);
  

  return (
    <>
      <Fade in={settings.showinfo}>
        <div class="info-wrapper">
          <div class="info-container">

            <Fade in={settings.dynamicinfo ? info.show.bank : true}>
            <div class="bank">
              <span>$</span>
              <AnimatedNumber formatValue={formatValue} value={info.bank}/>
            </div>
            </Fade>

            <Fade in={settings.dynamicinfo ? info.show.cash : true}>
            <div class="cash">
              <span>$</span>
              <AnimatedNumber formatValue={formatValue} value={info.cash}/>
            </div>
            </Fade>

            <Fade in={settings.dynamicinfo ? info.show.job : true}>
            <div class="job">
              <span id="job">{info.job}</span>
            </div>
            </Fade>

          </div>
        </div>
      </Fade>
    </>
  );
};

export default Info;
