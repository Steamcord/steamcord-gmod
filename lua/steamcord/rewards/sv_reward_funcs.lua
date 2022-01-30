Steamcord.Rewards.Funcs = {}

function Steamcord.Rewards.Funcs.GiveWeapon(player, weapon)
    assert(IsEntity(player) and player:isPlayer(), "The player is not a player.")
    
    assert(isstring(weapon), "The weapon is not a string.")
    assert(weapons.Get(weapon) ~= nil, "The weapon is not a valid weapon class!")

    player:Give(weapon)
end

function Steamcord.Rewards.Funcs.AddMoney(player, amount)
    assert(IsEntity(player) and player:isPlayer(), "The player is not a player.")
    assert(isnumber(amount), "The amount of money to give is not a number.")
    
    player:addMoney(amount)
end

function Steamcord.Rewards.Funcs.AddMoney(player, amount)
    assert(IsEntity(player) and player:isPlayer(), "The player is not a player.")
    assert(isnumber(amount), "The amount of money to give is not a number.")
    
    player:addMoney(amount)
end

function Steamcord.Rewards.Funcs.AddPS1Points(player, amount)
    assert(IsEntity(player) and player:isPlayer(), "The player is not a player.")
    assert(isnumber(amount), "The amount of money to give is not a number.")
    
    player:PS_GivePoints(amount)
end

function Steamcord.Rewards.Funcs.AddPS2PremiumPoints(player, amount)
    assert(IsEntity(player) and player:isPlayer(), "The player is not a player.")
    assert(isnumber(amount), "The amount of money to give is not a number.")
    
    player:PS2_AddPremiumPoints(amount)
end

function Steamcord.Rewards.Funcs.AddPS2NormalPoints(player, amount)
    assert(IsEntity(player) and player:isPlayer(), "The player is not a player.")
    assert(isnumber(amount), "The amount of money to give is not a number.")
    
    player:PS2_AddStandardPoints(amount)
end

function Steamcord.Rewards.Funcs.SetUserGroup(player, amount)
    assert(IsEntity(player) and player:isPlayer(), "The player is not a player.")
    assert(isnumber(amount), "The amount of money to give is not a number.")
    
    player:SetUserGroup(amount)
end
