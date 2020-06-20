`
import React, { Component } from 'react'
import { map, isEqual } from 'lodash'
import { Droppable } from 'react-beautiful-dnd';
import UsersList from './UsersList'
`

class PreferredTime extends Component
  constructor: (props) ->
    super props

  shouldComponentUpdate: (nextProps, prevProps) =>
    if isEqual(nextProps.usersGroupedByTime, @props.usersGroupedByTime)
      false
    else
      true

  droppableStyle = {border: "solid 3px green", transition: 'background-color 0.3s ease'}

  getPrefferedTimes: ({preferredTimes, usersGroupedByTime, users}) ->
    map(preferredTimes, (time, index) =>
      <Droppable
        key={time}
        type="TIMES"
        index={index}
        droppableId={time}>
        {(provided, snapshot) =>
          <div
            className="droppable"
            style={{background: (if snapshot.isDraggingOver then 'red'), ...droppableStyle}}
            ref={provided.innerRef}
            {...provided.droppabeProps }>
            <UsersList
              time={time}
              usersId={usersGroupedByTime[time].usersId}
              users={users}/>
            {provided.placeholder}
          </div>}
      </Droppable>
    )

  render: ->
    <div className='preferred-times-list'>
      { @getPrefferedTimes(@props) }
    </div>

export default PreferredTime
