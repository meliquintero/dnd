`
import React, { Component } from 'react'
import { CSVLink } from 'react-csv'
import { values } from 'lodash'
`

class DownloadCSV extends Component
  constructor: (props) ->
    super props

  render: ->
    <CSVLink
      data={values(@props.users)}
      filename={'meeting-time.csv'}
      className='ui active button'
      target='_blank'>
      <i className='download icon'></i>
      Download updated CSV
    </CSVLink>

export default DownloadCSV
