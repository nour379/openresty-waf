_M = {}

local upload = require "resty.upload"
local cookie = require "resty.cookie"
local version = require "version"
--local parsedRequest = require "ParsedRequest"


--TODO
function _M.parseRequest()

    local parsedRequest = {}

    -- read nginx variables
    parsedRequest.NGX_VAR           = ngx.var
    parsedRequest.REMOTE_ADDR       = ngx.var.remote_addr
    parsedRequest.URI               = ngx.var.uri
    parsedRequest.QUERY_STRING      = ngx.var.query_string
    parsedRequest.REQUEST_LINE      = ngx.var.request
    parsedRequest.PROTOCOL          = ngx.var.server_protocol
    
    -- read request data
    local request_var               = ngx.var.request
    local request_headers           = ngx.req.get_headers()
    local request_method            = ngx.req.get_method()
    local request_uri_args          = ngx.req.get_uri_args()
    local request_uri               = request_uri()
    local request_uri_raw           = request_uri_raw(request_var, request_method)
    
    parsedRequest.REQUEST_URI       = request_uri
    parsedRequest.REQUEST_URI_RAW   = request_uri_raw
    parsedRequest.URI_ARGS          = ngx.req.get_uri_args()
    parsedRequest.HTTP_VERSION      = ngx.req.http_version()
    parsedRequest.METHOD            = ngx.req.get_method()
    parsedRequest.REQUEST_HEADERS   = ngx.req.get_headers() 
    
    parsedRequest.COOKIES           = cookies() or {}
    
    --[[local request_basename    = basename(waf, ngx.var.uri)
    --local request_body        = request.parse_request_body(waf, request_headers, parsedRequest)
    --local request_common_args = request.common_args({ request_uri_args, request_body, request_cookies })
    
    parsedRequest.REQUEST_BASENAME  = request_basename
    parsedRequest.REQUEST_BODY      = request_body
    parsedRequest.REQUEST_ARGS      = request_common_args
    parsedRequest.TX                = ctx.storage["TX"]

    parsedRequest.ARGS_COMBINED_SIZE = query_str_size + body_size]]

    -- read time data for timestamp and logging 
    local year, month, day, hour, minute, second = string_match(ngx.localtime(),
      "(%d%d%d%d)-(%d%d)-(%d%d) (%d%d):(%d%d):(%d%d)")

    parsedRequest.TIME              = string_format("%d:%d:%d", hour, minute, second)
    parsedRequest.TIME_DAY          = day
    parsedRequest.TIME_EPOCH        = ngx.time()
    parsedRequest.TIME_HOUR         = hour
    parsedRequest.TIME_MIN          = minute
    parsedRequest.TIME_MON          = month
    parsedRequest.TIME_SEC          = second
    parsedRequest.TIME_YEAR         = year

    --TODO
    -- data not used in parsing, TO BE MOVED 
    --parsedRequest.MATCHED_VARS      = {}
    --parsedRequest.MATCHED_VAR_NAMES = {}
    --parsedRequest.SCORE_THRESHOLD   = waf._score_threshold
end

-- builds the request line and returns it
function _M.request_uri()
  local request_line = {}
  local is_args      = ngx.var.is_args

  request_line[1] = ngx.var.uri

  if is_args then
    request_line[2] = is_args
    request_line[3] = ngx.var.query_string
  end

  return table_concat(request_line, '')
end

function _M.request_uri_raw(request_line, method)
  return string.sub(request_line, #method + 2, -10)
end

--[[
function _M.basename(waf, uri)
  local m = ngx.re.match(uri, [=[(/[^/]*+)+]=], waf._pcre_flags)
  return m[1]
end
]]
function _M.cookies()
  local cookies = cookiejar:new()
  local request_cookies, cookie_err = cookies:get_all()

  return request_cookies
end


--TODO
function _M.createParsedRequest()

end

--TODO
function _M.configureParser()

end

return _M
