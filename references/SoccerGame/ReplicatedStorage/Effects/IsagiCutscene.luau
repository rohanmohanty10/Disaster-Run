  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Knit = require(ReplicatedStorage.Packages.Knit);
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(u1) -- Line: 13
    -- upvalues: ReplicatedStorage (copy), SoundManager (copy), Popup (copy), Knit (copy), CutsceneUtils (copy)
    local game_Workspace = game.Workspace;
    local SpawnPos = u1.SpawnPos;
    local v2 = ReplicatedStorage.Assets.Vfx.PuzzleCutscene:Clone();
    v2.Parent = workspace;
    v2.Area:SetPrimaryPartCFrame(SpawnPos * CFrame.new(0, -3, 0));
    task.spawn(function() -- Line: 27
        -- upvalues: u1 (copy)
        u1.Plr.Character:WaitForChild("Isagi").Volume = 0.1;
    end);
    local VFXObjects = ReplicatedStorage.Assets.Vfx.PuzzleCutscene.VFXObjects;

    local function EnableParticles(p3, u4) -- Line: 34
        local Descendants = p3:GetDescendants();

        for _, v in pairs(Descendants) do
            if v:IsA("ParticleEmitter") then
                task.defer(function() -- Line: 38
                    -- upvalues: v (copy), u4 (copy)
                    v.Enabled = u4;
                end);
            end;
        end;

        table.clear(Descendants);
    end;

    local function EmitParticles(p5) -- Line: 46
        local Descendants = p5:GetDescendants();

        for _, v in pairs(Descendants) do
            if v:IsA("ParticleEmitter") then
                task.defer(function() -- Line: 50
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            end;
        end;

        table.clear(Descendants);
    end;

    SoundManager.SpawnSound("IsagiVoice", 1.5, game.Players.LocalPlayer.PlayerGui, 1);
    task.spawn(function() -- Line: 59
        -- upvalues: Popup (ref), u1 (copy)
        Popup.Subtitle(game.Players.LocalPlayer, "Hey, are you listening, " .. tostring(u1.Plr.Name) .. "?");
    end);
    local _ = Enum.EasingDirection.InOut;
    local _ = Enum.EasingStyle.Cubic;
    local _ = Enum.EasingStyle.Linear;
    local u6 = VFXObjects.Puzzles:Clone();
    u6.Parent = game_Workspace;
    u6.Position = SpawnPos.Position;
    local u7 = VFXObjects.Foot:Clone();
    u7.Parent = game_Workspace;
    u7.Position = SpawnPos * CFrame.new(1, -2.9, 0).Position;
    local u8 = VFXObjects.Foot:Clone();
    u8.Parent = game_Workspace;
    u8.Position = SpawnPos * CFrame.new(-1, -2.9, 0).Position;
    local u9 = VFXObjects.PuzzleDrop:Clone();
    u9.Parent = game_Workspace;
    local v10 = game["Run Service"].Heartbeat:Connect(function() -- Line: 86
        -- upvalues: u6 (copy)
        u6.Orientation = u6.Orientation + Vector3.new(0, 0.75, 0);
    end);
    EnableParticles(u6, true);
    EnableParticles(u7, true);
    EnableParticles(u8, true);
    task.wait(4);
    local Controller = Knit.GetController("AwakeningController");
    u9.PuzzleEmit.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position) * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, -1.5707963267948966);
    u9.Splash.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position) * CFrame.new(0, 3, 0) * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, -1.5707963267948966);
    u9.SplashEmit.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position) * CFrame.new(0, 3, 0) * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, -1.5707963267948966);
    task.spawn(function() -- Line: 105
        -- upvalues: u1 (copy), Controller (copy)
        if game.Players.LocalPlayer ~= u1.Plr then
            return;
        end;

        if Controller.CurrentUlt.CamAnim then
            Controller.CurrentUlt.CamAnim:AdjustSpeed(0.35);
            Controller.AwakeningPlrAnimation:AdjustSpeed(0.35);
        end;
    end);
    EmitParticles(u9.PuzzleEmit);
    task.wait(2);
    task.spawn(function() -- Line: 122
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Blind spot. Off the ball.");
    end);
    EmitParticles(u9.SplashEmit);
    EnableParticles(u9.Splash, true);
    task.wait(1.5);
    task.spawn(function() -- Line: 133
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Blind spot. Off the ball.");
    end);
    task.spawn(function() -- Line: 137
        -- upvalues: u1 (copy), Controller (copy)
        if game.Players.LocalPlayer ~= u1.Plr then
            return;
        end;

        if Controller.CurrentUlt.CamAnim then
            Controller.CurrentUlt.CamAnim:AdjustSpeed(1);
            Controller.AwakeningPlrAnimation:AdjustSpeed(1);
        end;
    end);
    EnableParticles(u9.Splash, false);
    task.wait(1.5);
    EnableParticles(u6, false);
    EnableParticles(u7, false);
    EnableParticles(u8, false);
    task.wait(3);
    task.spawn(function() -- Line: 162
        -- upvalues: u1 (copy)
        u1.Plr.Character:WaitForChild("Isagi").Volume = 0.5;
    end);
    v2:Destroy();
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    v10:Disconnect();
    task.delay(4, function() -- Line: 172
        -- upvalues: u9 (copy), u7 (copy), u8 (copy), u6 (copy)
        u9:Destroy();
        u7:Destroy();
        u8:Destroy();
        u6:Destroy();
    end);
end;