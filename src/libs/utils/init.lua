local utils = {}

function utils.urlToTable(url)
    local parts = {}
    for segment in url:gmatch("[^/?]+") do
        parts[#parts + 1] = segment
    end
    return parts
end

return utils