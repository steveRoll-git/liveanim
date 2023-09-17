local love = love
local lg = love.graphics

local filePath
local lastModtime

local drawFunction

local lastError

local reloadTimer = 0
local reloadInterval = 0.25

local function reloadFile()
  local success, result = pcall(love.filesystem.load, filePath)
  if not success then
    drawFunction = nil
    lastError = result
    return
  end
  local success, result = pcall(result)
  if success then
    drawFunction = result
    lastError = nil
  else
    drawFunction = nil
    lastError = result
  end
end

function love.load(arg)
  filePath = arg[1]
  if not filePath then return end

  local info = love.filesystem.getInfo(filePath)
  if not info then
    error(("file %q not found!\n"):format(filePath))
  end

  lastModtime = info.modtime
  reloadFile()
end

function love.update(dt)
  if not filePath then return end

  reloadTimer = reloadTimer + dt
  if reloadTimer >= reloadInterval then
    reloadTimer = reloadTimer % reloadInterval
    local modtime = love.filesystem.getInfo(filePath).modtime
    if modtime > lastModtime then
      reloadFile()
      lastModtime = modtime
    end
  end
end

function love.draw()
  if not filePath then
    lg.printf("no path given!\nadd a filepath to the command line args", 0, lg.getHeight() / 2 - lg.getFont():getHeight(),
      lg.getWidth(), "center")
    return
  end
  if lastError then
    lg.printf(lastError, 0, lg.getHeight() / 2 - lg.getFont():getHeight(),
      lg.getWidth(), "center")
    return
  end

  local success, message = pcall(drawFunction, love.timer.getTime())
  if not success then
    lastError = message
  end
end
