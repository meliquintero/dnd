`
import React, { Component } from 'react'
import CSVReader from 'react-csv-reader'
import './App.css'
import { clone } from 'lodash'
import { DragDropContext } from 'react-beautiful-dnd';
import PreferredTime from './PreferredTime';
import { decorateData, papaparseOptions } from './utils';
`

class App extends Component
  constructor: (props) ->
    super props
    @state =
      users: {}
      usersGroupedByTime: {}
      preferredTimes: []

  handleFileLoaded: (data, fileInfo) =>
    @setState decorateData(data)

  onDragEnd: (result) =>
    {source, destination, draggableId} = result
    if not destination?
      return
    if destination.droppableId is source.droppableId and destination.index is source.index
      return

    start = @state.usersGroupedByTime[source.droppableId]
    sourceUserIds = clone(start.usersId)
    sourceUserIds.splice(source.index, 1)

    if destination.droppableId is source.droppableId
      sourceUserIds.splice(destination.index, 0, draggableId)
      newStartTime = {...start, usersId: sourceUserIds}

      newState = {
        ...@state,
        usersGroupedByTime: {
          ...@state.usersGroupedByTime,
          [newStartTime.id]: newStartTime
        }
      }
      @setState newState
    else
      newStartTime = {...start, usersId: sourceUserIds}

      newUser = clone(@state.users[draggableId])
      newUser.preferredMeetingTime = destination.droppableId

      end = @state.usersGroupedByTime[destination.droppableId]
      destinationUserIds = clone(end.usersId)
      destinationUserIds.splice(destination.index, 0, draggableId)
      newEndTime = {...end, usersId: destinationUserIds}
      newState = {
        ...@state,
        users: {
          ...@state.users,
          [newUser.id]: newUser
        }
        usersGroupedByTime: {
          ...@state.usersGroupedByTime,
          [newStartTime.id]: newStartTime
          [newEndTime.id]: newEndTime
        }
      }
      @setState newState

  render: ->
    <div className='App'>
      <h1>
        File Upload using React!
      </h1>
      <CSVReader onFileLoaded={@handleFileLoaded} parserOptions={papaparseOptions} />
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
