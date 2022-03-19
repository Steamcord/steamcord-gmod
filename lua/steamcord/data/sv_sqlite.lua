-- Copyright 2022 Steamcord LLC

Steamcord.SQLite = {}

function Steamcord.SQLite.TableCheck()
    if sql.TableExists("Redemption") then return end
    local data = sql.Query([[
        CREATE TABLE Redemption(
            Id INTEGER PRIMARY KEY AUTOINCREMENT,
            SteamId VARCHAR(17) NOT NULL,
            RewardName VARCHAR(64),
            UNIQUE(`RewardName`, `SteamId`)
        );
    ]])
end
Steamcord.SQLite.TableCheck()
function Steamcord.SQLite:SetRedeemed(steamId, rewardName, hasBeenRewarded, callback)
    hasBeenRewarded = hasBeenRewarded == nil and true or hasBeenRewarded
    
    if not tonumber(steamId) then
        error("The steamid provided is not a steamid64")
    end

    if not Steamcord.Config.Rewards[rewardName] then 
        error("The reward type is not defined in the config.")
    end

    if not isbool(hasBeenRewarded) then
        error("hasBeenRewarded is not a boolean")
    end

    if hasBeenRewarded == false then
        sql.Query("DELETE FROM Redemption WHERE SteamId = ".. sql.SQLStr(steamId) .. " AND RewardName = " .. sql.SQLStr(rewardName))
    else
        sql.Query("INSERT INTO Redemption(SteamId, RewardName) VALUES(" .. sql.SQLStr(steamId) .. "," .. sql.SQLStr(rewardName) .. ")")
    end

    callback(steamId, rewardType, hasBeenRewarded)
end

function Steamcord.SQLite:HasRedeemed(steamId, rewardName, callback)
    local data = sql.Query("SELECT SteamId FROM Redemption WHERE SteamId = " .. sql.SQLStr(steamId) .. " AND RewardName = " .. sql.SQLStr(rewardName))
    local hasBeenRewarded = table.Count(data or {}) > 0
    callback(steamId, rewardName, hasBeenRewarded)
end

function Steamcord.SQLite:ResetRewardName(rewardName, callback)
    sql.Query("DELETE FROM Redemption WHERE RewardName = " .. sql.SQLStr(rewardName))
    callback(rewardName) 
end

function Steamcord.SQLite:ResetSteamID(steamId, callback)
    sql.Query("DELETE FROM Redemption WHERE SteamId = " .. sql.SQLStr(steamId))
    callback(steamId)
end

function Steamcord.SQLite:ResetSteamIDWithRewardName(steamId, rewardName, callback)
    sql.Query("DELETE FROM Redemption WHERE SteamId = " .. sql.SQLStr(steamId) .. " AND RewardName = " .. SQLStr(rewardName))
    callback(steamId, rewardName)
end

function Steamcord.SQLite:ResetAll(callback)
    sql.Query("DELETE FROM Redemption;")
end
