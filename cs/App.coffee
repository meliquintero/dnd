`
import React, { Component } from 'react'
import { cloneDeep } from 'lodash'
import { DragDropContext } from 'react-beautiful-dnd';

import { decorateInitialData, updatedState } from './utils';
import PreferredTime from './PreferredTime';
import Menu from './Menu';

import './App.css'
`

class App extends Component
  constructor: (props) ->
    super props
    @state =
      users: {}
      usersGroupedByTime: {}
      preferredTimes: []
      hasMovedUser: 0
      newMeetingUserIds: []

  handleFileLoaded: (data) =>
    @setState decorateInitialData(data)

  onDragEnd: (result) =>
    @setState updatedState(result, cloneDeep(@state))

  render: ->
    <div className='App'>
      <Menu
        handleFileLoaded={@handleFileLoaded}
        users={@state.users}
        newMeetingUserIds={@state.newMeetingUserIds}
        hasMovedUser={@state.hasMovedUser}/>

      { if @state.preferredTimes.length > 0
        <DragDropContext onDragEnd={@onDragEnd}>
          <PreferredTime
            users={@state.users}
            usersGroupedByTime={@state.usersGroupedByTime}
            preferredTimes={@state.preferredTimes}/>
        </DragDropContext>
      }
    </div>

export default App
