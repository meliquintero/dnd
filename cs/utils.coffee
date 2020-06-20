`
import {keys, clone} from 'lodash'
`

updatedState = ({source, destination, draggableId}, state) ->
  if not destination?
    return
  if destination.droppableId is source.droppableId and destination.index is source.index
    return

  newState = {}
  start = state.usersGroupedByTime[source.droppableId]
  sourceUserIds = clone(start.usersId)
  sourceUserIds.splice(source.index, 1)

  if destination.droppableId is source.droppableId
    sourceUserIds.splice(destination.index, 0, draggableId)
    newStartTime = {...start, usersId: sourceUserIds}

    newState = {
      ...state,
      usersGroupedByTime: {
        ...state.usersGroupedByTime,
        [newStartTime.id]: newStartTime
      }
    }

  else
    newStartTime = {...start, usersId: sourceUserIds}

    newUser = clone(state.users[draggableId])
    newUser.preferredMeetingTime = destination.droppableId

    end = state.usersGroupedByTime[destination.droppableId]
    destinationUserIds = clone(end.usersId)
    destinationUserIds.splice(destination.index, 0, draggableId)
    newEndTime = {...end, usersId: destinationUserIds}
    newState = {
      ...state,
      users: {
        ...state.users,
        [newUser.id]: newUser
      }
      usersGroupedByTime: {
        ...state.usersGroupedByTime,
        [newStartTime.id]: newStartTime
        [newEndTime.id]: newEndTime
      }
    }
    newState

decorateInitialData = (data) ->
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

export {papaparseOptions, decorateInitialData, updatedState}
