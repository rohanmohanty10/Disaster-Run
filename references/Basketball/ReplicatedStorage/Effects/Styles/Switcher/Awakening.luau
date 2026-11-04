 
 

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

    Char:FindFirstChild("Head");
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
    task.delay(6.667 - u3, function() -- Line: 57
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
    task.delay(6.667, function() -- Line: 72
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u11 = SfxManager:playSound({
        Sound = "BBZ Switchers Imagination",
        Parent = workspace
    });
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u12.Parent = Folder;
    u12.PrimaryPart.CFrame = CamRig.CamPart.CFrame;
    Essentials:Weld(u12.PrimaryPart, CamRig.CamPart);
    local u13 = script.Cutscene_VFX:Clone();
    u13:PivotTo(HumanoidRootPart.CFrame);
    u13.Parent = Folder;
    VfxManager.Enable(u12.lines, true);
    task.delay(0.417 - u3, function() -- Line: 95
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u13.cling);
    end);
    task.delay(0.483 - u3, function() -- Line: 102
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u13.starsfirst, true);
        task.delay(3, function() -- Line: 108
            -- upvalues: Folder (ref), VfxManager (ref), u13 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Enable(u13.starsfirst, false);
        end);
    end);
    task.delay(1.183 - u3, function() -- Line: 116
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u13.hitground);
        u13.Floorgrass.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.19460153579711914, -2.972832679748535, -0.18558216094970703) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    end);
    task.delay(2 - u3, function() -- Line: 125
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.lines, false);
    end);
    task.delay(2.417 - u3, function() -- Line: 132
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), u13 (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.camtra, true);
        u13.Floorgrass.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.19460153579711914, -24.15367889404297, -0.18558216094970703) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
        task.wait(0.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.camtra, false);
    end);
    task.delay(2.767 - u3, function() -- Line: 147
        -- upvalues: Folder (copy), u13 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u13.pinkbackground:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        task.wait(2.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u13.pinkbackground:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.45 - u3, function() -- Line: 169
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u13.eyeemit);
    end);
    task.delay(5.067 - u3, function() -- Line: 176
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.camtra2, true);
        task.wait(0.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.camtra2, false);
    end);
    task.delay(5.183 - u3, function() -- Line: 191
        -- upvalues: Folder (copy), u13 (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u13.yellow.Transparency = 0;

        for _, child in u13.yellow:GetChildren() do
            if child:IsA("Part") or child:IsA("BasePart") then
                child.Transparency = 0;
            end;
        end;

        u13.yellow.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.7500098943710327, 2.0984420776367188, -4.115968704223633) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    end);
    task.delay(5.35 - u3, function() -- Line: 205
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u13.starsandhearts, true);
        task.wait(7);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u13.starsandhearts, false);
    end);
    task.delay(5.383 - u3, function() -- Line: 219
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.lines, true);
        task.wait(5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u12.lines, false);
    end);
    task.delay(5.417 - u3, function() -- Line: 233
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u13.heartbackground);
    end);

    local function v14() -- Line: 241
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref), u11 (copy)
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
            VfxManager.DestroyEffect(u11, 2);
        end;

        u10 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v14));
    table.insert(u10, Folder.Destroying:Connect(v14));
end;