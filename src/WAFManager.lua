_M = {}

local version = require "version"
local parser = require "Parser"
local detectionManager = require "DetectionManager"
local actionManager = require "ActionManager"
local logger = require "Logger"


-- TODO
function _M.main()

end

function _M.configureWAF()

end

return _M


--[[ class WAF_Manager definition
WAF_Manager = {}
function WAF_Manager:new (obj)
  setmetatable(obj, self)
  self.__index = self
  return obj
end]]


