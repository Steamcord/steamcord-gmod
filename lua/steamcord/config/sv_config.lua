Steamcord.Config = {
    Api = {
        Token = "Your TokenHere",
        BaseUri = "https://api.steamcord.io"
    },
    ChatCommands = {
        "/claim",
    },
    Data = {
        DatabaseType = "mysql",
        ConnectionInfo = {
            Host = "127.0.0.1",
            Port = 3306,
            Username = "root",
            Password = "password",
            Database = "rewards"
        }
    },
    Rewards = {
        ["DiscordAccount"] = {
            OnGiven = function(ply)
                AddMoney(ply, 1000)
                AddPS2PremiumPoints(ply, 15000)
                AddPS2NormalPoints(ply, 15000)
                GiveWeapon(ply, "weapon_357")
            end,
            Requirements = {
                Steamcord.RestAPI.Enums.SteamGroupMember
            },
            -- Should it be ran when the player joins the server?
            -- If this is true, run once should be false, as this will
            -- take precedence.
            ProvisionOnJoin = false,
            -- Added to the selected database, and never given again until wiped.
            ProvisionOnce = false
        },
        ["SteamAccount"] = {
            OnGiven = function(ply)

            end,
            Requirements = {
                Steamcord.RestAPI.Enums.SteamGroupMember
            },
            -- Should it be ran when the player joins the server?
            -- If this is selected, run once should be false, as this will
            -- take precedence.
            ProvisionOnJoin = false,
            -- Given once?
            ProvisionOnce = true
        }
    },
    UpdateSteamGroups = true
}