  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

local function EmitAll(p1) -- Line: 13
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 16
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

local function EmitBeam(p2) -- Line: 31
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
            task.delay(Attribute, function() -- Line: 45
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(0.1), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

return function(u3) -- Line: 54
    -- upvalues: Players (copy), SpectatorController (copy), VfxManager (copy), Debris (copy), TweenService (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = u3.Char.HumanoidRootPart;
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    tick();
    local _ = game.Workspace.CurrentCamera.FieldOfView;
    local u4 = 0;
    local _ = game.Lighting.ClockTime;

    if not Players.LocalPlayer.Character.Values.Goalie.Value then
        local u5 = nil;
        u5 = game:GetService("RunService").RenderStepped:Connect(function(p6) -- Line: 74
            -- upvalues: u4 (ref), u5 (ref)
            u4 = u4 + p6 * 60;
            local script_FOV = script.FOV;
            local math_ceil_ret = math.ceil(u4);
            local v7 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

            if v7 then
                game.Workspace.CurrentCamera.FieldOfView = v7.Value;

                return;
            end;

            u5:Disconnect();
        end);
    end;

    task.delay(3.3, function() -- Line: 87
        local u8 = 0;
        task.spawn(function() -- Line: 89
            -- upvalues: u8 (ref)
            for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesBasilisk:GetChildren() do
                child.Position = UDim2.new(0.5, 0, 1.5, 0);
            end;

            game.Players.LocalPlayer.PlayerGui.ImpactFramesBasilisk.Enabled = true;

            for i = 1, 5 do
                task.delay(u8, function() -- Line: 95
                    -- upvalues: i (copy)
                    local ImpactFramesBasilisk = game.Players.LocalPlayer.PlayerGui.ImpactFramesBasilisk;

                    if i > 1 then
                        ImpactFramesBasilisk[`Frame{tostring(i - 1)}`].Position = UDim2.new(0.5, 0, 2, 0);
                    end;

                    ImpactFramesBasilisk[`Frame{tostring(i)}`].Position = UDim2.new(0.5, 0, 0.5, 0);
                end);
                u8 = u8 + 0.05;
                local _ = i;
            end;

            task.delay(u8, function() -- Line: 105
                for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesBasilisk:GetChildren() do
                    child.Position = UDim2.new(0.5, 0, 1.5, 0);
                end;

                game.Players.LocalPlayer.PlayerGui.ImpactFramesBasilisk.Enabled = false;
            end);
        end);
    end);
    local NagiCam = workspace:FindFirstChild("NagiCam");
    local Basilisk = Folder:FindFirstChild("Basilisk");
    local u9;

    if Basilisk then
        u9 = script.BiteWeld:Clone();
        u9.RigidConstraint.Attachment1 = Basilisk.RootPart["Bone.005"]["Bone.004"]["Bone.003"]["Bone.002"];
        u9.Parent = Folder;
    else
        u9 = nil;
    end;

    local u10 = script.Wind:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Folder;
    VfxManager.Enable(u10.WindEnable, true);
    local u11 = script.Atmosphere:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;

    for _, child in u11.black:GetChildren() do
        child.Transparency = 1;
    end;

    local v12 = script.Spinners:Clone();
    v12:PivotTo(HumanoidRootPart.CFrame);
    v12.Parent = Folder;
    local Outer1 = v12.Outer1;
    Outer1.Mesh1.Scale = Vector3.new(0, 0, 0);
    local Outer0 = v12.Outer0;
    Outer0.Mesh.Scale = Vector3.new(0, 0, 0);

    if u9 then
        VfxManager.Emit(u9);
    end;

    local u13 = script.Red_Inverted:Clone();
    u13.Parent = game.Lighting;
    Debris:AddItem(u13, 4);
    u13.TintColor = Color3.fromRGB(207, 21, 21);
    u13.Contrast = -3;
    u13.Saturation = -1;
    TweenService:Create(u13, TweenInfo.new(0.22), {
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(0.08, function() -- Line: 169
        -- upvalues: NagiCam (copy), TweenService (ref)
        for _, descendant in NagiCam.CamPart.Beams:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        task.wait(0.3);
        local DepthOfField = game.Lighting.DepthOfField;
        TweenService:Create(DepthOfField, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FocusDistance = 0,
            InFocusRadius = 25,
            FarIntensity = 1,
            NearIntensity = 0
        }):Play();
        task.wait(0.9);
        TweenService:Create(DepthOfField, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FocusDistance = 90,
            InFocusRadius = 0,
            FarIntensity = 0.21,
            NearIntensity = 0
        }):Play();
        task.wait(1.2);
        TweenService:Create(DepthOfField, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FocusDistance = 0,
            InFocusRadius = 25,
            FarIntensity = 1,
            NearIntensity = 0
        }):Play();
        task.wait(3);
        TweenService:Create(DepthOfField, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FocusDistance = 90,
            InFocusRadius = 0,
            FarIntensity = 0.21,
            NearIntensity = 0
        }):Play();
    end);
    task.delay(0.27, function() -- Line: 193
        -- upvalues: u9 (ref), VfxManager (ref), u3 (copy), TweenService (ref)
        if u9 then
            VfxManager.Emit(u9);
        end;

        VfxManager.Enable(u3.BallRig, true);
        TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
            Size = 55
        }):Play();
    end);
    task.delay(3, function() -- Line: 209
        -- upvalues: TweenService (ref)
        local Blur = game.Lighting.Blur;
        TweenService:Create(Blur, TweenInfo.new(0.03), {
            Size = 55
        }):Play();
        task.wait(0.03);
        TweenService:Create(Blur, TweenInfo.new(0.04), {
            Size = 0
        }):Play();
    end);
    task.delay(3.02, function() -- Line: 217
    end);
    task.delay(1.55, function() -- Line: 221
        -- upvalues: NagiCam (copy)
        NagiCam.CamPart.Attachment["fast-burst"].Enabled = true;
        task.wait(1.45);
        NagiCam.CamPart.Attachment["fast-burst"].Enabled = false;
    end);
    task.delay(1.13, function() -- Line: 228
        -- upvalues: TweenService (ref), u13 (copy)
        TweenService:Create(u13, TweenInfo.new(0.15), {
            Contrast = -3,
            Saturation = -1,
            TintColor = Color3.fromRGB(207, 21, 21)
        }):Play();
        task.wait(0.15);
        TweenService:Create(u13, TweenInfo.new(0.11), {
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(1.31, function() -- Line: 235
        -- upvalues: NagiCam (copy), VfxManager (ref), u10 (copy), u11 (copy)
        for _, descendant in NagiCam.CamPart.Beams:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        VfxManager.Enable(u10.WindEnable, false);
        task.wait(0.02);
        u11.AtmosphereWorldEnable.Dots.Enabled = true;
        u11.AtmosphereWorldEnable.glare1.Enabled = true;
        u11.black.Decal.Transparency = 0.9;
        u11.black.Decal1.Transparency = 0.9;
        u11.black.Texture.Transparency = 0;
        u11.black.Texture1.Transparency = 0;
    end);
    task.delay(1.38, function() -- Line: 256
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Enable(u10.WindEnableV2, true);
    end);
    task.delay(1.36, function() -- Line: 261
        -- upvalues: Debris (ref), Outer1 (copy), Outer0 (copy), TweenService (ref), u11 (copy)
        local v14 = script.AikuRedirectRed:Clone();
        v14.Parent = game.Lighting;
        v14.Enabled = true;
        Debris:AddItem(v14, 4);
        Outer1.Mesh1.Scale = Vector3.new(1.5, 1.5, 1.5);
        Outer0.Mesh.Scale = Vector3.new(1.5, 1.5, 1.5);
        TweenService:Create(Outer0, TweenInfo.new(1.66, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            CFrame = CFrame.Angles(-3.141592653589793, -0.23029619480065178, 0)
        }):Play();
        TweenService:Create(Outer1, TweenInfo.new(1.66, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            CFrame = CFrame.Angles(0, -0.804282625904027, -3.141592653589793)
        }):Play();
        u11.AtmosphereWorldEnable.colorme.Enabled = true;
        u11.AtmosphereWorldEnable["Night.eff1"].Enabled = true;
        u11.AtmosphereWorldEnable.MainSpark11.lensFlare.Enabled = true;
        u11.AtmosphereWorldEnable.MainSpark11.reachifylineglow.Enabled = true;
        u11.AtmosphereWorldEnable.MainSpark1.lensFlare.Enabled = true;
        u11.AtmosphereWorldEnable.MainSpark1.reachifylineglow.Enabled = true;
    end);
    task.delay(1.45, function() -- Line: 286
        -- upvalues: u9 (ref), VfxManager (ref)
        if u9 then
            VfxManager.Enable(u9.FrontFire, true);
        end;
    end);
    task.delay(3.01, function() -- Line: 292
        -- upvalues: TweenService (ref), Outer0 (copy), Outer1 (copy), u11 (copy), u9 (ref), VfxManager (ref), u3 (copy)
        TweenService:Create(Outer0.Mesh, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Scale = Vector3.new(0, 0, 0)
        }):Play();
        TweenService:Create(Outer1.Mesh1, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Scale = Vector3.new(0, 0, 0)
        }):Play();
        u11.AtmosphereWorldEnable.colorme.Enabled = false;
        u11.AtmosphereWorldEnable["Night.eff1"].Enabled = false;
        u11.AtmosphereWorldEnable.MainSpark11.lensFlare.Enabled = false;
        u11.AtmosphereWorldEnable.MainSpark11.reachifylineglow.Enabled = false;
        u11.AtmosphereWorldEnable.MainSpark1.lensFlare.Enabled = false;
        u11.AtmosphereWorldEnable.MainSpark1.reachifylineglow.Enabled = false;
        u11.black.Decal.Transparency = 1;
        u11.black.Decal1.Transparency = 1;
        u11.black.Texture.Transparency = 1;
        u11.black.Texture1.Transparency = 1;
        u11.black.Size = Vector3.new(0, 0, 0);
        u11.AtmosphereWorldEnable.Dots.Enabled = false;
        u11.AtmosphereWorldEnable.glare1.Enabled = false;

        if u9 then
            VfxManager.Enable(u9, false);
        end;

        VfxManager.Enable(u3.BallRig, false);
    end);
    task.delay(4.01, function() -- Line: 326
        -- upvalues: Folder (copy)
        Folder:Destroy();
        game.Lighting.Blur.Size = 0;
    end);
end;