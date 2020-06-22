`
import React, { Component } from 'react'
import { cloneDeep } from 'lodash'
import { DragDropContext } from 'react-beautiful-dnd'

import { decorateInitialData, initialState, updateState } from './utils'
import Error from './Error'
import Header from './Header'
import Menu from './Menu'
import PreferredTime from './PreferredTime'

import './App.css'
`

class App extends Component
  constructor: (props) ->
    super props
    @state = initialState

  handleFileLoaded: (data) =>
    @setState decorateInitialData data

  handleError: (data) =>
    @setState error: data

  onDragEnd: (result) =>
    @setState updateState result, cloneDeep @state

  render: ->
    <div className='App'>
      <Header/>
      <Menu
        handleFileLoaded={@handleFileLoaded}
        users={@state.users}
        newMeetingUserIds={@state.newMeetingUserIds}
        hasMovedUser={@state.hasMovedUser}/>
      { if @state.error.message
        <Error error={@state.error}/>
      }
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
