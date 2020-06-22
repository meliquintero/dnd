`
import React, { Component } from 'react'
import { map, isEqual } from 'lodash'
import { Droppable } from 'react-beautiful-dnd'

import UsersList from './UsersList'
import { column, droppable, section } from './styles'
`

class PreferredTime extends Component
  constructor: (props) ->
    super props

  shouldComponentUpdate: (nextProps, prevProps) =>
    not isEqual(nextProps.usersGroupedByTime, @props.usersGroupedByTime)

  getPrefferedTimes: ({preferredTimes, usersGroupedByTime, users}) ->
    map(preferredTimes, (time, index) =>
      <div
        key={time}
        className='column'
        style={column}>
        <h3> {time} </h3>
        <Droppable
          index={index}
          droppableId={time}>
          {(provided, snapshot) =>
            <div
              className='droppable'
              style={(if snapshot.isDraggingOver then droppable)}
              ref={provided.innerRef}
              {...provided.droppabeProps }>
              <UsersList
                time={time}
                usersId={usersGroupedByTime[time].userIds}
                users={users}/>
              {provided.placeholder}
            </div>}
        </Droppable>
      </div>
    )

  render: ->
    <div className='ui three column grid' style={section}>
      { @getPrefferedTimes(@props) }
    </div>

export default PreferredTime
