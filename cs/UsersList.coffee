`
import React, { Component } from 'react'
import { map } from 'lodash'
import { Draggable } from 'react-beautiful-dnd'
import { fixedCard, dragging } from './styles'
`

class UserList extends Component
  constructor: (props) ->
    super props

  UsersData: ({time, usersId, users}) ->
    map(usersId, (userId, index) =>
      user = users[userId]
      <Draggable
        key={user.id}
        draggableId={user.id}
        index={index}
        isDragDisabled={user.fixed}>
        {(provided, snapshot) =>
          cardStyle = if user.fixed then fixedCard else if snapshot.isDragging then dragging
          <div
            key={user.id}
            {...provided.draggableProps }
            {...provided.dragHandleProps }
            ref={provided.innerRef}
            className='ui card'>
            {if user.fixed
              <a className='ui right corner label'>
                <i className='lock icon'></i>
              </a>
            }
            <div
              className='content'
              style={cardStyle}>
              <div className='header' style={cardStyle} >
                {user.firstName} {user.lastName}
              </div>
              <div className='description' style={cardStyle}>
                {user.email}
              </div>
            </div>
          </div>
        }
      </Draggable>
    )

  render: ->
    <div className='ui cards'>
      { @UsersData(@props) }
    </div>

export default UserList
