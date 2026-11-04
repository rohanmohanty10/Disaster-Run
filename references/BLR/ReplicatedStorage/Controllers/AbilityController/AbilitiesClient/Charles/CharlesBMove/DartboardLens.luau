  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(u1, p2, u3) -- Line: 15, Name: DartboardLens
    -- upvalues: Popup (copy), SoundManager (copy), ReplicatedStorage (copy), AbilityBalancing (copy), TweenService (copy), Players (copy)
    if u3:GetAttribute("DartboardLens") then
        Popup.Popup(p2, "Dartboard Lens already active!");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    SoundManager.SpawnSound("NELIsagiMetavisionStart", 0.7, workspace, 150);
    require(ReplicatedStorage.Effects.Charles.DartboardLensVFX)();
    u1:AbilityCooldown("3", AbilityBalancing.DartboardLens.Cooldown);
    u1.AbilityService.Ability:Fire("DartboardLens");
    u1.StatesController.SpeedBoost = AbilityBalancing.DartboardLens.MoveSpeedValue;
    local u4 = {};
    local u5 = false;

    local function DISABLE() -- Line: 34
        -- upvalues: u5 (ref), u1 (copy), u4 (copy)
        if u5 then
            return;
        end;

        u1.StatesController.SpeedBoost = 0;
        u5 = true;

        if u1.ABC then
            u1.ABC:Clean();
        end;

        for _, v in pairs(u4) do
            v:Destroy();
        end;
    end;

    local function CreateGui(p6) -- Line: 48
        -- upvalues: u4 (copy)
        local v7 = script.DartboardLens:Clone();
        v7.Abilities.Dribble.Cooldown.Fill.Size = UDim2.new(0, 0, 1, 0);
        v7.Parent = p6.HumanoidRootPart;
        table.insert(u4, v7);

        return v7;
    end;

    u1.ABC:Connect(u1.BallService.UpdateDribbleCooldown, function(p8, p9) -- Line: 58
        -- upvalues: u3 (copy), u4 (copy), TweenService (ref)
        if p8 == u3 then
            return;
        end;

        local DartboardLens = p8.HumanoidRootPart:FindFirstChild("DartboardLens");

        if not DartboardLens then
            DartboardLens = script.DartboardLens:Clone();
            DartboardLens.Abilities.Dribble.Cooldown.Fill.Size = UDim2.new(0, 0, 1, 0);
            DartboardLens.Parent = p8.HumanoidRootPart;
            table.insert(u4, DartboardLens);
        end;

        DartboardLens.Abilities.Dribble.Cooldown.Fill.Size = UDim2.new(1, 0, 1, 0);
        TweenService:Create(DartboardLens.Abilities.Dribble.Cooldown.Fill, TweenInfo.new(p9, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, 0, 1, 0)
        }):Play();
    end);
    u1.ABC:Connect(p2.CharacterRemoving, function() -- Line: 65
        -- upvalues: DISABLE (copy)
        DISABLE();
    end);

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= p2 then
            local Character = v.Character;
            local v10 = script.DartboardLens:Clone();
            v10.Abilities.Dribble.Cooldown.Fill.Size = UDim2.new(0, 0, 1, 0);
            v10.Parent = Character.HumanoidRootPart;
            table.insert(u4, v10);
        end;
    end;

    task.wait(20);
    DISABLE();
end;