 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Zone = require(ReplicatedStorage.Effects.Base.Zone);

return function(u1, p2) -- Line: 16
    -- upvalues: Effects (copy), SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), Zone (copy), ReplicatedStorage (copy), VfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = p2.Character;
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 0.5);
    local Torso = Character:WaitForChild("Torso", 0.5);
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local u4 = game.Players:FindFirstChild(Character.Name) or game.Players:GetPlayerFromCharacter(Character);
    task.delay(0.2, function() -- Line: 25
        -- upvalues: Effects (ref), u4 (copy)
        Effects:SubtitleV2({
            {
                u4,
                "The only one who can finish this...",
                3,
                1
            },
            { u4, "...is <animation style=\"glitch\">ME!</animation>", 1.5 }
        });
    end);
    SfxManager:playSound({
        Sound = "AceAwaken",
        Parent = workspace
    });
    local u5 = 0;
    local u6 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 50
        -- upvalues: u1 (copy), u6 (ref), u5 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u6:Disconnect();

            return;
        end;

        if u5 <= 0 then
            u5 = p7 * 60 * u3;
        end;

        u5 = u5 + p7 * 60;
        local v8 = script_Fov[math.ceil(u5)];

        if v8 ~= nil then
            if math.ceil(u5) >= #script_Fov then
                u6:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v8, p7 * 6);
        end;
    end);
    Zone(u1, {
        Hide = true,
        Time = 7.1,
        Char = Character
    });
    local u9 = ReplicatedStorage.Assets.AwakeningAssets.AceJacket:Clone();
    u9.PrimaryPart.Anchored = false;
    u9.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1, 0) * CFrame.fromEulerAngles(0, 3.141592653589793, 0);
    u9.Parent = workspace.Debris;
    u9.PrimaryPart.Transparency = 1;
    Essentials:Weld(u9.PrimaryPart, HumanoidRootPart);
    u9.AnimationController.Animator:LoadAnimation(script.JacketAnim):Play();
    local u10 = script.VFX:Clone();
    u10.Parent = workspace.Debris;
    u10:PivotTo(HumanoidRootPart.CFrame);
    local u11 = script.VFXHead.VFX:Clone();
    u11.Parent = Character:FindFirstChild("Head");
    local MainAura = u10.CharacterFX.MainAura;
    MainAura.CFrame = Torso.CFrame * CFrame.new(0.33, -2.947, -0.277) * CFrame.Angles(0.09231046413798008, -0.27445302487610834, 0.03028146252210162);
    Essentials:Weld(Torso, MainAura);
    local camera = CamRig.camera;
    local u12 = script.CAMVFX.Bottom:Clone();
    local u13 = script.CAMVFX.Top:Clone();
    u12.Parent = u10;
    u13.Parent = u10;
    u12.CFrame = camera.CFrame * CFrame.new(-0.069, -0.642, -3.12) * CFrame.Angles(1.4689912715260673, -2.787988947135742, -1.0733600366839928);
    Essentials:Weld(camera, u12);
    u13.CFrame = camera.CFrame * CFrame.new(-0.093, 0.808, -3.788) * CFrame.Angles(1.4690087248185875, -2.7880064004282623, -1.0733600366839928);
    Essentials:Weld(camera, u13);
    task.delay(0.22 - u3, function() -- Line: 106
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Emit(u10.Jump1);
    end);
    task.delay(1.18 - u3, function() -- Line: 110
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Emit(u10.Jump2);
    end);
    task.delay(1.85 - u3, function() -- Line: 114
        -- upvalues: VfxManager (ref), MainAura (copy)
        VfxManager.Enable(MainAura, true);
    end);
    task.delay(1.98 - u3, function() -- Line: 118
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Emit(u10.Jump3);
    end);
    task.delay(2.5 - u3, function() -- Line: 122
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Emit(u10.Jump4);
    end);
    task.delay(3.35 - u3, function() -- Line: 126
        -- upvalues: VfxManager (ref), u13 (copy), u12 (copy), u10 (copy)
        VfxManager.Enable(u13, true);
        VfxManager.Enable(u12, true);
        u10.Sphere.Transparency = 1;
        u10.Sphere2.Transparency = 0;
        VfxManager.Enable(u10.Sphere, true);
        VfxManager.Enable(u10.AuraBACKGROUND, true);
    end);
    task.delay(3.76 - u3, function() -- Line: 136
        -- upvalues: VfxManager (ref), u10 (copy), u11 (copy)
        VfxManager.Emit(u10.Eyeemit);
        VfxManager.Enable(u11, true);
    end);
    task.delay(5.25 - u3, function() -- Line: 141
        -- upvalues: u9 (copy)
        u9.PrimaryPart.Transparency = 0;
    end);
    task.delay(7.05 - u3, function() -- Line: 145
        -- upvalues: u10 (copy), u9 (copy), u11 (copy)
        u10:Destroy();
        u9:Destroy();
        u11:Destroy();
    end);
end;