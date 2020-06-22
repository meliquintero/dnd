`
import React from 'react'
`

Error = (props) ->
  render: ->
    <div className='ui purple icon message'>
      <i className='exclamation triangle icon'></i>
      <div className='content'>
        <div className='header'>
          Error
        </div>
        <p>{props.error.message}</p>
      </div>
    </div>

export default Error
