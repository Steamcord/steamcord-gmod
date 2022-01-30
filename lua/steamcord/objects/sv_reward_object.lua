// Copyright 2022 Steamcord LLC
local SteamcordReward = {}
SteamcordReward.__index = SteamcordReward

Steamcord.Utils.BuilderAccessor(SteamcordReward, "Name", "name")
Steamcord.Utils.BuilderAccessor(SteamcordReward, "RewardFunc", "rewardFunc")
Steamcord.Utils.BuilderAccessor(SteamcordReward, "IsRunOnce", "runOnce")
Steamcord.Utils.BuilderAccessor(SteamcordReward, "IsRunOnJoin", "runOnJoin")

function SteamcordReward.New()
    local obj = setmetatable({}, SteamcordReward)
    obj.requirements = {}
    return obj
end

function SteamcordReward.FromConfigObj(name, rawObj)
    return SteamcordReward.New()
        :SetName(name)
        :SetRequirements(rawObj.requirements)
        :SetIsRunOnce(rawObj.runOnce)
        :SetRewardFunc(rawObj.onGiven)
        :SetIsRunOnJoin(rawObj.runOnJoin)
end


function SteamcordReward:AddRequirement(requirement)
    self.requirements[requirement] = true
end

function SteamcordReward:GetRequirements()
    return self.requirements
end

function SteamcordReward:SetRequirements(requirements)
    for requirementName,_ in pairs(requirements) do
        self:AddRequirement(requirementName)
    end
    return self
end

do
    local function injectUtilsIntoEnvironment(targetFunc)
        local oldFEnv = debug.getfenv(targetFunc)
        for k,v in pairs(Steamcord.Rewards.Funcs) do
            oldFEnv[k] = v
        end
        return oldFEnv
    end

    function SteamcordReward:RewardPlayer(ply)
        if not IsEntity(ply) or not ply:IsPlayer() then 
            error("Tried to reward a non player!") 
        end

        if ply:IsBot() then
            error("Tried to reward a bot!")
        end
        
        local rewardFunc = self:GetRewardFunc()
        if not isfunction(rewardFunc) then
            error("Reward Function is not a function.")
        end

        injectUtilsIntoEnvironment(rewardFunc)

        rewardFunc(ply)

        if not self:GetIsRunOnJoin() and self:GetIsRunOnce() then
            Steamcord.Data.SetRedeemed(ply:SteamID64(), self:GetName(), function()
                print("Steamcord Rewarded: ", ply:SteamID64(), self:GetName())
            end)
        end
    end
end

Steamcord.Objects.SteamcordReward = SteamcordReward