_M = {}

local version = require "version"

-- class ActionManager definition
ActionManager = {}
function ActionManager:new (obj)
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function ActionManager:takeAction(threat)

end

return _M