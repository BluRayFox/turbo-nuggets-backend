local http = require('http')
local config = require('./config')

http.createServer(function(req, res)
    -- patch res 
    function res.redirect(self, path, status, finish)
        self:writeHead(status or 308, {
            ["Location"] = path
        })
        if finish then self:finish() end
    end

    local www = ''

    if req.url == '/' then 
        www = '.home'
    else
        www = req.url:sub(2, #req.url)
    end

    print(www)
    
    local success, handler = pcall(function()
        return require('./www/'..www..'/handler')
    end)

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