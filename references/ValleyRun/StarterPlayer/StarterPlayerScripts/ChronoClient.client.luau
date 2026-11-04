 

 

if not require(game.ReplicatedFirst:WaitForChild("FFlags")).Chrono then
    return;
end;

local RunService = game:GetService("RunService");
local ChronoSetup = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("ChronoSetup"));
local v1 = ChronoSetup.start();

if not v1 then
    return;
end;

local ClientClock = require(game.ReplicatedStorage.chrono.Client.ClientClock);
local ChronoView = game.ReplicatedStorage.ChickenOrHero.Game:WaitForChild("ChronoView");
local idMap = v1.Holder.idMap;
local u2 = 0;
RunService.Heartbeat:Connect(function(p3) -- Line: 18
    -- upvalues: idMap (copy), ClientClock (copy), u2 (ref), ChronoSetup (copy), ChronoView (copy)
    local v4 = 0;
    local v5 = 0;

    for _, v in idMap do
        local model = v.model;

        if v._player and (not v.isContextOwner and model) then
            local v6 = model:GetAttribute("Ragdolled") ~= true;

            if v.interpolation ~= v6 then
                v.interpolation = v6;
            end;

            if v._clientClock then
                v4 = v4 + ClientClock._getBuffer(v._clientClock);
                v5 = v5 + 1;
            end;
        end;
    end;

    u2 = u2 + p3;

    if u2 >= ChronoSetup.ViewReportSeconds and v5 > 0 then
        u2 = 0;
        ChronoView:FireServer(v4 / v5);
    end;
end);