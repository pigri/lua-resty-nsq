local h = require("resty.http")
local cjson = require("cjson")
local _M = {}

function _M.lookup(url, topic)
    if not url then
        return nil, "url is required"
    end
    if not topic then
        return nil, "topic is required"
    end
    local httpc = h.new()
    local res, err = httpc:request_uri(url .. "/lookup?topic=" .. topic, {
        method = "GET",
    })
    if err then
        return nil, err
    end
    if res.status ~= 200 then
        return nil, "lookup request failed with status: " .. res.status
    end
    local body = cjson.decode(res.body)
    local addresses = {}
    for _, producer in ipairs(body.producers) do
        table.insert(addresses, {
            host = producer.broadcast_address,
            ip = producer.broadcast_address,
            port = producer.tcp_port,
        })
    end
    return addresses
end

return _M
