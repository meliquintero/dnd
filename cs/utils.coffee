`
import {keys, clone} from 'lodash'
`

updatedState = ({source, destination, draggableId}, state) ->
  if not destination?
    return
  if destination.droppableId is source.droppableId and destination.index is source.index
    return

  startUserIdsOrder = state.usersGroupedByTime[source.droppableId]
  startUserIdsOrder.splice(source.index, 1)

  if destination.droppableId is source.droppableId
    startUserIdsOrder.splice(destination.index, 0, draggableId)
    state.usersGroupedByTime[source.droppableId] = startUserIdsOrder

  else
    state.users[draggableId].preferredMeetingTime = destination.droppableId
    state.hasMovedUser++

    destinationtUserIdsOrder = state.usersGroupedByTime[destination.droppableId]
    destinationtUserIdsOrder.splice(destination.index, 0, draggableId)

    state.usersGroupedByTime[source.droppableId] = startUserIdsOrder
    state.usersGroupedByTime[destination.droppableId] = destinationtUserIdsOrder

  state

decorateInitialData = (data) ->
  usersGroupedByTime = {}
  users = {}
  for user in data
    user.fixed ?= false
    users[user.id] = user

    if not usersGroupedByTime[user.preferredMeetingTime]?
      usersGroupedByTime[user.preferredMeetingTime] = []
    usersGroupedByTime[user.preferredMeetingTime].push(user.id)

  preferredTimes = keys(usersGroupedByTime)

  {usersGroupedByTime, users, preferredTimes}

papaparseOptions =
  header: true
  skipEmptyLines: true
  dynamicTyping: true

export {papaparseOptions, decorateInitialData, updatedState}
