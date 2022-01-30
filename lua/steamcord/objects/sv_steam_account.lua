local SteamcordSteamAccount = {}

SteamcordSteamAccount.__index = SteamcordSteamAccount

Steamcord.Utils.BuilderAccessor(SteamcordSteamAccount, "SteamId", "steamId")
Steamcord.Utils.BuilderAccessor(SteamcordSteamAccount, "Username", "username")
Steamcord.Utils.BuilderAccessor(SteamcordSteamAccount, "Avatar", "avatar")
Steamcord.Utils.BuilderAccessor(SteamcordSteamAccount, "IsSteamGroupMember", "isSteamGroupMember")

function SteamcordSteamAccount.New()
    local obj = setmetatable({}, SteamcordSteamAccount)
    return obj
end

function SteamcordSteamAccount.FromObject(rawObj)
    return SteamcordSteamAccount.New()
        :SetSteamId(rawObj.steamId)
        :SetUsername(rawObj.username)
        :SetAvatar(rawObj.avatar)
        :SetIsSteamGroupMember(rawObj.isSteamGroupMember)
end



Steamcord.Objects.SteamAccount = SteamcordSteamAccount