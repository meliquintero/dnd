`
import React, { Component } from 'react'
import { map } from 'lodash'
import { Draggable } from 'react-beautiful-dnd';
`

class UserList extends Component
  constructor: (props) ->
    super props

  UsersData: ({time, usersId, users}) ->
    map(usersId, (userId, index) =>
      console.log "INEES", index
      <Draggable
        key={users[userId].id}
        draggableId={users[userId].id}
        index={index}
        isDragDisabled={users[userId].fixed}>
        {(provided, snapshot) =>
          userType = if users[userId].fixed then 'gray' else 'none'
          <div
            key={users[userId].id}
            {...provided.draggableProps }
            {...provided.dragHandleProps }
            ref={provided.innerRef}
            className='card user'>
            <div
              className='content'
              style={{background: (if snapshot.isDragging then 'blue' else userType)}}>
              <div>{users[userId].id}</div>
              <div className='header'> {users[userId].firstName} {users[userId].lastName} </div>
              <div className='description'>{users[userId].email} </div>
            </div>
          </div>
        }
      </Draggable>
    )

  render: ->
    <div className='ui cards users-list'>
      { @UsersData(@props) }
    </div>

export default UserList
