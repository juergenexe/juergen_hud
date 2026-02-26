import { useMemo, useState } from "react";
import { NuiEvent } from "../hooks/NuiEvent";
import { useSelector } from "react-redux";
import Fade from "../utils/Fade";
import { MoonStar } from "lucide-react";

const DIRECTIONS = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"];

const Compass = () => {
  const [compassvisible, setCompassVisible] = useState(false);
  const [compass, setCompass] = useState({
    heading: 180,
    location1: "Los Santos",
    location2: "Legion Square",
    hours: null,
    minutes: null,
  });

  const settings = useSelector((state) => state.settings);
  const visible = settings.showcompass ? compassvisible : false;

  NuiEvent("compass", (data) => {
    setCompassVisible(true);
    setCompass((prev) => ({ ...prev, ...data }));
  });

  NuiEvent("compassvisible", (state) => setCompassVisible(state));

  const heading = ((compass.heading % 360) + 360) % 360;
  const direction = DIRECTIONS[Math.round(heading / 45) % 8];

  const hudTime = useMemo(() => {
    if (typeof compass.hours === "number" && typeof compass.minutes === "number") {
      return `${String(compass.hours).padStart(2, "0")}:${String(compass.minutes).padStart(2, "0")}`;
    }

    const now = new Date();
    return `${String(now.getHours()).padStart(2, "0")}:${String(now.getMinutes()).padStart(2, "0")}`;
  }, [compass.hours, compass.minutes]);

  return (
    <Fade in={visible}>
      <div className="compass-dock" style={{ transform: `scale(${settings.compassize / 50})` }}>
        <div className="retro-chip heading-chip">
          <span className="heading-main">{direction}</span>
          <span className="heading-degree">{Math.round(heading)}°</span>
        </div>

        <Fade in={settings.showstreet}>
          <div className="retro-chip location-chip">
            <div className="time-row">
              <MoonStar size="1vw" />
              <span>{hudTime}</span>
            </div>
            <div className="location-primary">{compass.location1}</div>
            <div className="location-secondary">{compass.location2}</div>
          </div>
        </Fade>
      </div>
    </Fade>
  );
};

export default Compass;
