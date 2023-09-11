local love = love
local lg = love.graphics

local drawPie = require "util.drawPie"

return function(t)
  lg.setColor(1, 1, 0)
  lg.circle("fill", (math.sin(t) + 1) / 2 * lg.getWidth(), 100, 50)

  lg.setColor(1, 1, 1)
  local centerAngle = (t % 2) / 2 * math.pi * 2
  local spread = 1.5 + math.sin(t * 3) * 0.8
  drawPie(255, 255, 50, 60, centerAngle - spread, centerAngle + spread)
end
