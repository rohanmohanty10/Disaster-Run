 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: SfxManager (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), LocalPlayer (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other1 = p2.Other1;
    local Other2 = p2.Other2;
    local Other3 = p2.Other3;
    local Other4 = p2.Other4;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    workspace:WaitForChild("CamRig", 5);
    SfxManager:playSound({
        Sound = script.Sound,
        Parent = workspace
    }).TimePosition = u3;
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 44
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
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
    task.delay(9 - u3, function() -- Line: 66
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9 - u3, function() -- Line: 75
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local v10 = script.Cutscene_VFX:Clone();
    v10.Name = v4;
    v10.Parent = Folder;
    v10:PivotTo(HumanoidRootPart.CFrame);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u11 = script.Vignette:Clone();
    u11.Parent = PlayerGui;
    u11.Enabled = true;
    local _ = u11.Vignette1;
    u11.Vignette.ImageTransparency = 0;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, v in {
        Character,
        Other1,
        Other2,
        Other3,
        Other4
    } do
        local Highlight = Instance.new("Highlight", Folder);
        Highlight.Adornee = v;
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = Color3.fromRGB(0, 0, 0);
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight.OutlineTransparency = 0;
        Highlight.FillTransparency = 1;
        local v12 = script.Torso:Clone();
        v12.Parent = Model;
        v12.CFrame = v.Torso.CFrame;
        Essentials:Weld(v12, v.Torso);
    end;

    task.delay(1.4666666666666666 - u3, function() -- Line: 113
        -- upvalues: Folder (copy), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(Model);
    end);
    task.delay(5.666666666666667 - u3, function() -- Line: 119
        -- upvalues: Folder (copy), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(Model);
    end);
    task.delay(7.25 - u3, function() -- Line: 125
        -- upvalues: Folder (copy), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(Model);
    end);
    local u13 = {};

    local function v14() -- Line: 132
        -- upvalues: u13 (ref), Folder (copy), u11 (copy)
        for _, v in pairs(u13) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u11 then
            u11:Destroy();
        end;

        u13 = nil;
    end;

    table.insert(u13, Folder.AttributeChanged:Connect(v14));
    table.insert(u13, Folder.Destroying:Connect(v14));
end;