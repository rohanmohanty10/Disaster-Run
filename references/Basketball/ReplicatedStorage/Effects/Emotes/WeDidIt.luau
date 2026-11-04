 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 19
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), VfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Char:FindFirstChild("BALL", true);
    local u3 = p2.passedTime or 0;
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
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 38
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
    task.delay(4.667 - u3, function() -- Line: 57
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
    task.delay(4.667, function() -- Line: 72
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Wedidit",
        Parent = workspace
    });
    local u11 = script.HeadVFX:Clone();
    u11.CFrame = Head.CFrame;
    u11.Parent = Folder;
    VfxManager.Enable(u11, false);
    Essentials:Weld(u11, Head);
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u12.Parent = Folder;
    u12.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u12.PrimaryPart, CamRig.camera);
    local u13 = script.Cutscene_VFX:Clone();
    u13:PivotTo(HumanoidRootPart.CFrame);
    u13.Parent = Folder;

    for _, descendant in u12.camatmo.CAM2Shading:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(0.233 - u3, function() -- Line: 105
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u13.footstomp);
    end);
    task.delay(0.733 - u3, function() -- Line: 112
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.camtra, true);
        task.wait(0.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.camtra, false);
    end);
    task.delay(1.267 - u3, function() -- Line: 126
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u11);
    end);
    task.delay(2.783 - u3, function() -- Line: 133
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.camtra, true);
        task.wait(0.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.camtra, false);
    end);
    task.delay(2.817 - u3, function() -- Line: 147
        -- upvalues: Folder (copy), u13 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u13.mainpart:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.933 - u3, function() -- Line: 158
        -- upvalues: Folder (copy), u13 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u13.mainpart:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.983 - u3, function() -- Line: 170
        -- upvalues: Folder (copy), u12 (copy), VfxManager (ref), u13 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u12.camatmo.glaresandstuff:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u12.camatmo.gold:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u12.camend:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u13.windlines, true);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.verticallines, true);
    end);
    task.delay(2.983 - u3, function() -- Line: 218
        -- upvalues: Folder (copy), u13 (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u13.blmack.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.392478585243225, 2.150938034057617, 1.2358875274658203) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    end);
    task.delay(3 - u3, function() -- Line: 226
        -- upvalues: Folder (copy), u12 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u12.camatmo.CAM2Shading:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);

    local function v14() -- Line: 238
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref)
        for _, v in u10 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or (descendant:IsA("Texture") or descendant:IsA("Decal"))) then
                    descendant.Transparency = 1;
                elseif descendant:IsA("SpotLight") or (descendant:IsA("PointLight") or (descendant:IsA("SurfaceLight") or (descendant:IsA("Beam") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail"))))) then
                    descendant.Enabled = false;
                end;
            end;
        end;

        u10 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v14));
    table.insert(u10, Folder.Destroying:Connect(v14));
end;