Steamcord = {}
Steamcord.Config = {}

local function loadDirectory(dir)
    local fil, fol = file.Find(dir .. "/*", "LUA")
    for k,v in ipairs(fol) do
        loadDirectory(dir .. "/" .. v)
    end
    for k,v in ipairs(fil) do
        local dirs = dir .. "/" .. v
        include(dirs)
    end
end

hook.Add("Think", "load_steamcord_gmod", function()
    hook.Remove("Think", "load_steamcord_gmod")
    loadDirectory("steamcord/config")
    include("steamcord/data/sv_common.lua")
    include("steamcord/data/sv_mysqloo.lua")
    include("steamcord/data/sv_sqlite.lua")
    loadDirectory("steamcord/objects")
    loadDirectory("steamcord/restapi")
end)