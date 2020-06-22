`
import React, { Component } from 'react'
import CSVReader from 'react-csv-reader'
import {isEqual, map} from 'lodash'

import { papaparseOptions } from './utils';
import DownloadCSV from './DownloadCSV';
import Calendar from './Calendar';
`

class Menu extends Component
  constructor: (props) ->
    super props

  shouldComponentUpdate: (nextProps, prevProps) =>
    not isEqual(nextProps.users, @props.users) or not isEqual(nextProps.newMeetingUserIds, @props.newMeetingUserIds)

  getUsers: ({users, newMeetingUserIds}) =>
    console.log "newMeetingUserIds", newMeetingUserIds
    map(newMeetingUserIds, (userId) -> users[userId])

  handleFileLoaded: (data) =>
    @props.handleFileLoaded(data)

  render: ->
    <div className='ui huge menu'>
      <div className='item'>
        <CSVReader
          onFileLoaded={@handleFileLoaded}
          parserOptions={papaparseOptions}/>
      </div>
      <div className='right menu'>
      { if @props.newMeetingUserIds.length >= 2
        <div className='right item'>
          <Calendar newMeetingUserIds={@getUsers(@props)}/>
        </div>
      }
      { if @props.hasMovedUser > 0
        <div className='right item'>
          <DownloadCSV users={@props.users}/>
          </div>
      }
      </div>
    </div>

export default Menu
