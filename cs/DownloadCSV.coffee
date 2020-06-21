`
import React, { Component } from 'react'
import { CSVLink } from 'react-csv'
import { values } from 'lodash'

import { button } from './styles';
`

class DownloadCSV extends Component
  constructor: (props) ->
    super props

  render: ->
    <CSVLink
      data={values(@props.users)}
      filename={'meeting-time.csv'}
      className='ui active button'
      style={button}
      target='_blank'>
      <i className='download icon'></i>
      Download updated CSV
    </CSVLink>

export default DownloadCSV
