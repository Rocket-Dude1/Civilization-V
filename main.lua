--[[A Civilization game prototype built in lua curently in developement--]]
win_w = 1000 --window width
win_h = 650 --window hight
game_over = false
math.randomseed(os.time())

function love.load()
  --[[runs once on game start.
  sets up window and loads images--]]
  love.window.setMode(win_w, win_h)
  love.window.setTitle ("Civilization Practice Game")
  love.graphics.setBackgroundColor(155/255,155/255,155/255)
  groundTileChoices = {"grass","farm","mountain","sand","water"}
  groundTiles = {
    ["grass"] = love.graphics.newImage('sprites/grassTile.png'),
    ["farm"] = love.graphics.newImage('sprites/farmTile.png'),
    ["mountain"] = love.graphics.newImage('sprites/mountainTile.png'),
    ["sand"] = love.graphics.newImage('sprites/sandTile.png'),
    ["water"] = love.graphics.newImage('sprites/waterTile.png'),
  }
  offsetX = 30
  offsetY = 10
  farmNum = 0
  mountainNum = 0
  waterNum = 0
  tilesOnBoard = {}
  for i = 1,144 do
    randomTile = groundTileChoices[math.random(5)]
    if randomTile == "farm" then
      farmNum = farmNum + 1
    else if randomTile == "mountain" then
      mountainNum = mountainNum + 1
    else if randomTile == "water" then
      waterNum = waternum + 1
    end

    if farmNum >= 5 then
      table.remove(groundTileChoices,"farm")
      table.insert(groundTileChoices,"grass")
    else if mountainNum >= 5 then
      table.remove(groundTileChoices,"mountain")
      table.insert(groundTileChoices,"grass")
    else if waterNum >= 5 then
      table.remove(groundTileChoices,"water")
      table.insert(groundTileChoices,"grass")
    end
    table.insert(tilesOnBoard,i,randomTile)
  end
end


function love.draw()
  counter = 1
  for j = 1,585,65 do
    for i = 1,920,115 do
      love.graphics.draw(groundTiles[tilesOnBoard[counter]],i+offsetX,j+offsetY,0,1.4)
      love.graphics.draw(groundTiles[tilesOnBoard[counter]],i+57.5+offsetX,j+32.5+offsetY,0,1.4)
      counter = counter + 1
    end
  end
end