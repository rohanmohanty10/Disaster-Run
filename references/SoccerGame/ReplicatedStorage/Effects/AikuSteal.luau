  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
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

local function EmitBeam(p2, u3) -- Line: 30
    -- upvalues: TweenService (copy)
    for _, descendant in pairs(p2:GetDescendants()) do
        if descendant:IsA("Beam") then
            print(descendant);
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            descendant.Enabled = true;
            TweenService:Create(descendant, TweenInfo.new(0.25), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
            task.delay(u3, function() -- Line: 44
                -- upvalues: TweenService (ref), descendant (copy), u3 (copy)
                TweenService:Create(descendant, TweenInfo.new(u3 / 2), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

return function(p4) -- Line: 55
    -- upvalues: Players (copy), ReplicatedStorage (copy), VfxManager (copy), RunService (copy), TweenService (copy)
    local Char = p4.Char;
    local Enemy = p4.Enemy;
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    local u5 = {};
    tick();
    local _ = game.Workspace.CurrentCamera.FieldOfView;
    local u6 = 0;

    if not Players.LocalPlayer.Character.Values.Goalie.Value then
        local u7 = nil;
        u7 = game:GetService("RunService").RenderStepped:Connect(function(p8) -- Line: 99
            -- upvalues: u6 (ref), u7 (ref)
            u6 = u6 + p8 * 60;
            local script_FOV = script.FOV;
            local math_ceil_ret = math.ceil(u6);
            local v9 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

            if v9 then
                game.Workspace.CurrentCamera.FieldOfView = v9.Value;

                return;
            end;

            u7:Disconnect();
        end);
    end;

    local NagiCam = workspace:FindFirstChild("NagiCam");
    local v10 = script.DarknessScreen:Clone();
    v10.Parent = Folder;
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Parent = v10;
    Motor6D.Part0 = NagiCam.CamPart;
    Motor6D.Part1 = v10;
    Motor6D.C0 = CFrame.new(0, 0, -1.123);
    local u11 = script["Aiku Steal Snake"]:Clone();
    u11.RootPart.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    u11.Parent = Folder;
    u11.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Abilities.CobraRig):Play();
    local u12 = script.GreenAura:Clone();
    u12.Parent = Folder;
    local u13 = script.RedAura:Clone();
    u13.Parent = Folder;
    local u14 = script.Circle:Clone();
    VfxManager.Enable(u14, false);
    u14.Parent = Folder;
    local u15 = script.Suckle:Clone();
    u15.Parent = Folder;
    local u16 = RunService.Heartbeat:Connect(function() -- Line: 143
        -- upvalues: u12 (copy), Char (copy), u13 (copy), Enemy (copy), u14 (copy), u15 (copy), u11 (copy)
        u12.CFrame = Char.Torso.CFrame;
        u13.CFrame = Enemy.Torso.CFrame;
        u14.CFrame = Enemy.Torso.CFrame;
        u15.CFrame = Enemy.Head.CFrame * CFrame.new(0, 0, -1.5);
        u11.RootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    end);
    task.delay(0.1, function() -- Line: 151
        -- upvalues: Char (copy), Folder (copy), VfxManager (ref)
        local v17 = script.Teleport:Clone();
        v17.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(10.5, 1, -10) * CFrame.fromOrientation(1.5707963267948966, -1.5707963267948966, 0);
        v17.Parent = Folder;
        VfxManager.Emit(v17);
    end);
    task.delay(2, function() -- Line: 159
        -- upvalues: VfxManager (ref), u13 (copy), u14 (copy)
        VfxManager.Enable(u13, true);
        VfxManager.Enable(u14, true);
    end);
    task.delay(2.8, function() -- Line: 164
        -- upvalues: VfxManager (ref), u15 (copy), Players (ref), u5 (copy), TweenService (ref)
        VfxManager.Emit(u15);
        local v18 = script.VignetteGui:Clone();
        v18.Overlay.ImageTransparency = 0;
        v18.Parent = Players.LocalPlayer.PlayerGui;
        u5[#u5 + 1] = v18;
        task.wait(0.1);
        TweenService:Create(v18.Overlay, TweenInfo.new(0.25), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(5, function() -- Line: 177
        -- upvalues: u16 (ref), Folder (copy), u5 (copy)
        u16:Disconnect();
        Folder:Destroy();

        for _, v in pairs(u5) do
            v:Destroy();
        end;
    end);
end;