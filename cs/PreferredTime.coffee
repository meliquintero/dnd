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
    not isEqual(nextProps.usersGroupedByTime, @props.usersGroupedByTime)

  droppableStyle = { transition: 'background-color 0.3s ease'}

  getPrefferedTimes: ({preferredTimes, usersGroupedByTime, users}) ->
    map(preferredTimes, (time, index) =>
      <div key={time} className='column'>
        <h2> {time} </h2>
        <Droppable
          type='TIMES'
          index={index}
          droppableId={time}>
          {(provided, snapshot) =>
            <div
              className='droppable'
              style={{background: (if snapshot.isDraggingOver then '#F08080'), ...droppableStyle}}
              ref={provided.innerRef}
              {...provided.droppabeProps }>
              <UsersList
                time={time}
                usersId={usersGroupedByTime[time]}
                users={users}/>
              {provided.placeholder}
            </div>}
        </Droppable>
      </div>
    )

  render: ->
    <div className='ui three column grid'>
      { @getPrefferedTimes(@props) }
    </div>

export default PreferredTime
