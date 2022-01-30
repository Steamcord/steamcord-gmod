if not mysqloo then
    require("mysqloo")
end

Steamcord.SQLite = {}

function Steamcord.SQLite.TableCheck()
    if sql.TableExists("Redemption") then return end
    local data = sql.Query([[
        CREATE TABLE Redemption(
            Id INTEGER PRIMARY KEY AUTOINCREMENT,
            SteamID VARCHAR(17) NOT NULL,
            RewardName VARCHAR(64),
            HasBeenRewarded BIT(1),
            UNIQUE(`RewardName`, `SteamID`)
        );
    ]])
end

function Steamcord.SQLite:SetRedeemed(steamID, rewardName, hasBeenRewarded, callback)
    hasBeenRewarded = hasBeenRewarded or true
    
    if not tonumber(steamID) then
        error("The steamid provided is not a steamid64")
    end

    if not Steamcord.Config.Rewards[rewardName] then 
        error("The reward type is not defined in the config.")
    end

    if not isbool(hasBeenRewarded) then
        error("hasBeenRewarded is not a boolean")
    end

    local data = sql.Query("INSERT INTO Redemption(SteamID, RewardName, HasBeenRewarded) VALUES(" .. sql.SQLStr(steamID) .. "," .. sql.SQLStr(rewardName) .. "," .. (hasBeenRewarded and 1 or 0) .. ");")
    callback(steamID, rewardType, hasBeenRewarded)
end

function Steamcord.SQLite:HasRedeemed(steamID, rewardName, callback)
    local data = sql.Query("SELECT SteamID, HasBeenRewarded FROM Redemption WHERE SteamID = " .. sql.SQLStr(steamID) .. " AND RewardName = " .. sql.SQLStr(rewardName) .. " AND HasBeenRewarded = 1")
    local hasBeenRewarded = data and tonumber(data[1].HasBeenRewarded or 0) == 1 or false
    callback(steamID, rewardName, hasBeenRewarded)
end


function Steamcord.SQLite:ResetRewardName(rewardName, callback)
    sql.Query("DELETE FROM Redemption WHERE RewardName = " .. sql.SQLStr(rewardName))
    callback(rewardName) 
end

function Steamcord.SQLite:ResetSteamID(steamID, callback)
    sql.Query("DELETE FROM Redemption WHERE SteamID = " .. sql.SQLStr(steamID))
    callback(steamID)
end

function Steamcord.SQLite:ResetSteamIDWithRewardName(steamID, rewardName, callback)
    sql.Query("DELETE FROM Redemption WHERE SteamID = " .. sql.SQLStr(steamID) .. " AND RewardName = " .. SQLStr(rewardName))
    callback(steamID, rewardName)
end

function Steamcord.SQLite:ResetAll(callback)
    sql.Query("DELETE FROM Redemption;")
end