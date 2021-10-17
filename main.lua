--[[A Civilization game prototype built in lua curently in developement--]]
win_w = 1000 --window width
win_h = 740 --window hight
scale = 1.4
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
  font = love.graphics.newFont("arial_narrow_7.ttf", 48/(80/(win_h/10)))
  gold = 0
  food = 0
  health = 100
  offsetX = 0
  offsetY = 0
  farmNum = 0
  mountainNum = 0
  waterNum = 0
  tilesOnBoard = {}
  for my = 1,70 do
    for mx = 1,100 do
      local randomTile = groundTileChoices[math.random(7)]
      table.insert(tilesOnBoard,newTile(mx,my,randomTile))
    end
  end
end

function love.wheelmoved(x, y)
  if y > 0 and scale < 2.5 then
    scale = scale + .01
  elseif y < 0 and scale > .5 then
    scale = scale - .01
  end
end

function love.update(dt)
  if love.keyboard.isDown("w") then
    offsetY = offsetY - 7/scale
  end
  if love.keyboard.isDown("a") then
    offsetX = offsetX + 7/scale
  end
  if love.keyboard.isDown("d") then
    offsetX = offsetX - 7/scale
  end
  if love.keyboard.isDown("s") then
    offsetY = offsetY + 7/scale
  end
  mouse_x,mouse_y = love.mouse.getPosition()
  mouse_x = math.floor(((mouse_x-offsetX)/55)/scale)
  local oy = 0
  if mouse_x%2 == 1 then
    oy = 30
  end
  mouse_y = math.floor(((win_h-mouse_y-offsetY+oy)/65)/scale)
end

function love.draw()
  love.graphics.setColor(1,1,1)
  for i,v in ipairs(tilesOnBoard) do
    local oy = 0
    if v.x%2 == 0 then
      oy = 30
    end
    local sx,sy = (v.x*55+offsetX)*scale, win_h-(v.y*65+oy+offsetY)*scale
    if sx > -165 and sx < win_w+110 and sy > -130 and sy < win_h then
      love.graphics.draw(groundTiles[v.type],sx,sy,0,1.4*scale)
    end
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

  love.graphics.setColor(181/255,185/255,205/255)
  love.graphics.rectangle("fill",0,win_h-40,1000,40)

  love.graphics.setColor(0,0,0)
  love.graphics.print("x: " .. mouse_x .. " y: " .. mouse_y,font,50,win_h-40)
end