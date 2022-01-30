Steamcord.Data = {}

function Steamcord.Data.IsUsingMysqloo()
    return Steamcord.Config.Data.DatabaseType:lower() == "mysql"
end

-- callback will either be true or false as to whether it's been redeemed.
function Steamcord.Data.HasRedeemed(steamID, rewardName, callback)
    
end

function Steamcord.Data.SetRedeemed(steamID, rewardName, callback)
    
end