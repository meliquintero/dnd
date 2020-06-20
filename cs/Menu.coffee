`
import React, { Component } from 'react'
import CSVReader from 'react-csv-reader'
import {isEqual} from 'lodash'

import { papaparseOptions } from './utils';
import DownloadCSV from './DownloadCSV';
`

class Menu extends Component
  constructor: (props) ->
    super props

  shouldComponentUpdate: (nextProps, prevProps) =>
    not isEqual(nextProps.users, @props.users)

  handleFileLoaded: (data) =>
    @props.handleFileLoaded(data)

  render: ->
    <div className='ui large menu'>
      <div className='item'>
        <CSVReader
          onFileLoaded={@handleFileLoaded}
          parserOptions={papaparseOptions}/>
      </div>
      <div className='right item'>
      { if @props.hasMovedUser > 0
        <DownloadCSV users={@props.users}/>
      }
      </div>
    </div>

export default Menu
