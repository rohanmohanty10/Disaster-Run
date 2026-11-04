  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.EmitModule).init();
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
require(ReplicatedStorage.Shared.LoadParticleRig);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
require(ReplicatedStorage.VfxManager);
require(ReplicatedStorage.Shared.utils.highlightEffect);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local u1 = {
    [script.Movement] = CFrame.new(
        0.483093262,
        -0.500312805,
        -14.1691017,
        1,
        0,
        0,
        0,
        -0.0871556997,
        0.996194422,
        0,
        -0.996194601,
        -0.0871556774
    ),
    [script.EndEmit] = CFrame.new(
        0.11781311,
        -0.308596849,
        -32.1397858,
        0.0406378321,
        0,
        -0.999174774,
        0,
        1,
        0,
        0.999174654,
        0,
        0.0406378731
    ),
    [script.Startup] = CFrame.new(0, -2.84838033, -0.757770538, 0.00298922369, 0, -1, 0, -1, 0, -1, 0, -0.00298900018)
};

return function(p2: table) -- Line: 19
    -- upvalues: SpectatorController (copy), SoundManager (copy), Essentials (copy), u1 (copy), EmitModule (copy)
    local HumanoidRootPart = p2.Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if p2.OnBall then
        task.delay(0.6, function() -- Line: 31
            -- upvalues: SoundManager (ref), HumanoidRootPart (copy)
            SoundManager.SpawnSound("ExplosiveAcceleration1", 0.75, HumanoidRootPart, 160);
        end);
    elseif p2.VelocityDash then
        SoundManager.SpawnSound("BunnyDash", 0.75, HumanoidRootPart, 160);
        local v3 = script.Trail:Clone();
        v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.179603577, 0.184664011, -0.188039303, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        v3.Parent = workspace.Debris;
        Essentials:WeldOffset(HumanoidRootPart, v3, CFrame.new(-0.179603577, 0.184664011, -0.188039303, 1, 0, 0, 0, 1, 0, 0, 0, 1));

        for _, descendant in v3:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(0.5, v3.Destroy, v3);
    else
        task.delay(0.3, function() -- Line: 47
            -- upvalues: SoundManager (ref), HumanoidRootPart (copy)
            SoundManager.SpawnSound("ExplosiveAcceleration1", 0.75, HumanoidRootPart, 160);
        end);
    end;

    for i, v in u1 do
        local v4 = i:Clone();
        v4:PivotTo(HumanoidRootPart.CFrame * v);
        v4.Parent = workspace.Debris;
        task.delay(5, v4.Destroy, v4);
        EmitModule.emit(v4);
    end;
end;