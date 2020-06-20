`
import {keys} from 'lodash'
`

decorateData = (data) ->
  usersGroupedByTime = {}
  users = {}
  for user in data
    users[user.id] = user
    if not usersGroupedByTime[user.preferredMeetingTime]?
      usersGroupedByTime[user.preferredMeetingTime] = {
        id: user.preferredMeetingTime
        title: user.preferredMeetingTime,
        usersId: []
      }
    usersGroupedByTime[user.preferredMeetingTime].usersId.push(user.id)

  preferredTimes = keys(usersGroupedByTime)

  {usersGroupedByTime, users, preferredTimes}

papaparseOptions =
  header: true
  skipEmptyLines: true
  dynamicTyping: true


export {papaparseOptions, decorateData}
