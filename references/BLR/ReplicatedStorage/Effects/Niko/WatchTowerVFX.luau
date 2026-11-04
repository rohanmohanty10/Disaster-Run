  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local _ = Players.LocalPlayer;

local function getRelativeOffset(p1, p2) -- Line: 20
    return p1:ToObjectSpace(p2);
end;

return function(p3) -- Line: 24
    -- upvalues: SpectatorController (copy), Essentials (copy), VfxManager (copy), Debris (copy), SoundManager (copy), CutsceneUtils (copy), ReplicatedStorage (copy), RunService (copy)
    local Player = p3.Player;
    local Character = Player.Character;

    if not Character then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        local u4 = {};

        local function CreateEffect(p5, p6, p7) -- Line: 40
            -- upvalues: HumanoidRootPart (copy), Essentials (ref), VfxManager (ref), u4 (copy), Debris (ref)
            local v8 = p5:Clone();
            v8.CFrame = HumanoidRootPart.CFrame * p6 or CFrame.identity;
            v8.Parent = workspace.Debris;

            if p7 then
                if p6 then
                    Essentials:WeldOffset(p7, v8, p6);
                else
                    Essentials:Weld(p7, v8);
                end;
            end;

            VfxManager.Emit(v8);
            table.insert(u4, v8);
            Debris:AddItem(v8, 2);
        end;

        local u9 = SoundManager.SpawnSound("NELIsagiMetavisionLoop", 0.7, workspace, 150, true, true);
        u9:Play();

        local function Disable() -- Line: 63
            -- upvalues: u4 (copy), u9 (copy), CutsceneUtils (ref), ReplicatedStorage (ref), Disable (ref)
            task.spawn(function() -- Line: 64
                -- upvalues: u4 (ref)
                for _, v in u4 do
                    warn("Destroying");

                    if v then
                        v:Destroy();
                    end;
                end;
            end);
            u9:Destroy();
            CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);

            if Disable then
                Disable = nil;
            end;
        end;

        task.spawn(function() -- Line: 77
            -- upvalues: RunService (ref), ReplicatedStorage (ref), Disable (ref), Player (copy)
            RunService.RenderStepped:Connect(function() -- Line: 78
                -- upvalues: ReplicatedStorage (ref), Disable (ref), Player (ref)
                if ReplicatedStorage.GameValues.State.Value ~= "Playing" then
                    if Disable then
                        Disable();
                    end;

                    return;
                end;

                if Player.Character.Values.HasBall.Value and Disable then
                    Disable();
                end;

                if Player.PlayerStats.InAwakening.Value ~= true and Player.Team ~= game.Teams.Visitor then
                    return;
                end;

                if Disable then
                    Disable();
                end;
            end);
        end);
        local v10 = script.Model:Clone();
        v10.Parent = workspace.Debris;
        table.insert(u4, v10);
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        task.delay(8, function() -- Line: 104
            -- upvalues: Disable (ref)
            if Disable then
                Disable();
            end;
        end);

        return v10;
    end;
end;