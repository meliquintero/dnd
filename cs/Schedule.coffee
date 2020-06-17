`
import React from 'react'
import {map, keys} from 'lodash'
import UsersList from './UsersList';
import DayAndTime from './DayAndTime';

`

Schedule = ({users}) ->
  getUsersGroupedByTime: ->
    usersGroupedByTime = {}
    for user in users
      if not usersGroupedByTime[user.preferredMeetingTime]?
        usersGroupedByTime[user.preferredMeetingTime] = []
      usersGroupedByTime[user.preferredMeetingTime].push(user)

    usersGroupedByTime

  MeetingsList: ->
    usersGroupedByTime = @getUsersGroupedByTime()
    uniqTimes = keys(usersGroupedByTime)
    map(uniqTimes, (time) ->
      <DayAndTime time={time}>
        <UsersList users={usersGroupedByTime[time]}/>
      </DayAndTime>
    )

  render: ->
    <div className='meetings-list'>
      { @MeetingsList() }
    </div>

export default Schedule
