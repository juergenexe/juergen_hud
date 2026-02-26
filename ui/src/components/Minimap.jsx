import { useState } from "react";
import { useSelector } from "react-redux";
import { NuiEvent } from "../hooks/NuiEvent";
import { motion } from "framer-motion";
import { Mic, MousePointer2 } from "lucide-react";
import Fade from "../utils/Fade";

const Minimap = () => {
  const settings = useSelector((state) => state.settings);
  const [status, setStatus] = useState({ health: 100, armour: 100, hunger: 100, thirst: 100, voice: false });

  NuiEvent("status", (data) => setStatus(data));

  const spring = { type: "spring", stiffness: 60, damping: 15 };
  const pathLen = 100;
  const arcLen = 18;
  const gap = 82;

  return (
    <Fade in={settings.showminimap}>
      <div className="hud-container minimap-wrapper" style={{ transform: `scale(${settings.minimapsize / 50})` }}>
        <div className="glass-donut" />
        <div className="ring-features">
          <span />
          <span />
          <span />
          <span />
        </div>

        <svg className="svg-overlay" viewBox="0 0 100 100">
          <circle cx="50" cy="50" r="46" fill="none" stroke="var(--track-color)" strokeWidth="1.2" pathLength={pathLen} strokeDasharray={`${arcLen} ${gap}`} transform="rotate(188 50 50)" />
          <circle cx="50" cy="50" r="46" fill="none" stroke="var(--track-color)" strokeWidth="1.2" pathLength={pathLen} strokeDasharray={`${arcLen} ${gap}`} transform="rotate(279 50 50)" />
          {settings.minimapextrastatus && (
            <>
              <circle cx="50" cy="50" r="46" fill="none" stroke="var(--track-color)" strokeWidth="1.2" pathLength={pathLen} strokeDasharray={`${arcLen} ${gap}`} transform="rotate(8 50 50)" />
              <circle cx="50" cy="50" r="46" fill="none" stroke="var(--track-color)" strokeWidth="1.2" pathLength={pathLen} strokeDasharray={`${arcLen} ${gap}`} transform="rotate(99 50 50)" />
            </>
          )}

          <motion.circle
            cx="50"
            cy="50"
            r="46"
            fill="none"
            stroke="var(--neon-pink)"
            strokeWidth="2.8"
            strokeLinecap="round"
            pathLength={pathLen}
            strokeDasharray={`${(status.health / 100) * arcLen} ${pathLen}`}
            transition={spring}
            transform="rotate(188 50 50)"
            style={{ filter: "drop-shadow(0 0 4px var(--neon-pink))" }}
          />

          <motion.circle
            cx="50"
            cy="50"
            r="46"
            fill="none"
            stroke="var(--neon-cyan)"
            strokeWidth="2.8"
            strokeLinecap="round"
            pathLength={pathLen}
            strokeDasharray={`${(status.armour / 100) * arcLen} ${pathLen}`}
            transition={spring}
            transform="rotate(279 50 50)"
            style={{ filter: "drop-shadow(0 0 4px var(--neon-cyan))" }}
          />

          {settings.minimapextrastatus && (
            <motion.circle
              cx="50"
              cy="50"
              r="46"
              fill="none"
              stroke="var(--neon-lime)"
              strokeWidth="2.8"
              strokeLinecap="round"
              pathLength={pathLen}
              strokeDasharray={`${(status.hunger / 100) * arcLen} ${pathLen}`}
              transition={spring}
              transform="rotate(8 50 50)"
              style={{ filter: "drop-shadow(0 0 4px var(--neon-lime))" }}
            />
          )}

          {settings.minimapextrastatus && (
            <motion.circle
              cx="50"
              cy="50"
              r="46"
              fill="none"
              stroke="var(--neon-orange)"
              strokeWidth="2.8"
              strokeLinecap="round"
              pathLength={pathLen}
              strokeDasharray={`${(status.thirst / 100) * arcLen} ${pathLen}`}
              transition={spring}
              transform="rotate(99 50 50)"
              style={{ filter: "drop-shadow(0 0 4px var(--neon-orange))" }}
            />
          )}
        </svg>

        <div className="hud-badge alt" aria-label="alt-badge">
          <MousePointer2 size="1vw" color="#fff" />
          <div className="badge-key">ALT</div>
        </div>

        <div
          className="hud-badge mic"
          aria-label="mic-badge"
          style={{
            borderColor: status.voice ? "var(--neon-cyan)" : "rgba(255,255,255,0.15)",
            boxShadow: status.voice ? "0 0 1vw var(--neon-cyan)" : "none",
          }}
        >
          <Mic size="1vw" color={status.voice ? "var(--neon-cyan)" : "#fff"} />
          <div className="badge-key">N</div>
        </div>
      </div>
    </Fade>
  );
};

export default Minimap;
