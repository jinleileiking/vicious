---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2012, jinleileiking. <jinleileiking@gmail.com>
---------------------------------------------------

-- {{{ Grab environment
local ipairs = ipairs
local io = { lines = io.lines }
local math = { floor = math.floor }
local math = { ceil = math.ceil }
local setmetatable = setmetatable
local helpers = require("vicious.helpers")
local string = {
    find = string.find,
    match = string.match
}
local tonumber = tonumber
-- }}}




module("vicious.contrib.dns")


local function worker(format, warg)

    local line
    local dns_ret = {}
    local count = 0

    for line in io.lines("/etc/resolv.conf") do
        local dns
        dns = string.match(line, 'nameserver ([%d.]+)')
        if dns then 
            dns_ret[count] = dns
            count = count + 1
        end
    end

    return dns_ret or 'N/A'
end

setmetatable(_M, { __call = function(_, ...) return worker(...) end })
