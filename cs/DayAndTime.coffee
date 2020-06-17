`
import React from 'react'
`

DayAndTime = ({time,children}) ->
  render: ->
    <div>
      <h1> {time} </h1>
      {children}
    </div>

export default DayAndTime
