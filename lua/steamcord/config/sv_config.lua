Steamcord.Config = {
    Api = {
        Token = "Your TokenHere",
        BaseUri = "https://api.steamcord.io"
    },
    ChatCommands = {
        "/claim",
    },
    Data = {
        DatabaseType = "MySQL",
        ConnectionInfo = {
            Host = "127.0.0.1",
            Port = 3306,
            Username = "root",
            Password = "password",
            Database = "rewards"
        }
    },
    ProvisionRwardsOnJoin = true,
    Rewards = {
        ["DiscordAccount"] = {
            onGiven = function(ply)
                AddMoney(ply, 1000)
                AddPS2PremiumPoints(ply, 15000)
                AddPS2NormalPoints(ply, 15000)
                GiveWeapon(ply, "weapon_357")
            end,
            requirements = {
                Steamcord.RestAPI.Enums.MemberOfSteamGroup
            },
            -- Should it be ran when the player joins the server?
            -- If this is true, run once should be false, as this will
            -- take precedence.
            runOnJoin = false,
            -- Added to the selected database, and never given again until wiped.
            runOnce = false
        },
        ["SteamAccount"] = {
            onGiven = function(ply)

            end,
            requirements = {
                Steamcord.RestAPI.Enums.MemberOfSteamGroup
            },
            -- Should it be ran when the player joins the server?
            -- If this is selected, run once should be false, as this will
            -- take precedence.
            runOnJoin = false,
            -- Given once?
            runOnce = true
        }
    },
    UpdateSteamGroups = true
}