// Copyright 2022 Steamcord LLC
Steamcord.Rewards.Funcs = {}

function Steamcord.Rewards.Funcs.GiveWeapon(player, weapon)
    assert(IsEntity(player) and player:IsPlayer(), "The player is not a player.")
    assert(isstring(weapon), "The weapon is not a string.")

    player:Give(weapon)
end

function Steamcord.Rewards.Funcs.AddMoney(player, amount)
    assert(IsEntity(player) and player:IsPlayer(), "The player is not a player.")
    assert(isnumber(amount), "The amount of money to give is not a number.")
    
    player:addMoney(amount)
end

function Steamcord.Rewards.Funcs.AddPS2PremiumPoints(player, amount)
    assert(IsEntity(player) and player:IsPlayer(), "The player is not a player.")
    assert(isnumber(amount), "The amount of money to give is not a number.")
    
    player:PS2_AddPremiumPoints(amount)
end

function Steamcord.Rewards.Funcs.AddPS2NormalPoints(player, amount)
    assert(IsEntity(player) and player:IsPlayer(), "The player is not a player.")
    assert(isnumber(amount), "The amount of money to give is not a number.")
    
    player:PS2_AddStandardPoints(amount)
end

function Steamcord.Rewards.Funcs.SetUserGroup(player, usergroup)
    assert(IsEntity(player) and player:IsPlayer(), "The player is not a player.")
    assert(isstring(usergroup), "The usergroup is not a string.")   
    player:SetUserGroup(usergroup)
end

print(weapons.GetStored("weapon_357") ~= nil)