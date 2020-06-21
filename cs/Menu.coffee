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

  getUsers: (users, newUserIds) =>
    map(newUserIds, (userId) -> users[userId])

  handleFileLoaded: (data) =>
    @props.handleFileLoaded(data)

  render: ->
    <div className='ui large menu'>
      <div className='item'>
        <CSVReader
          onFileLoaded={@handleFileLoaded}
          parserOptions={papaparseOptions}/>
      </div>
      { if @props.newMeetingUserIds.length >= 2
        <div className='item'>
          <Calendar newMeetingUserIds={@getUsers(@props.users, @props.newMeetingUserIds)}/>
        </div>
      }
      <div className='right item'>
      { if @props.hasMovedUser > 0
        <DownloadCSV users={@props.users}/>
      }
      </div>
    </div>

export default Menu
