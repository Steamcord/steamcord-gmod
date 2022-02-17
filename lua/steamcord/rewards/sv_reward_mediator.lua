-- Copyright 2022 Steamcord LLC

local RegisteredRewards = {}

for rewardName,configObj in pairs(Steamcord.Config.Rewards) do
    RegisteredRewards[rewardName] = Steamcord.Objects.SteamcordReward.FromConfigObj(rewardName, configObj)
end

--- It is presumed that the requirements are passed with the requirement as the key
--- and the value being a boolean.
function Steamcord.Rewards.FindApplicableRewards(achievedRequirements)
    local reedemableRewards = {}
    for name,rewardObj in pairs(RegisteredRewards) do
        for requirementName,_ in pairs(rewardObj:GetRequirements()) do
            if not achievedRequirements[requirementName] then
                goto nextReward
            end
        end
        reedemableRewards[#reedemableRewards + 1] = rewardObj
        ::nextReward::
    end

    return reedemableRewards
end
