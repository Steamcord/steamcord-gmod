local SteamcordPlayer = {}

SteamcordPlayer.__index = SteamcordPlayer

Steamcord.Utils.BuilderAccessor(SteamcordPlayer, "PlayerId", "playerId")
Steamcord.Utils.BuilderAccessor(SteamcordPlayer, "CreatedDate", "createdDate")
Steamcord.Utils.BuilderAccessor(SteamcordPlayer, "ModifiedDate", "modifiedDate")

function SteamcordPlayer.New()
    local obj = setmetatable({}, SteamcordPlayer)
    obj.steamAccounts = {}
    obj.discordAccounts = {}
    return obj
end

function SteamcordPlayer.FromObject(rawData)
    local obj = SteamcordPlayer.New()
        :SetPlayerId(rawData.playerId)
        :SetCreatedDate(rawData.createdDate)
        :SetModifiedDate(rawData.modifiedDate)
    
    do 
        local steamAccountClass = Steamcord.Objects.SteamAccount
        
        for idx,steamAccountObj in ipairs(rawData.steamAccounts or {}) do
            obj:AddSteamAccount(steamAccountClass.FromObject(steamAccountObj))
        end
    end

    do 
        local discordAccountClass = Steamcord.Objects.DiscordAccount

        for idx,discordAccountObj in ipairs(rawData.discordAccounts or {}) do
            obj:AddDiscordAccount(discordAccountClass.FromObject(discordAccountObj))
        end
    end

    return obj
end

function SteamcordPlayer:AddDiscordAccount(account)
    self.discordAccounts[#self.discordAccounts + 1] = account
    return self
end

function SteamcordPlayer:AddSteamAccount(account)
    self.steamAccounts[#self.steamAccounts + 1] = account
    return self
end

Steamcord.Objects.Player = SteamcordPlayer
