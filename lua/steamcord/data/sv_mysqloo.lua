// Copyright 2022 Steamcord LLC
if not mysqloo then
    require("mysqloo")
end

Steamcord.MySQL = {}

function Steamcord.MySQL:Query(query, onSuccess, onError, ...)
    local query1 = self.instance:prepare(string.format(query, args))

    function query1:onSuccess(data)
        if onSuccess then
            onSuccess(data)
        end
    end

    function query1:onError(err)
        if onError then
            onError(err)
        end

        print("[Steamcord] SQL Error: " .. err .. "\nOn query: " .. query)
    end

    for i, v in ipairs({...}) do
        local argType = string.ToTable(type(v))
        argType[1] = string.upper(argType[1])
        argType = table.concat(argType)
        query1["set" .. argType](query1, i, v)
    end

    query1:start()
end


function Steamcord.MySQL:TableCheck()
    self:Query([[
        CREATE TABLE IF NOT EXISTS Redemption(
            Id BIGINT AUTO_INCREMENT NOT NULL,
            SteamID VARCHAR(17) NOT NULL,
            RewardName VARCHAR(64),
            HasBeenRewarded BIT(1),
            PRIMARY KEY(Id),
            UNIQUE KEY SteamIDRewardName (RewardName, SteamID)
        );
    ]], function()
    end)
end

function Steamcord.MySQL:SetRedeemed(steamID, rewardType, hasBeenRewarded, callback)
    hasBeenRewarded = hasBeenRewarded or true
    
    if not tonumber(steamID) then
        error("The steamid provided is not a steamid64")
    end

    if not Steamcord.Config.Rewards[rewardType] then 
        error("The reward type is not defined in the config.")
    end

    if not isbool(hasBeenRewarded) then
        error("hasBeenRewarded is not a boolean")
    end
    
    self:Query("INSERT INTO Redemption(SteamID, RewardName, HasBeenRewarded) VALUES(?,?,?)", function()
        callback(steamID, rewardType, hasBeenRewarded)
    end, nil, steamID, rewardType, hasBeenRewarded and 1 or 0)

end

function Steamcord.MySQL:HasRedeemed(steamID, rewardName, callback)

    self:Query("SELECT SteamID, HasBeenRewarded FROM Redemption WHERE SteamID = ? AND RewardName = ? AND HasBeenRewarded = 1 ", function(data)
        local hasBeenRewarded = #data > 0 and data[1].HasBeenRewarded == 1
    
        callback(steamID, rewardName, hasBeenRewarded)
    end, function(err)
    end, steamID, rewardName)
    
end


function Steamcord.MySQL:ResetRewardName(rewardName, callback)

    self:Query("DELETE FROM Redemption WHERE RewardName = ?", function(data)
        callback(rewardName)
    end, function(err)
    end, rewardName)
    
end


function Steamcord.MySQL:ResetSteamID(steamID, callback)

    self:Query("DELETE FROM Redemption WHERE SteamID = ?", function(data)
        callback(steamID)
    end, function(err)
    end, steamID)
    
end

function Steamcord.MySQL:ResetSteamIDWithRewardName(steamID, rewardName, callback)

    self:Query("DELETE FROM Redemption WHERE SteamID = ? AND RewardName = ?", function(data)
        callback(steamID, rewardName)
    end, function(err)
    end, steamID, rewardName)
    
end

function Steamcord.MySQL:ResetAll(callback)

    self:Query("TRUNCATE Redemption;", function(data)
        callback()
    end, function(err)
    end)
    
end


do

    local connectionInfo = Steamcord.Config.Data.ConnectionInfo

    function Steamcord.MySQL:Connect()
        self.instance = mysqloo.connect(connectionInfo.Host, connectionInfo.Username, 
            connectionInfo.Password, connectionInfo.Database,
            connectionInfo.Port)
        
        self.instance.onConnected = function()
            Steamcord.MySQL:TableCheck()
        end

        self.instance.onConnectionFailed = function(_,err)
            print("Steamcord failed to connect to Mysql database Error: ", err)
        end
        self.instance:connect()

    end

end

if Steamcord.Data.IsUsingMysqloo() then
    hook.Add("Think", "Steamcord::MysqlooInit", function()
        hook.Remove("Think", "Steamcord::MysqlooInit")
        Steamcord.MySQL:Connect()
    end)
end