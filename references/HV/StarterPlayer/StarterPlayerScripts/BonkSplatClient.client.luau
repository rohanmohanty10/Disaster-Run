 

 

local Players = game:GetService("Players");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local SkinCatalog = require(ChickenOrHero:WaitForChild("Weapons"):WaitForChild("SkinCatalog"));
local BonkSplat = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("BonkSplat"));
local u1;

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots then
    u1 = require(ChickenOrHero:WaitForChild("Bots"):WaitForChild("BotDirectory")) or nil;
else
    u1 = nil;
end;

local u9 = ChickenOrHero:WaitForChild("Audio"):WaitForChild("Events").OnClientEvent:Connect(function(p2, p3) -- Line: 11
    -- upvalues: SkinCatalog (copy), Players (copy), BonkSplat (copy), u1 (copy)
    if p2 ~= "DaggerHit" or (type(p3) ~= "table" or typeof(p3.position) ~= "Vector3") then
        return;
    end;

    local v4 = SkinCatalog.get(p3.skin);

    if not v4 or v4.HitEffect ~= "Splat" then
        return;
    end;

    local runner = p3.runner;
    local v5;

    if type(runner) == "number" then
        v5 = Players:GetPlayerByUserId(runner);
    else
        v5 = false;
    end;

    if v5 and v5.Character then
        BonkSplat.play(v5.Character, p3.position);

        return;
    end;

    local v6 = u1;

    if v6 then
        if type(runner) == "number" then
            v6 = u1.get(runner);
        else
            v6 = false;
        end;
    end;

    local v7 = v6 and v6.Character and v6.Character:FindFirstChild("Head");
    local bonk = BonkSplat.bonk;
    local v8;

    if v7 and v7:IsA("BasePart") then
        v8 = v7.Position;
    else
        v8 = p3.position + Vector3.new(0, 1.5, 0);
    end;

    bonk(v8);
end);
script.Destroying:Connect(function() -- Line: 30
    -- upvalues: u9 (copy), BonkSplat (copy)
    u9:Disconnect();
    BonkSplat.clear();
end);