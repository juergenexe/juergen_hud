import React, { useRef } from "react"
import { CSSTransition } from "react-transition-group"

const Fade = props => {
  const nodeRef = useRef(null)

  return (
    <CSSTransition
      in={props.in}
      nodeRef={nodeRef}
      classNames="transition-fade"
      timeout={200}
      unmountOnExit
    >
      <div ref={nodeRef} className="fade-slot">{props.children}</div>
    </CSSTransition>
  )
}

export default Fade