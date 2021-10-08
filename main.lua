--[[A chess prototype built in lua curently in developement--]]
win_w = 650 --window width
win_h = 650 --windo hight
letters = {'a','b','c','d','e','f','g','h'}
turn = "WHITE"
game_over = false

function love.load()
  --[[runs once on game start.
  sets up window and loads images--]]
  love.window.setMode(win_w, win_h)
  love.window.setTitle ("lua chess")
  setUpBoard()
  chess_pieces = {
    ["P"] = love.graphics.newImage('sprites/whitePawn.png'),
    ["R"] = love.graphics.newImage('sprites/whiteRook.png'),
    ["N"] = love.graphics.newImage('sprites/whiteKnight.png'),
    ["B"] = love.graphics.newImage('sprites/whiteBishop.png'),
    ["Q"] = love.graphics.newImage('sprites/whiteQueen.png'),
    ["K"] = love.graphics.newImage('sprites/whiteKing.png'),
    ["p"] = love.graphics.newImage('sprites/blackPawn.png'),
    ["r"] = love.graphics.newImage('sprites/blackRook.png'),
    ["n"] = love.graphics.newImage('sprites/blackKnight.png'),
    ["b"] = love.graphics.newImage('sprites/blackBishop.png'),
    ["q"] = love.graphics.newImage('sprites/blackQueen.png'),
    ["k"] = love.graphics.newImage('sprites/blackKing.png'),
  }
  chess_outlines = {
    ["P"] = love.graphics.newImage('sprites/pawnOutline.png'),
    ["R"] = love.graphics.newImage('sprites/rookOutline.png'),
    ["N"] = love.graphics.newImage('sprites/knightOutline.png'),
    ["B"] = love.graphics.newImage('sprites/bishopOutline.png'),
    ["Q"] = love.graphics.newImage('sprites/queenOutline.png'),
    ["K"] = love.graphics.newImage('sprites/kingOutline.png')
  }
end


function love.draw()
  --[[draws the board and graphics every frame--]]
  love.graphics.setBackgroundColor(66/255,153/255,133/255)
  local r_size = win_h/10
  local font = love.graphics.newFont("arial_narrow_7.ttf", 48/(80/r_size))
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", r_size-6, r_size-6, r_size*8+12, r_size*8+12)
  if turn == "WHITE" then
    if game_over then
      love.graphics.print("Black Wins!",font,win_h/3,r_size-r_size/1.5)
    else
      love.graphics.print("White's turn",font,win_h/3,r_size-r_size/1.5)
    end
  else
    if game_over then
      love.graphics.print("White wins!",font,win_h/3,r_size-r_size/1.5)
    else 
      love.graphics.print("Blacks's turn",font,win_h/3,r_size-r_size/1.5)
    end
  end
  for i = 1,8 do
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(9-i,font,r_size-r_size/2,i*r_size+r_size/3)
    for j = 1,8 do
      if j%2 == i%2 then
        love.graphics.setColor(1/255, 182/255, 192/255)
      else
        love.graphics.setColor(208/255, 224/255, 255/255)
      end
      love.graphics.rectangle("fill", j*r_size, i*r_size, r_size, r_size)
      love.graphics.setColor(1, 1, 1)
      if board[letters[j] .. 9-i] ~= ' ' then
        love.graphics.draw(chess_pieces[board[letters[j] .. 9-i]],j*r_size,i*r_size,0,r_size/50,r_size/50)
      end
    end
  end
  love.graphics.setColor(1,1,1)
  if sp_x ~= nil then
    love.graphics.draw(chess_outlines[board[letters[sp_x] .. sp_y]:upper()],sp_x*r_size,(9-sp_y)*r_size,0,r_size/50,r_size/50)
  end
  love.graphics.setColor(0/255, 217/255, 56/255,0.8)
  if highlights ~= nil then
    for i,v in pairs(highlights) do
      love.graphics.circle("fill",v[1]*r_size+r_size/2,(9-v[2])*r_size+r_size/2, r_size/4)
    end
  end
  love.graphics.setColor(0, 0, 0)
  for j = 1,8 do
    love.graphics.print(letters[j],font,j*r_size+r_size/3,r_size*9.2)
  end
end
