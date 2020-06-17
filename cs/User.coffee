`
import React from 'react'
`

User = ({user}) ->
  console.log "user==>", user
  divStyle = {
    background: if user.fixed then 'blue'
  }
  
  render: ->
    <div className='card user' style={divStyle}>
      <div className='content'>
        <div>{user.id}</div>
        <div className='header'> {user.firstName} {user.lastName} </div>
        <div className='description'>{user.email} </div>
      </div>
    </div>

export default User
