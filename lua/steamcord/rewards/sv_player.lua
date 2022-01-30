function Steamcord.Rewards.CheckRewardsForPlayers(player, callback)
    local steamId = player:SteamID64()
    Steamcord.RestAPI.GETPlayer(steamId, function(playerObj)

        local requirements = playerObj:GetAchievedRequirements()
        local rewards = Steamcord.Rewards.FindApplicableRewards(requirements)
        
        for _,reward in ipairs(rewards) do
        
            if reward:GetIsRunOnce() then
                Steamcord.Data.HasRedeemed(steamId, reward:GetName(), function(steamId, rewardType, hasRedeemed)
                    if not hasRedeemed then
                        reward:RewardPlayer(player)
                    end
                    
                end)
            else
                reward:RewardPlayer(player)
            end
        
        end

    end)
end


do

    local cooldowns = {}

    local cooldownDuration = 120

    hook.Add("PlayerSay", "Steamcord::AuthCommand", function(sender, msg, _)
        for _,command in ipairs(Steamcord.Config.ChatCommands) do
            if msg:StartWith(command) then
                local cooldownKey = tostring(sender)
                local curTime = CurTime()
                if cooldowns[cooldownKey] and cooldowns[cooldownKey] > curTime then
                    sender:ChatPrint("You're on cooldown for: " .. tostring( math.floor(cooldowns[cooldownKey] - curTime)) .. " seconds.")
                    return ""
                end
                Steamcord.Rewards.CheckRewardsForPlayers(sender)
                cooldowns[cooldownKey] = curTime + cooldownDuration
            end
        end
    end)

end