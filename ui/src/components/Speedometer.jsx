import { useState, useEffect, useRef } from "react";
import { useSelector } from "react-redux";
import { NuiEvent } from "../hooks/NuiEvent";
import { motion } from "framer-motion";
import { RouteOff } from "lucide-react";
import Fade from "../utils/Fade";
import alarmfile from "../assets/sound/alarm.mp3";

const Speedometer = () => {
  const audioelement = useRef();
  const settings = useSelector((state) => state.settings);
  const [vehicle, setVehicle] = useState({ show: false, speed: 0, rpm: 0, fuel: 0, gear: 0, seatbelt: true, class: 0 });

  NuiEvent("speedometer", (data) => setVehicle(data));

  const visible = settings.showspeedometer ? vehicle.show : false;
  const spring = { type: "spring", stiffness: 80, damping: 20 };

  let rawRpm = 300 / (vehicle.rpm || 1) / 4;
  if (rawRpm < 81) rawRpm = 80;
  if (rawRpm > 300) rawRpm = 300;
  const rpmPercent = ((300 - rawRpm) / (300 - 80)); 

  useEffect(() => {
    if (visible && !vehicle.seatbelt && settings.seatbeltalarm && vehicle.class !== 8) {
      audioelement.current?.play();
    }
  }, [visible, vehicle.seatbelt, settings.seatbeltalarm, vehicle.class]);

  return (
    <>
      <Fade in={visible}>
        <div className={`hud-container speedo-wrapper`} style={{ transform: `scale(${settings.speedometersize / 50})` }}>
          
          {/* Solid glass circle behind the speed text */}
          <div className="glass-circle" />

          <svg className="svg-overlay" viewBox="0 0 100 100">
            {/* RPM Track (Outer) */}
            <circle cx="50" cy="50" r="46" fill="none" stroke="var(--track-color)" strokeWidth="1.5" pathLength="100" strokeDasharray="75 25" strokeLinecap="round" transform="rotate(135 50 50)" />
            {/* Fuel Track (Inner) */}
            {vehicle.class !== 13 && vehicle.class !== 16 && (
              <circle cx="50" cy="50" r="41" fill="none" stroke="var(--track-color)" strokeWidth="1.5" pathLength="100" strokeDasharray="75 25" strokeLinecap="round" transform="rotate(135 50 50)" />
            )}

            {/* RPM Neon */}
            <motion.circle cx="50" cy="50" r="46" fill="none" stroke="var(--neon-pink)" strokeWidth="3" strokeLinecap="round" pathLength="100"
              strokeDasharray={`${rpmPercent * 75} 100`}
              transition={{ type: "tween", ease: "linear", duration: 0.1 }} 
              transform="rotate(135 50 50)"
              style={{ filter: 'drop-shadow(0 0 4px var(--neon-pink))' }} />

            {/* Fuel Neon */}
            {vehicle.class !== 13 && vehicle.class !== 16 && (
              <motion.circle cx="50" cy="50" r="41" fill="none" stroke="var(--neon-orange)" strokeWidth="2.5" strokeLinecap="round" pathLength="100"
                strokeDasharray={`${(vehicle.fuel / 100) * 75} 100`}
                transition={spring} 
                transform="rotate(135 50 50)" />
            )}
          </svg>

          <div className="speed-center">
            <div className="speed-unit">{settings.mphkmh ? "MPH" : "KMH"}</div>
            <div className="speed-val">
              {vehicle.speed.toString().padStart(3, '0').split('').map((char, i) => (
                <span key={i} className={char === '0' && i === 0 && vehicle.speed < 100 ? 'dim-digit' : ''}>{char}</span>
              ))}
            </div>
            {vehicle.class !== 13 && vehicle.class !== 16 && (
              <div className="gear-box">GEAR {vehicle.gear === 0 ? "R" : vehicle.gear}</div>
            )}
          </div>

          {!vehicle.seatbelt && vehicle.class !== 8 && (
            <motion.div className="hud-badge seatbelt-badge"
              animate={{ borderColor: ['#ff0000', 'rgba(255,255,255,0.15)', '#ff0000'] }}
              transition={{ repeat: Infinity, duration: 0.8 }}>
              <RouteOff size="1vw" color="#ff0000" />
            </motion.div>
          )}

        </div>
      </Fade>
      <audio ref={audioelement} id="alarm" src={alarmfile} loop />
    </>
  );
};

export default Speedometer;