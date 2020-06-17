`
import React from 'react'
import {map} from 'lodash'
import User from './User';
`

UserList = ({users}) ->
  UsersData =
    map(users, (user) ->
      <User user={user}/>
    )

  render: ->
    <div className='ui cards users-list'>
      { UsersData }
    </div>

export default UserList
