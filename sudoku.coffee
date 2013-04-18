printGrid = (grid)-> 
	for i in grid
		str = ""
		for j in i
 			str += "#{j} "
 		console.log str 

getNextBlank = (grid) ->
	for i in [0..9]
		for j in [0..9]
			if grid[i][j] is 0
				return [i,j]

checkForAnyToChange = (grid)->
	for i in [0..8]
		for j in [0..8]
			if grid[i][j] is 0
 				return true
	return false

notUsedInRow = (grid,row,value)->
	for i in grid[row]
		if i is value
			return false
	return true





notUsedInColumn = (grid,column,value)->
	for i in grid
		if i[column] is value
			return false
	return true

notInGrid = (grid, row, column,value)->
	rowLimits = getGridSector row
	columnLimits = getGridSector column
	for row in [rowLimits[0]..rowLimits[1]]
		for column in [columnLimits[0]..columnLimits[1]]
			if grid[row][column] is value
				return false
			
	return true


# possibly replace with a switch
getGridSector = (val)->
	if val < 3 
		return [0,2]
	else if 6 > val > 2 
		return [3,5]
	else if 9 > val > 5
		return [6,8] 




noConflicts= (grid, value,row,column)->
	if notInGrid(grid, row, column,value) && notUsedInRow(grid,row, value) && notUsedInColumn(grid,column,value)
		return true
	else
		return false


solve= ()->
	
	if !checkForAnyToChange grid
		return true
	else
		row = getNextBlank(grid)[0]
		column = getNextBlank(grid)[1]
		for i in [1..9]
			if noConflicts grid, i,row,column
				grid[row][column] = i
				if solve grid
					return true
				grid[row][column] = 0
	return false

grid = [[0,0,0,0,0,0,2,8,0],
[0,0,0,0,0,0,9,0,3],
[0,9,0,4,0,2,1,0,5],
[3,2,7,0,0,0,0,0,0],
[8,0,0,0,0,0,0,9,0],
[0,5,0,0,0,8,0,0,7],
[0,8,5,0,6,7,0,1,4],
[0,0,3,0,8,0,0,5,0],
[0,0,0,0,0,9,6,0,0]]

solve grid
printGrid grid