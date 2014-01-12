###
Formats mongoose errors into proper array

@param {Array} errors
@return {Array}
@api public
###
exports.errors = (errors) ->
  keys = Object.keys(errors)
  errs = []
  
  # if there is no validation error, just display a generic error
  return ["Oops! There was an error"]  unless keys
  keys.forEach (key) ->
    errs.push errors[key].message

  errs


###
Index of object within an array

@param {Array} arr
@param {Object} obj
@return {Number}
@api public
###
exports.indexof = (arr, obj) ->
  index = -1 # not found initially
  keys = Object.keys(obj)
  
  # filter the collection with the given criterias
  result = arr.filter((doc, idx) ->
    
    # keep a counter of matched key/value pairs
    matched = 0
    
    # loop over criteria
    i = keys.length - 1

    while i >= 0
      if doc[keys[i]] is obj[keys[i]]
        matched++
        
        # check if all the criterias are matched
        if matched is keys.length
          index = idx
          return idx
      i--
  )
  index


###
Find object in an array of objects that matches a condition

@param {Array} arr
@param {Object} obj
@param {Function} cb - optional
@return {Object}
@api public
###
exports.findByParam = (arr, obj, cb) ->
  index = exports.indexof(arr, obj)
  if ~index and typeof cb is "function"
    cb `undefined`, arr[index]
  else if ~index and not cb
    arr[index]
  else cb "not found"  if not ~index and typeof cb is "function"

# else undefined is returned
