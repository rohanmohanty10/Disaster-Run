 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 19
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), VfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    local OtherChar = p2.OtherChar;
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v4 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 39
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * u3;
        end;

        u6 = u6 + p8 * 60;
        local v9 = script_Fov[math.ceil(u6)];

        if v9 ~= nil then
            if math.ceil(u6) >= #script_Fov then
                u7:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v9, p8 * 6);
        end;
    end);
    task.delay(8.333 - u3, function() -- Line: 58
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);
    local u10 = {};

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(8.333, function() -- Line: 73
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local game_Lighting = game.Lighting;
    local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local Color = Atmosphere.Color;
    local Offset = Atmosphere.Offset;
    local Haze = Atmosphere.Haze;
    local Decay = Atmosphere.Decay;
    local Glare = Atmosphere.Glare;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local Intensity = Bloom.Intensity;
    local Size = Bloom.Size;
    local Threshold = Bloom.Threshold;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u11 = script.Vignette:Clone();
    u11.Parent = PlayerGui;
    u11.Enabled = true;
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u12.Parent = Folder;
    u12.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u12.PrimaryPart, CamRig.camera);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.Sniper:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v13 = child:Clone();
            v13.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v13.Parent = Model;
            Essentials:Weld(v13, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v13, false);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    for _, child in script.Random:GetChildren() do
        if OtherChar:FindFirstChild(child.Name) then
            local v14 = child:Clone();
            v14.CFrame = OtherChar:FindFirstChild(child.Name).CFrame;
            v14.Parent = Model2;
            Essentials:Weld(v14, OtherChar:FindFirstChild(child.Name));
            VfxManager.Enable(v14, false);
        end;
    end;

    local u15 = script.FIRSTBALL:Clone();
    u15.CFrame = BALL.CFrame;
    u15.Parent = Folder;
    Essentials:Weld(u15, BALL);
    VfxManager.Enable(u15, true);
    local u16 = script.Cutscene_VFX:Clone();
    u16:PivotTo(HumanoidRootPart.CFrame);
    u16.Parent = Folder;
    Bloom.Intensity = 1;
    Bloom.Size = 24;
    Bloom.Threshold = 2;
    DepthOfField.FarIntensity = 1;
    DepthOfField.FocusDistance = 15.2;
    DepthOfField.NearIntensity = 0;
    DepthOfField.InFocusRadius = 0;
    Atmosphere.Density = 0.3;
    Atmosphere.Offset = 0.5;
    Atmosphere.Color = Color3.fromRGB(0, 0, 0);
    Atmosphere.Decay = Color3.fromRGB(85, 99, 98);
    Atmosphere.Glare = 0;
    Atmosphere.Haze = 0;
    VfxManager.Emit(Model);
    VfxManager.Emit(Model2);
    VfxManager.Emit(u16.Throw);
    task.delay(1.767 - u3, function() -- Line: 177
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Jump);
    end);
    task.delay(2.567 - u3, function() -- Line: 183
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u12 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Throw);
        VfxManager.Emit(u12.Lines);
    end);
    task.delay(2.983 - u3, function() -- Line: 190
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u15 (copy), BALL (copy), Essentials (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Catch);
        u15:Destroy();
        local v17 = script.BALL:Clone();
        v17.CFrame = BALL.CFrame;
        v17.Parent = Folder;
        Essentials:Weld(v17, BALL);
        VfxManager.Emit(v17);
    end);
    task.delay(3.667 - u3, function() -- Line: 204
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Shot);
    end);
    task.delay(4.443 - u3, function() -- Line: 210
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Shot);
    end);

    local function v18() -- Line: 217
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref), u11 (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Threshold (copy), Size (copy), Intensity (copy), Atmosphere (copy), Density (copy), Glare (copy), Decay (copy), Offset (copy), Haze (copy), Color (copy)
        for _, v in u10 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or descendant:IsA("Texture")) then
                    descendant.Transparency = 1;
                end;
            end;
        end;

        if u11 then
            u11:Destroy();
        end;

        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        Bloom.Threshold = Threshold;
        Bloom.Size = Size;
        Bloom.Intensity = Intensity;
        Atmosphere.Density = Density;
        Atmosphere.Glare = Glare;
        Atmosphere.Decay = Decay;
        Atmosphere.Offset = Offset;
        Atmosphere.Haze = Haze;
        Atmosphere.Color = Color;
        u10 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v18));
    table.insert(u10, Folder.Destroying:Connect(v18));
end;