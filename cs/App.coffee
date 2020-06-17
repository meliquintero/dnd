`
import React, { Component } from 'react'
import CSVReader from 'react-csv-reader'
import './App.css'

import Schedule from './Schedule';
`

class App extends Component
  constructor: (props) ->
    super props
    @state =
      users: null

  handleFileLoaded: (data, fileInfo) =>
    @setState users: data

  papaparseOptions =
    header: true,
    skipEmptyLines: true,
    dynamicTyping: true

  render: ->
    <div className='App'>
      <h1>
        File Upload using React!
      </h1>
      <CSVReader onFileLoaded={@handleFileLoaded} parserOptions={papaparseOptions} />
      { if @state.users
        <Schedule users={@state.users} />
      }
    </div>

export default App
