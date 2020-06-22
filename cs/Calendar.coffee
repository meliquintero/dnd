`
import React, { Component } from 'react'
import { isEqual } from 'lodash'
import moment from 'moment'
import ICalendarLink from 'react-icalendar-link'

import { button } from './styles'
import { parseDate } from './utils'
`

class Calendar extends Component
  constructor: (props) ->
    super props

  shouldComponentUpdate: (nextProps, prevProps) =>
    not isEqual(nextProps.newMeetingUserIds, @props.newMeetingUserIds)

  event: ({newMeetingUserIds})->
    user1 = newMeetingUserIds[0]
    user2 = newMeetingUserIds[1]

    start = moment(parseDate(user1.preferredMeetingTime))
    end = moment(parseDate(user1.preferredMeetingTime)).add(1, 'h')

    title: 'Peer coaching kickoff event',
    description: "Welcome #{user1.firstName} (#{user1.email})
      and #{user2.firstName} (#{user2.email}). \n
      You both have been matched for a peer coaching conversation
      kickoff event at #{user1.preferredMeetingTime}. \n
      Please visit the following page to start the conversation:
      https://app.imperative.com/start",
    startTime: start.format(),
    endTime: end.format(),
    location: 'https://app.imperative.com/start'

  render: ->
    <ICalendarLink
      className='ui active button'
      style={button}
      event={@event(@props)}>
      Add to Calendar
    </ICalendarLink>

export default Calendar
