
local function buildEndpointURI(endpoint)
    return Steamcord.Config.Api.BaseUri .. endpoint
end

local function buildBaseHeaders()
    return {
        Authorization = "Bearer " .. Steamcord.Config.Api.Token
    }
end

do
    local function buildPostHeaders()
        local headers = buildBaseHeaders()
        headers["Content-Type"] = "application/json"
        return headers
    end

    local function assembleSteamIds()
        local steamIds = {}
        for _,ply in pairs(player.GetAll()) do
            steamIds[#steamIds + 1] = ply:SteamID64()
        end
        return steamIds
    end

    local targetUri = buildEndpointURI("/steam-groups/queue")
    function Steamcord.RestAPI.POSTSteamGroupQueue()
        HTTP({
            url = targetUri,
            method = "POST",
            headers = buildPostHeaders(),
            body = util.TableToJSON(assembleSteamIds()),
            success = function(code, data, headers)
                print(data)
            end,
            failed = function(err)
                print(err)
            end
        })
    end
end

do
    local targetUri = buildEndpointURI("/players")

    local function createURIForPlayer(steamId)
        return targetUri .. "?steamId=" .. steamId .. "&limit=1"
    end

    local function createPlayerObjects(rawStrData)
        local tblData = util.JSONToTable(rawStrData)
        local players = {}
        for idx, rawPlayerObj in ipairs(tblData) do
            players[idx] = Steamcord.Objects.Player.FromObject(rawPlayerObj)
        end

        return players
    end

    function Steamcord.RestAPI.GETPlayer(steamId, callback)
        http.Fetch(createURIForPlayer(steamId), 
        function(body, size, headers, code)
            if code ~= 200 then
                error("unable to interract with the Steamcord API request status code: " .. code)
            end

            callback(createPlayerObjects(body)[1])
        end, 
        function(err) 
            print(err) 
        end, 
        buildBaseHeaders())
    end
end

-- TODO: fix 415.
Steamcord.RestAPI.POSTSteamGroupQueue()
timer.Create("Steamcord.UpdateSteamGroups", 5 * 60, 0, function()
    if not Steamcord.Config.UpdateSteamGroups then return end
    Steamcord.RestAPI.POSTSteamGroupQueue()
end)

-- Steamcord.RestAPI.GETPlayer("76561198171821322")