-- Copyright 2022 Steamcord LLC

Steamcord.Data = {}

function Steamcord.Data.IsUsingMysqloo()
    return Steamcord.Config.Data.DatabaseType:lower() == "mysql"
end

-- callback will either be true or false as to whether it's been redeemed.
function Steamcord.Data.HasRedeemed(steamID, rewardName, callback)
    if Steamcord.Data.IsUsingMysqloo() then
        Steamcord.MySQL:HasRedeemed(steamID, rewardName, callback)
    else
        Steamcord.SQLite:HasRedeemed(steamID, rewardName, callback)
    end
end

function Steamcord.Data.SetRedeemed(steamID, rewardName, callback)
    if Steamcord.Data.IsUsingMysqloo() then
        Steamcord.MySQL:SetRedeemed(steamID, rewardName, true, callback)
    else
        Steamcord.SQLite:SetRedeemed(steamID, rewardName, true, callback)
    end
end
