  

local ReplicatedStorage = game:GetService("ReplicatedStorage");

if require(ReplicatedStorage.Shared.environment).mode == "Ranked" then
    return;
end;

local Knit = require(ReplicatedStorage.Packages.Knit);
Knit.OnStart():await();
local Service = Knit.GetService("TeamService");
local u1 = false;
local BindableEvent = Instance.new("BindableEvent");
BindableEvent.Event:connect(function() -- Line: 13
    -- upvalues: Service (copy)
    if game.Players.LocalPlayer:GetAttribute("PackBusy") then
        return;
    end;

    print("im running..?");

    if game.Players.LocalPlayer.Team == game.Teams.Visitor then
        print("visitor, set health 0");
        game.Players.LocalPlayer.Character.Humanoid.Health = 0;

        return;
    end;

    print("team service return");
    Service.Return:Fire();
end);

local function rebindReset() -- Line: 26
    -- upvalues: BindableEvent (copy)
    local v2 = false;

    while not v2 do
        v2 = pcall(function() -- Line: 29
            -- upvalues: BindableEvent (ref)
            game:GetService("StarterGui"):SetCore("ResetButtonCallback", BindableEvent);
        end);

        if v2 then
            return;
        end;

        wait(0.2);
    end;
end;

game.Players.LocalPlayer:GetAttributeChangedSignal("PackBusy"):Connect(function() -- Line: 36
    -- upvalues: rebindReset (copy)
    if game.Players.LocalPlayer:GetAttribute("PackBusy") then
        game:GetService("StarterGui"):SetCore("ResetButtonCallback", false);

        return;
    end;

    game:GetService("StarterGui"):SetCore("ResetButtonCallback", true);
    rebindReset();
end);
ReplicatedStorage.GameValues.AwakeningCutscene.Changed:Connect(function(p3) -- Line: 46
    -- upvalues: u1 (ref), BindableEvent (copy)
    print("cutscen val changed: ", p3);

    if p3 then
        game:GetService("StarterGui"):SetCore("ResetButtonCallback", false);

        return;
    end;

    game:GetService("StarterGui"):SetCore("ResetButtonCallback", true);
    u1 = false;

    while not u1 do
        u1 = pcall(function() -- Line: 56
            -- upvalues: BindableEvent (ref)
            game:GetService("StarterGui"):SetCore("ResetButtonCallback", BindableEvent);
        end);

        if u1 then
            return;
        end;

        print("coregui being slow for ResetButtonCallback");
        wait(0.2);
    end;
end);

while true do
    u1 = u1 or pcall(function() -- Line: 70
        -- upvalues: BindableEvent (copy)
        game:GetService("StarterGui"):SetCore("ResetButtonCallback", BindableEvent);
    end);

    if u1 then
        break;
    end;

    print("coregui being slow for ResetButtonCallback");
    wait(0.2);
end;