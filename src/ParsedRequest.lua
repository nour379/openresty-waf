_M = {}

local version = require "version"


local year, month, day, hour, minute, second = string_match(ngx.localtime(),
      "(%d%d%d%d)-(%d%d)-(%d%d) (%d%d):(%d%d):(%d%d)")
      
-- class ParsedRequestData definition
ParsedRequestData = {
  REMOTE_ADDR       = ngx.var.remote_addr,
  HTTP_VERSION      = ngx.req.http_version(),
  METHOD            = request_method, --TODO
  URI               = ngx.var.uri,
  URI_ARGS          = request_uri_args,--TODO
  QUERY_STRING      = query_string,--TODO
  REQUEST_URI       = request_uri,--TODO
  REQUEST_URI_RAW   = request_uri_raw,--TODO
  REQUEST_BASENAME  = request_basename,--TODO
  REQUEST_HEADERS   = request_headers,--TODO
  COOKIES           = request_cookies,--TODO
  REQUEST_BODY      = request_body,--TODO
  REQUEST_ARGS      = request_common_args,--TODO
  REQUEST_LINE      = request_var,--TODO
  PROTOCOL          = ngx.var.server_protocol,
  TX                = ctx.storage["TX"],
  NGX_VAR           = ngx.var,
  MATCHED_VARS      = {},
  MATCHED_VAR_NAMES = {},
  SCORE_THRESHOLD   = waf._score_threshold,

  ARGS_COMBINED_SIZE = query_str_size + body_size,

  TIME              = string_format("%d:%d:%d", hour, minute, second),
  TIME_DAY          = day,
  TIME_EPOCH        = ngx.time(),
  TIME_HOUR         = hour,
  TIME_MIN          = minute,
  TIME_MON          = month,
  TIME_SEC          = second,
  TIME_YEAR         = year
}
function ParsedRequestData:new (obj)
  setmetatable(obj, self)
  self.__index = self
  return obj
end

return _M