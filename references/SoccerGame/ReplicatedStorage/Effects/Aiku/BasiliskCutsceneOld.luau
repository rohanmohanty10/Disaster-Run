  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);

local function EmitAll(p1) -- Line: 12
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 15
                -- upvalues: descendant (copy)
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;

                if descendant:GetAttribute("EmitDuration") then
                    descendant.Enabled = true;
                    task.wait(descendant:GetAttribute("EmitDuration"));
                    descendant.Enabled = false;
                end;
            end);
        end;
    end;
end;

local function EmitBeam(p2) -- Line: 30
    -- upvalues: TweenService (copy)
    for _, descendant in pairs(p2:GetDescendants()) do
        if descendant:IsA("Beam") then
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            descendant.Enabled = true;
            local Attribute = descendant:GetAttribute("EmitDuration");
            TweenService:Create(descendant, TweenInfo.new(0.25), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
            task.delay(Attribute, function() -- Line: 44
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(0.1), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

return function(p3) -- Line: 55
    -- upvalues: TweenService (copy), RunService (copy), EmitBeam (copy), VfxManager (copy)
    local Char = p3.Char;
    local _ = p3.Enemy;
    Instance.new("Folder").Parent = workspace.Debris;
    local u4 = {};
    tick();
    local _ = game.Workspace.CurrentCamera.FieldOfView;
    local u5 = 0;
    local ClockTime = game.Lighting.ClockTime;
    task.delay(3.3, function() -- Line: 71
        local u6 = 0;
        task.spawn(function() -- Line: 73
            -- upvalues: u6 (ref)
            for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesBasilisk:GetChildren() do
                child.Position = UDim2.new(0.5, 0, 1.5, 0);
            end;

            game.Players.LocalPlayer.PlayerGui.ImpactFramesBasilisk.Enabled = true;

            for i = 1, 5 do
                task.delay(u6, function() -- Line: 79
                    -- upvalues: i (copy)
                    local ImpactFramesBasilisk = game.Players.LocalPlayer.PlayerGui.ImpactFramesBasilisk;

                    if i > 1 then
                        ImpactFramesBasilisk[`Frame{tostring(i - 1)}`].Position = UDim2.new(0.5, 0, 2, 0);
                    end;

                    ImpactFramesBasilisk[`Frame{tostring(i)}`].Position = UDim2.new(0.5, 0, 0.5, 0);
                end);
                u6 = u6 + 0.05;
                local _ = i;
            end;

            task.delay(u6, function() -- Line: 89
                for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesBasilisk:GetChildren() do
                    child.Position = UDim2.new(0.5, 0, 1.5, 0);
                end;

                game.Players.LocalPlayer.PlayerGui.ImpactFramesBasilisk.Enabled = false;
            end);
        end);
    end);
    local Players = game:GetService("Players");
    local Values = Players.LocalPlayer.Character.Values;

    if not (Values.Goalie.Value or (Values.IsInPenalty.Value or Players.LocalPlayer.Team == game.Teams.Visitor)) then
        local u7 = nil;
        u7 = game:GetService("RunService").RenderStepped:Connect(function(p8) -- Line: 104
            -- upvalues: u5 (ref), u7 (ref)
            u5 = u5 + p8 * 60;
            local script_FOV = script.FOV;
            local math_ceil_ret = math.ceil(u5);
            local v9 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

            if v9 then
                game.Workspace.CurrentCamera.FieldOfView = v9.Value;

                return;
            end;

            u7:Disconnect();
        end);
        local u10 = script.DepthOfField:Clone();
        u10.Parent = game:GetService("Lighting");
        local u11 = script.Red_Inverted:Clone();
        u11.Parent = game:GetService("Lighting");
        task.delay(1.2, function() -- Line: 134
            -- upvalues: TweenService (ref), u11 (copy)
            TweenService:Create(u11, TweenInfo.new(0.25), {
                TintColor = Color3.fromRGB(207, 21, 21)
            }):Play();
            task.wait(0.25);
            TweenService:Create(u11, TweenInfo.new(0.35), {
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.wait(0.2);
        end);
        task.delay(0.35, function() -- Line: 144
            -- upvalues: TweenService (ref), u10 (copy)
            TweenService:Create(u10, TweenInfo.new(0.15), {
                FocusDistance = 0,
                InFocusRadius = 25,
                FarIntensity = 1,
                NearIntensity = 0
            }):Play();
            task.wait(0.15);
            TweenService:Create(u10, TweenInfo.new(1.667), {
                FocusDistance = 90,
                InFocusRadius = 0,
                FarIntensity = 0.21,
                NearIntensity = 0
            }):Play();
            task.wait(1.667);
            TweenService:Create(u10, TweenInfo.new(0.2), {
                FocusDistance = 0,
                InFocusRadius = 25,
                FarIntensity = 1,
                NearIntensity = 0
            }):Play();
            task.wait(0.2);
        end);
        u11.TintColor = Color3.fromRGB(207, 21, 21);
        TweenService:Create(u11, TweenInfo.new(0.35), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        game.Lighting.ClockTime = 0.341;
    end;

    workspace:FindFirstChild("NagiCam");
    local u12 = script.VFX:Clone();
    u12:PivotTo(Char.HumanoidRootPart.CFrame);
    u12.Parent = workspace.Debris;
    local GlowAura = u12.GlowAura;
    local u13 = RunService.Heartbeat:Connect(function() -- Line: 174
        -- upvalues: GlowAura (copy), Char (copy)
        GlowAura.CFrame = Char.Torso.CFrame;
    end);
    task.delay(1.29, function() -- Line: 178
        -- upvalues: u12 (copy), EmitBeam (ref), VfxManager (ref)
        EmitBeam(u12.BackgroundBeam);
        VfxManager.Emit(u12.DarknessScreen);
        task.wait(0.3);
        VfxManager.Emit(u12.Pop);
    end);
    task.delay(3.2, function() -- Line: 191
        -- upvalues: VfxManager (ref), u12 (copy)
        VfxManager.Emit(u12.FinalHit);
    end);
    task.delay(4, function() -- Line: 195
        -- upvalues: u13 (ref), u12 (copy), ClockTime (copy), u4 (copy)
        u13:Disconnect();
        u12:Destroy();
        game.Lighting.ClockTime = ClockTime;

        for _, v in pairs(u4) do
            v:Destroy();
        end;
    end);
end;