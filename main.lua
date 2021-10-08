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

function love.mousepressed(x,y,button)
  --[[function runs when mousebutton is pressed.
  allows the player to select a piece and move it--]]
  if button == 1  and game_over ~= true then
    local tmp_x,tmp_y = returnMouseSquare(x,y)
    if tmp_x ~= nil and board[letters[tmp_x] .. tmp_y] ~= ' ' and p_selected == false then
      p_selected = true
      sp_x = tmp_x
      sp_y = tmp_y
    elseif tmp_x ~= nil and p_selected == true then
      local fp = board[letters[sp_x] .. sp_y]
      color = "WHITE"
      if fp == fp:upper() then
        color = "WHITE"
      else
        color = "BLACK"
      end
      v_moves = getPossibleMoves(sp_x,sp_y,fp)
      for i,v in pairs(v_moves) do
        if v[1] == tmp_x and v[2] == tmp_y  and color == turn then
          board[letters[sp_x] .. sp_y] = ' '
          board[letters[tmp_x] .. tmp_y] = fp
          if fp == fp:upper() then
            turn = "BLACK"
          else
            turn = "WHITE"
          end
          break
        end
      end
      p_selected = false
      sp_x,sp_y = nil,nil
    else
      p_selected = false
      sp_x,sp_y = nil,nil
    end
  end
end

function love.update(dt)
  --[[runs every frame--]]
  if game_over ~= true then
    local m_x,m_y = love.mouse.getPosition()
    local tmp_x,tmp_y = returnMouseSquare(m_x,m_y)
    if tmp_x ~= nil and p_selected == false then
      highlights = {}
      highlights = getPossibleMoves(tmp_x,tmp_y,board[letters[tmp_x] .. tmp_y])
    end
    cond_a = true
    for i = 1,8 do
      for j = 1,8 do
        if board[letters[j] .. i] == "K" then
          cond_a = false
        end
      end
    end
    cond_b = true
    for i = 1,8 do
      for j = 1,8 do
        if board[letters[j] .. i] == "k" then
          cond_b = false
        end
      end
    end
    if cond_a or cond_b then
      game_over = true
    end
  else
    highlights = {}
  end
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
