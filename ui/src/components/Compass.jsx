import { useState, useEffect } from "react";
import { NuiEvent } from "../hooks/NuiEvent";
import { useSelector } from "react-redux";
import Fade from "../utils/fade";

const Compass = () => {
  const [compassvisible, SetCompassVisible] = useState(false);
  const [compass, setCompass] = useState({
    heading: 180,
    location1: 'Los Santos',
    location2: 'Legion Square'
  });

  const settings = useSelector((state) => state.settings);
  const visible = settings.showcompass ? compassvisible : false;

  useEffect(() => {
    if (visible) {
      const element = document.getElementById("compass");
      // The math controls the scroll offset based on player heading
      let scroll = -((2133 / -360) * compass.heading);
      element.scrollLeft = scroll;
    }
  });

  const handlevisible = (state) => {
    SetCompassVisible(state);
  };

  const handlecompass = (data) => {
    SetCompassVisible(true);
    setCompass(data);
  };

  NuiEvent("compass", handlecompass);
  NuiEvent("compassvisible", handlevisible);

  return (
    <>
      <Fade in={visible}>
        <div style={{ transform: `translate(-50%,0%) scale(${settings.compassize / 50})` }} className="compass-container">
          
          <div id="compass" className="compass retro-compass-mask">
            {/* 360 Degrees - Kept identical so your scroll math doesn't break */}
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">140</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">150</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">160</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">170</div></div>
            <div className="compassvalues"><div className="compassdir">S</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">190</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">200</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">210</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">220</div></div>
            <div className="compassvalues"><div className="compassdir sub-dir">SW</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">230</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">240</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">250</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">260</div></div>
            <div className="compassvalues"><div className="compassdir">W</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">280</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">290</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">300</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">310</div></div>
            <div className="compassvalues"><div className="compassdir sub-dir">NW</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">320</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">330</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">340</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">350</div></div>
            <div className="compassvalues"><div className="compassdir">N</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">10</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">20</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">30</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">40</div></div>
            <div className="compassvalues"><div className="compassdir sub-dir">NE</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">50</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">60</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">70</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">80</div></div>
            <div className="compassvalues"><div className="compassdir">E</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">100</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">110</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">120</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">130</div></div>
            <div className="compassvalues"><div className="compassdir sub-dir">SE</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">140</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">150</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">160</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">170</div></div>
            <div className="compassvalues"><div className="compassdir">S</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">190</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">200</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">210</div></div>
            <div className="compassvalues"><div className="compassbar"></div><div className="compasstext">220</div></div>
            <div className="compassvalues"><div className="compassdir sub-dir">SW</div></div>
          </div>

          <Fade in={settings.showstreet}>
            <div className="location-container retro-pill">
              <div className="location1">{compass.location1}</div>
              <div className="location-bar"></div>
              <div className="location2">{compass.location2}</div>
            </div>
          </Fade>
          
        </div>
      </Fade>
    </>
  );
};

export default Compass;