  

game:GetService("UserInputService");
game:GetService("PathfindingService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ContentProvider = game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.Tweens);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local DebugUtil = require(ReplicatedStorage.Shared.DebugUtil);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local u2 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u2:WaitForChild("Humanoid");
local HumanoidRootPart = u2:WaitForChild("HumanoidRootPart");
local _ = workspace.CurrentCamera;
local v3 = Knit.CreateController({
    Name = "EffectsController"
});

function v3.KnitStart(u4) -- Line: 31
    -- upvalues: Knit (copy), VfxManager (copy), ReplicatedStorage (copy), LocalPlayer (copy), DebugUtil (copy), u1 (ref), ContentProvider (copy)
    u4.EffectsService = Knit.GetService("EffectsService");
    u4.Camera = Knit.GetController("CameraController");
    u4.Spectator = Knit.GetController("SpectatorController");
    u4.BaseTrove:Connect(u4.EffectsService.GoalEffects, function(p5, p6) -- Line: 36
        -- upvalues: u4 (copy), VfxManager (ref), ReplicatedStorage (ref)
        if game.Players.LocalPlayer.Team == game.Teams.Visitor and not u4.Spectator.IsSpectating then
            return;
        end;

        VfxManager.Emit(ReplicatedStorage.Assets.GoalEffects[p6], workspace, nil, p5, 10);
    end);
    u4.BaseTrove:Connect(ReplicatedStorage.VfxSpawn.OnClientEvent, function(u7: any, u8: any, p9: number?) -- Line: 41
        -- upvalues: ReplicatedStorage (ref)
        if not ReplicatedStorage.Effects:FindFirstChild(u7.Name, true) then
            return;
        end;

        if p9 then
            task.delay(p9 - workspace:GetServerTimeNow(), function() -- Line: 44
                -- upvalues: u7 (copy), u8 (copy)
                require(u7)(u8);
            end);

            return;
        end;

        require(u7)(u8);
    end);
    u4.BaseTrove:Connect(ReplicatedStorage.VfxSpawnReliable.OnClientEvent, function(u10: any, u11: any, p12: number?) -- Line: 53
        -- upvalues: ReplicatedStorage (ref)
        if not ReplicatedStorage.Effects:FindFirstChild(u10.Name, true) then
            return;
        end;

        if p12 then
            task.delay(p12 - workspace:GetServerTimeNow(), function() -- Line: 56
                -- upvalues: u10 (copy), u11 (copy)
                require(u10)(u11);
            end);

            return;
        end;

        require(u10)(u11);
    end);
    u4.BaseTrove:Connect(u4.EffectsService.Vfx, function(u13, u14) -- Line: 66
        -- upvalues: u4 (copy)
        task.spawn(function() -- Line: 67
            -- upvalues: u4 (ref), u13 (copy), u14 (copy)
            if game.Players.LocalPlayer.Team == game.Teams.Visitor and not u4.Spectator.IsSpectating then
                return;
            end;

            require(u13)(u14);
        end);
    end);
    u4.BaseTrove:Connect(LocalPlayer:GetPropertyChangedSignal("Team"), function() -- Line: 76
        -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref)
        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if ReplicatedStorage.GameValues.State.Value ~= "StartingCutscene" then
            return;
        end;

        if LocalPlayer.Character and LocalPlayer.Character:GetAttribute("CutsceneChar") then
            return;
        end;

        task.spawn(function() -- Line: 80
            -- upvalues: ReplicatedStorage (ref)
            require(ReplicatedStorage.Effects.U20EntranceCutscene)({});
        end);
    end);
    local u15 = DebugUtil.createGroup("Effect Tests");

    local function loadTemporaryCutscene(p16) -- Line: 87
        -- upvalues: u1 (ref)
        u1:RequestTemporaryCutscene(p16);
    end;

    task.delay(1, function() -- Line: 91
        -- upvalues: ReplicatedStorage (ref), u15 (copy), loadTemporaryCutscene (copy)
        for _, v in ReplicatedStorage.Effects:QueryDescendants("ModuleScript:has([Name = \".ctest\"])") do
            local u17 = require(v:FindFirstChild(".ctest"));
            local u18 = require(v);
            u15.addButton(v.Name, v.Name, function() -- Line: 95
                -- upvalues: u17 (copy), loadTemporaryCutscene (ref), u18 (copy)
                u17(loadTemporaryCutscene, u18);
            end);
        end;
    end);
    local Descendants = ReplicatedStorage.Assets.GoalEffects:GetDescendants();

    for _, v in pairs(Descendants) do
        ContentProvider:PreloadAsync({ v });
    end;
end;

function v3.KnitInit(u19) -- Line: 107
    -- upvalues: u1 (ref), Knit (copy), Trove (copy), LocalPlayer (copy), u2 (ref), Humanoid (ref), HumanoidRootPart (ref), EmitModule (copy)
    u1 = Knit.GetService("AwakeningService");
    u19.BaseTrove = Trove.new();
    u19.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p20) -- Line: 112
        -- upvalues: u2 (ref), Humanoid (ref), HumanoidRootPart (ref)
        u2 = p20;
        Humanoid = u2:WaitForChild("Humanoid");
        HumanoidRootPart = u2:WaitForChild("HumanoidRootPart");
    end);
    u19.BaseTrove:Connect(game.Players.PlayerRemoving, function(p21) -- Line: 118
        -- upvalues: LocalPlayer (ref), u2 (ref), HumanoidRootPart (ref), Humanoid (ref), u19 (copy)
        if p21 == LocalPlayer then
            u2 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u19.BaseTrove:Destroy();
        end;
    end);
    EmitModule.init();
end;

return v3;