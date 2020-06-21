`
import React, { Component } from 'react'
import moment from 'moment'
import ICalendarLink from 'react-icalendar-link'

import { button } from './styles';
`

class Calendar extends Component
  constructor: (props) ->
    super props
    @user1 = @props.newMeetingUserIds[0]
    @user2 = @props.newMeetingUserIds[1]

    @start = moment(@dateFormat(@user1.preferredMeetingTime))
    @end = moment(@dateFormat(@user1.preferredMeetingTime)).add(1, 'h')

  dateFormat: (date) ->
    [dayIndex, hourIndex, AmPmIndex] = [2, 4, 5]

    data = date.split(/[ ,]+/)
    data[dayIndex] = data[dayIndex].replace(/\D/g,'')
    time = data.splice(AmPmIndex, 1)
    if time[0].toUpperCase() is "PM"
      data[hourIndex] = parseInt(data[hourIndex]) + 12

    data[hourIndex] += ':00'
    data.join(' ')

  event: ->
    title: 'Peer coaching kickoff event',
    description: "Welcome #{@user1.firstName} (#{@user1.email})
      and #{@user2.firstName} (#{@user2.email}). \n
      You both have been matched for a peer coaching conversation
      kickoff event at #{@props.time}. \n
      Please visit the following page to start the conversation:
      https://app.imperative.com/start",
    startTime: @start.format(),
    endTime: @end.format(),
    location: 'https://app.imperative.com/start'

  render: ->
    <ICalendarLink
      className='ui active button'
      style={button}
      event={@event()}>
      Add to Calendar
    </ICalendarLink>

export default Calendar
