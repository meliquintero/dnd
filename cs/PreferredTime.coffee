`
import React from 'react'
import {map} from 'lodash'
import {Droppable} from 'react-beautiful-dnd';
import UsersList from './UsersList'
`

PreferredTime = ({usersGroupedByTime, users, preferredTimes}) ->
  if preferredTimes.length <= 0
    return
  droppableStyle = {border: "solid 3px green", transition: 'background-color 0.3s ease'}
  ScheludeData = map(preferredTimes, (time, index) ->
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
          <UsersList time={time} users={map(usersGroupedByTime[time].usersId, (userId) -> users[userId])}/>
          {provided.placeholder}
        </div>}
    </Droppable>
  )

  render: ->
    <div className='preferred-times-list'>
      { ScheludeData }
    </div>

export default PreferredTime
