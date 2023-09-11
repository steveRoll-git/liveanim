local love = love
local lg = love.graphics

return function(t)
  lg.setColor(1, 1, 0)
  lg.circle("fill", (math.sin(t) + 1) / 2 * lg.getWidth(), 100, 50)
end
