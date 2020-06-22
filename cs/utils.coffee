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

    destinationTime = state.usersGroupedByTime[destination.droppableId]
    destinationtUserIdsOrder = destinationTime.userIds
    destinationtUserIdsOrder.splice(destination.index, 0, draggableId)

  destinationTime.newMeetingUserIds.push(draggableId)

  if destinationTime.newMeetingUserIds.length >= 2
    state.newMeetingUserIds = destinationTime.newMeetingUserIds.slice(-2)

  state

hasError = (data) ->
  error = error: false
  oneUser = keys data[0]
  for header, i in validHeaders
    if !(oneUser[i] == header)
      return error = error: message: 'Invalid Columns'

  error

initialState =
  users: {}
  usersGroupedByTime: {}
  preferredTimes: []
  hasMovedUser: 0
  newMeetingUserIds: []
  error: false

decorateInitialData = (data) =>
  error = hasError(data)
  console.log "{@initialState, error}", {...initialState, ...error}
  return {...initialState, ...error} if error.error

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

  {usersGroupedByTime, users, preferredTimes, error}

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

validHeaders = ['id','firstName','lastName','email','preferredMeetingTime','fixed']

export {
  decorateInitialData,
  initialState,
  papaparseOptions,
  parseDate,
  updateState
}
