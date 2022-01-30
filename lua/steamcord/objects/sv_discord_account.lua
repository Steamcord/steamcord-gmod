local SteamcordDiscordAccount = {}

SteamcordDiscordAccount.__index = SteamcordDiscordAccount

Steamcord.Utils.BuilderAccessor(SteamcordDiscordAccount, "DiscordId", "discordId")
Steamcord.Utils.BuilderAccessor(SteamcordDiscordAccount, "Username", "username")
Steamcord.Utils.BuilderAccessor(SteamcordDiscordAccount, "Avatar", "avatar")
Steamcord.Utils.BuilderAccessor(SteamcordDiscordAccount, "IsGuildMember", "isGuildMember")
Steamcord.Utils.BuilderAccessor(SteamcordDiscordAccount, "IsGuildBooster", "isGuildBooster")

function SteamcordDiscordAccount.New()
    local obj = setmetatable({}, SteamcordDiscordAccount)
    return obj
end

function SteamcordDiscordAccount.FromObject(rawObj)
    return SteamcordDiscordAccount.New()
        :SetDiscordId(rawObj.steamId)
        :SetUsername(rawObj.username)
        :SetAvatar(rawObj.avatar)
        :SetIsGuildMember(rawObj.isGuildMember)
        :SetIsGuildBooster(rawObj.isGuildBooster)
end


Steamcord.Objects.DiscordAccount = SteamcordDiscordAccount