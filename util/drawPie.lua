local love = love
local lg = love.graphics

return function(x, y, inRadius, outRadius, angle1, angle2)
  lg.stencil(function()
    lg.circle("fill", x, y, inRadius)
  end)
  lg.setStencilTest("equal", 0)
  lg.arc("fill", x, y, outRadius, angle1, angle2)
  lg.arc("line", x, y, outRadius, angle1, angle2)

  lg.stencil(function()
    lg.arc("fill", x, y, outRadius, angle1, angle2)
  end)
  lg.setStencilTest("equal", 1)
  lg.circle("line", x, y, inRadius)
  
  lg.setStencilTest()
end
