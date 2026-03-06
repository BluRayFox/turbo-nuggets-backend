local http = require('http')
local config = require('./config')

http.createServer(function(req, res)
    local www = ''

    if req.url == '/' then 
        www = '.home'
    else
        www = req.url:sub(2, #req.url)
    end

    print(www)
    
    local handler = require('./www/'..www..'/handler')
    if not handler then
        res:finish('404: No such page.')
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