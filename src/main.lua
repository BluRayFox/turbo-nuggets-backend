-- packages and libs require aliases
-- elite ball knowledge
package.path = './libs/?.lua;'
    .. './libs/?/init.lua;'
    .. package.path

local http = require('http')
local config = require('./config')
local patcher = require('patcher')
local utils = require('utils')

-- globals
_G.utils = utils
_G.patcher = patcher

http.createServer(function(req, res)
    -- patch res 
    patcher.patchRes(res, {redirect = true})
    local urlTable = utils.urlToTable(req.url)

    local www = ''

    if req.url == '/' then 
        www = '.home'

    else
        www = req.url:sub(2, #req.url)

    end

    local address = req.socket:address().ip
    local logMessage = '[%s]: %s -> %s' -- ip, method, path
    print(logMessage:format(address, req.method, req.url))
    
    local success, handler = pcall(function()
        return require('./www/'..www..'/handler')
    end)
    
    if not success then
        success, handler = pcall(function()
            return require('./www/'..urlTable[1]..'/handler')
        end)
    end

    if not success then
        res:redirect('/not-found', nil, true)
        return
    end

    local success, err = pcall(function()
        handler.handler(req, res)
    end)

    if not success then
        res:finish('503: Unable to complete the request.')
        print('Unable to complete the request: '..err)
    end

    return
end):listen(config.port)


print('Running on http://localhost' .. (config.port ~= 80 and ':'..config.port or ''))