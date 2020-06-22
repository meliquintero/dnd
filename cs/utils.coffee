`
import {keys} from 'lodash'
`

updateState = ({source, destination, draggableId}, state) ->
  if not destination?
    return
  if destination.droppableId is source.droppableId and destination.index is source.index
    return

  startUserIdsOrder = state.usersGroupedByTime[source.droppableId].userIds
  startUserIdsOrder.splice(source.index, 1)

  if destination.droppableId is source.droppableId
    startUserIdsOrder.splice(destination.index, 0, draggableId)

  else
    state.users[draggableId].preferredMeetingTime = destination.droppableId
    state.hasMovedUser++

    destinationtUserIdsOrder = state.usersGroupedByTime[destination.droppableId].userIds
    destinationtUserIdsOrder.splice(destination.index, 0, draggableId)

  state.usersGroupedByTime[destination.droppableId].newMeetingUserIds.push(draggableId)

  if  state.usersGroupedByTime[destination.droppableId].newMeetingUserIds.length >= 2
    state.newMeetingUserIds = state.usersGroupedByTime[destination.droppableId].newMeetingUserIds.slice(-2)

  state

decorateInitialData = (data) ->
  usersGroupedByTime = {}
  users = {}
  for user in data
    user.fixed ?= false
    users[user.id] = user

    if not usersGroupedByTime[user.preferredMeetingTime]?
      usersGroupedByTime[user.preferredMeetingTime] = {
        userIds: []
        newMeetingUserIds: []
      }

    usersGroupedByTime[user.preferredMeetingTime].userIds.push(user.id)

  preferredTimes = keys(usersGroupedByTime)

  {usersGroupedByTime, users, preferredTimes}

papaparseOptions =
  header: true
  skipEmptyLines: true
  dynamicTyping: true

parseDate = (date) ->
  [dayIndex, hourIndex, AmPmIndex] = [2, 4, 5]

  data = date.split(/[ ,]+/)
  data[dayIndex] = data[dayIndex].replace(/\D/g,'')
  amPm = data.splice(AmPmIndex, 1)
  if amPm[0].toUpperCase() is 'PM'
    data[hourIndex] = parseInt(data[hourIndex], 10) + 12

  data[hourIndex] += ':00'
  data.join(' ')

export {
  decorateInitialData,
  papaparseOptions,
  parseDate,
  updateState
}
