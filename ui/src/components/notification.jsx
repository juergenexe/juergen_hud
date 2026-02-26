import { useState } from "react";
import { NuiEvent } from "../hooks/NuiEvent";

function Notifications() {
  const [Data, setData] = useState(false);

  NuiEvent('notification', (message) => {
    setData(message);
    setTimeout(() => {
      setData(false);
    }, message.duration);
  });

  return (
    Data && (
      <div className="notification-wrapper">
        <div className="notification-container retro-panel">
          
          <div className="notification-icon neon-icon-ring">
            <span className="material-symbols-outlined">
              {Data.icon ? Data.icon : 'info'}
            </span>
          </div>

          <div className="notification-content">
            <div className="notification-title">{Data.title}</div>
            <div className="notification-description">{Data.description}</div>
          </div>

        </div>
      </div>
    )
  );
}

export default Notifications;