--[[A Civilization game prototype built in lua curently in developement--]]
win_w = 1200 --window width
win_h = win_w*.74 --window hight
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
  font = love.graphics.newFont("arial_narrow_7.ttf", 48/(80/(win_h/10)))
  staticFont = love.graphics.newFont("arial_narrow_7.ttf", 44.4)
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

  offsetX = (-1000 + win_w)/2
  offsetY = (-740 + win_h)/2
  topBoxOffset = offsetX

  sizeTextColor1 = 0
  sizeTextColor2 = 0
  sizeTextColor3 = 0
  gameStart = false
  firstTimeStart = true
end

function love.wheelmoved(x, y)
  if gameStart == true then
    if y > 0 and scale < 2.5 then
      scale = scale + .01
    elseif y < 0 and scale > .5 then
      scale = scale - .01
    end
  end
end

function love.update(dt)
  if gameStart == false then
    mouse_x,mouse_y = love.mouse.getPosition()
    if mouse_x >= 323+offsetX and mouse_y >= 276+offsetY and mouse_x <= 323+117.6667+offsetX and mouse_y <= 276+90+offsetY then
      sizeTextColor1 = 150
      if love.mouse.isDown(1) then
        mapSizeX = 10
        mapSizeY = 7
        gameStart = true
      end
    else
      sizeTextColor1 = 0
    end

    if mouse_x >= 440.6667+offsetX and mouse_y >= 276+offsetY and mouse_x <= 440.6667+117.6667+offsetX and mouse_y <= 276+90+offsetY then
      sizeTextColor2 = 150
      if love.mouse.isDown(1) then
        mapSizeX = 25
        mapSizeY = 15
        gameStart = true
      end
    else
      sizeTextColor2 = 0
    end

    if mouse_x >= 558.333367+offsetX and mouse_y >= 276+offsetY and mouse_x <= 558.333367+117.6667+offsetX and mouse_y <= 276+90+offsetY then
      sizeTextColor3 = 150
      if love.mouse.isDown(1) then
        mapSizeX = 50
        mapSizeY = 35
        gameStart = true
      end
    else
      sizeTextColor3 = 0
    end

  elseif gameStart == true then
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
    mouse_x = math.floor((mouse_x/scale-offsetX)/55)
    mouse_y = math.floor(((win_h-mouse_y)/scale-offsetY)/65)+1
  end
end

function love.draw()
  if gameStart == false then
    love.graphics.setColor(200/255,200/255,210/255)
    love.graphics.rectangle("fill",293+offsetX,246+offsetY,413,150)
    love.graphics.setColor(180/255,180/255,200/255)
    love.graphics.rectangle("fill",313+offsetX,266+offsetY,373,110)

    love.graphics.setColor(180/255,250/255,200/255)
    love.graphics.rectangle("fill",323+offsetX,276+offsetY,117.6667,90)
    love.graphics.setColor(200/255,180/255,250/255)
    love.graphics.rectangle("fill",440.6667+offsetX,276+offsetY,117.6667,90)
    love.graphics.setColor(250/255,180/255,200/255)
    love.graphics.rectangle("fill",558.333367+offsetX,276+offsetY,117.6667,90)
    love.graphics.setColor(sizeTextColor1/255,sizeTextColor1/255,sizeTextColor1/255)
    love.graphics.print("Small",staticFont,339+offsetX,305+offsetY,0,.8,1)
    love.graphics.setColor(sizeTextColor2/255,sizeTextColor2/255,sizeTextColor2/255)
    love.graphics.print("Medium",staticFont,457+offsetX,305+offsetY,0,.7,1)
    love.graphics.setColor(sizeTextColor3/255,sizeTextColor3/255,sizeTextColor3/255)
    love.graphics.print("Large",staticFont,579+offsetX,305+offsetY,0,.8,1)
  end
  if gameStart == true and firstTimeStart == true then
    tilesOnBoard = {}
    for my = 0,mapSizeY do
      for mx = 0,mapSizeX do
        local randomTile = groundTileChoices[math.random(7)]
        table.insert(tilesOnBoard,newTile(mx,my,randomTile))
      end
    end
    firstTimeStart = false
  end
  if gameStart == true then
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
    love.graphics.rectangle("fill",0,0,win_w,70)
    
    love.graphics.setColor(255/255,255/255,0/255)
    love.graphics.print("Health:",staticFont,120+topBoxOffset,20,0,1.2,1.2)
    love.graphics.setColor(1,1,1)
    love.graphics.print(health,staticFont,290+topBoxOffset,20,0,1.2,1.2)

    love.graphics.setColor(255/255,255/255,0/255)
    love.graphics.print("Food:",staticFont,440+topBoxOffset,20,0,1.2,1.2)
    love.graphics.setColor(1,1,1)
    love.graphics.print(food,staticFont,560+topBoxOffset,20,0,1.2,1.2)

    love.graphics.setColor(255/255,255/255,0/255)
    love.graphics.print("Gold:",staticFont,700+topBoxOffset,20,0,1.2,1.2)
    love.graphics.setColor(1,1,1)
    love.graphics.print(gold,staticFont,820+topBoxOffset,20,0,1.2,1.2)

    love.graphics.setColor(181/255,185/255,205/255)
    love.graphics.rectangle("fill",0,win_h-40,win_w,40)

    love.graphics.setColor(0,0,0)
    love.graphics.print("x: " .. mouse_x .. " y: " .. mouse_y,staticFont,50,win_h-40)
  end
end