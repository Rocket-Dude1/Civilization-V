--[[A Civilization game prototype built in lua curently in developement--]]
win_w = 1000 --window width
win_h = 740 --window hight
scale = 1
game_over = false
math.randomseed(os.time())

function newTile(x,y,type)
  local tbl = {
    x = x,
    y = y,
    type = type
  }
  return tbl
end

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

  offsetX = -120
  offsetY = -120
  farmNum = 0
  mountainNum = 0
  waterNum = 0
  tilesOnBoard = {}
  for my = 1,20 do
    for mx = 1,40 do
      local randomTile = groundTileChoices[math.random(7)]
      table.insert(tilesOnBoard,newTile(mx,my,randomTile))
    end
  end
end

function love.wheelmoved(x, y)
  if y > 0 then
    scale = scale + .01
  elseif y < 0 then
    scale = scale - .01
  end
end

function love.update(dt)
  if love.keyboard.isDown("w") then
    offsetY = offsetY + 7/scale
  end
  if love.keyboard.isDown("a") then
    offsetX = offsetX + 7/scale
  end
  if love.keyboard.isDown("d") then
    offsetX = offsetX - 7/scale
  end
  if love.keyboard.isDown("s") then
    offsetY = offsetY - 7/scale
  end
end

function love.draw()
  local r_size = win_h/10
  local font = love.graphics.newFont("arial_narrow_7.ttf", 48/(80/r_size))

  love.graphics.setColor(1,1,1)
  for i,v in pairs(tilesOnBoard) do
    local oy = 0
    if v.x%2 == 0 then
      oy = 30
    end
    love.graphics.draw(groundTiles[v.type],(v.x*55+offsetX)*scale,(v.y*65+oy+offsetY)*scale,0,1.4*scale)
  end
  
  love.graphics.setColor(255/255,0/255,100/255)
  love.graphics.rectangle("fill",0,0,1000,70)
  
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