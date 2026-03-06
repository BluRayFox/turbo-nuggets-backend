local handler = {}

function handler.handler(req, res)
    local indexFile = io.open('./www/.home/index.html', 'r')
    if not indexFile then 
        error('Unable to read index')
    end

    local content = indexFile:read("*a")
    indexFile:close()

    res:finish(content)
end

return handler