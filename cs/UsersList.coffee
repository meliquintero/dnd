`
import React from 'react'
import {map} from 'lodash'
import { Draggable} from 'react-beautiful-dnd';
`

UserList = ({users, time}) ->
  UsersData = map(users, (user, index) ->
    <Draggable
      key={user.id}
      draggableId={user.id}
      index={index}
      isDragDisabled={user.fixed}>
      {(provided, snapshot) =>
        style={background: if user.fixed then 'green'}
        <div
          key={user.id}
          {...provided.draggableProps }
          {...provided.dragHandleProps }
          ref={provided.innerRef}
          className='card user'>
          <div
            className='content'
            style={{background: (if snapshot.isDragging then 'blue'), ...style}}>
            <div>{user.id}</div>
            <div className='header'> {user.firstName} {user.lastName} </div>
            <div className='description'>{user.email} </div>
          </div>
        </div>
      }
    </Draggable>
  )

  render: ->
    <div className='ui cards users-list'>
      { UsersData }
    </div>

export default UserList
