--[[A Civilization game prototype built in lua curently in developement--]]
win_w = 1000 --window width
win_h = 740 --window hight
scale = 1
game_over = false
math.randomseed(os.time())

function love.load()
  --[[runs once on game start.
  sets up window and loads images--]]
  love.window.setMode(win_w, win_h)
  love.window.setTitle ("Civilization Practice Game")
  love.graphics.setBackgroundColor(155/255,155/255,155/255)
  groundTileChoices = {"grass","grass","grass","mountain","sand","sand","water"}
  groundTiles = {
    ["grass"] = love.graphics.newImage('sprites/grassTile.png'),
    ["farm"] = love.graphics.newImage('sprites/farmTile.png'),
    ["mountain"] = love.graphics.newImage('sprites/mountainTile.png'),
    ["sand"] = love.graphics.newImage('sprites/sandTile.png'),
    ["water"] = love.graphics.newImage('sprites/waterTile.png'),
  }

  gold = 0
  food = 0
  health = 100

  offsetX = 30
  offsetY = 80
  farmNum = 0
  mountainNum = 0
  waterNum = 0
  tilesOnBoard = {}

  for i = 1,144 do
    randomTile = groundTileChoices[math.random(7)]
    table.insert(tilesOnBoard,i,randomTile)
  end
end
function love.wheelmoved(x, y)
  if y > 0 then
    scale = scale + .1
  elseif y < 0 then
    scale = scale - .1
  end
end

function love.draw()
  local r_size = win_h/10
  local font = love.graphics.newFont("arial_narrow_7.ttf", 48/(80/r_size))
  counter = 1
  for j = 1,585,65 do
    for i = 1,920,115 do
      love.graphics.setColor(1,1,1)
      love.graphics.draw(groundTiles[tilesOnBoard[counter]],(i+offsetX)*scale,(j+offsetY)*scale,0,1.4*scale)
      love.graphics.draw(groundTiles[tilesOnBoard[counter]],(i+57.5+offsetX)*scale,(j+32.5+offsetY)*scale,0,1.4*scale)
      counter = counter + 1
    end
  end
  
  love.graphics.setColor(255/255,255/255,0/255)
  love.graphics.print("Health:",font,120,20,0,1.2,1.2)
  love.graphics.setColor(1,1,1)
  love.graphics.print(health,font,290,20,0,1.2,1.2)

  love.graphics.setColor(255/255,255/255,0/255)
  love.graphics.print("Food:",font,440,20,0,1.2,1.2)
  love.graphics.setColor(1,1,1)
  love.graphics.print(food,font,560,20,0,1.2,1.2)

  love.graphics.setColor(255/255,255/255,0/255)
  love.graphics.print("Gold:",font,700,20,0,1.2,1.2)
  love.graphics.setColor(1,1,1)
  love.graphics.print(gold,font,820,20,0,1.2,1.2)
end