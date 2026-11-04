 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 18
    -- upvalues: Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), VfxManager (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local v3 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u5 = workspace:FindFirstChild(script.Parent.Name .. "LockerRoom");
    local u6 = Character:FindFirstChild(script.Parent.Name .. "Trophy");
    Character:FindFirstChild("BALL", true);
    task.delay(7 - PassedTime, function() -- Line: 32
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Crowd", "Air! Air! Air!", 1 }, { "Commentator", "Ladies and gentlemen!", 1.5 }, { "Commentator", "The one... the only...", 2.5 }, { "Commentator", "<animation style=\"glitch\" timeBetweenStep=\"0.05\"><font color=\"#ff0037\">AAAIIIIRRRRR</font>!</animation>", 3 } });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 60
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * PassedTime;
        end;

        u7 = u7 + p9 * 60;
        local v10 = script_Fov[math.ceil(u7)];

        if v10 ~= nil then
            if math.ceil(u7) >= #script_Fov then
                u8:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v10, p9 * 6);
        end;
    end);
    local u11 = nil;
    u11 = RunService.RenderStepped:Connect(function() -- Line: 83
        -- upvalues: u6 (copy), u11 (ref)
        if u6 and u6:FindFirstChild("Cylinder0011") then
            u6.Trophy.CFrame = u6.Cylinder0011.Bone.Connector.WorldCFrame;

            return;
        end;

        u11:Disconnect();
    end);
    task.delay(19.217 - PassedTime, function() -- Line: 91
        -- upvalues: u8 (ref), u11 (ref)
        u8:Disconnect();
        u11:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(19.217 - PassedTime, function() -- Line: 105
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Air Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u12 = script.Cutscene_VFX:Clone();
    u12:PivotTo(HumanoidRootPart.CFrame);
    u12.Parent = Folder;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v13 = Character:FindFirstChild(child.Name);

        if v13 then
            local v14 = child:Clone();
            v14.CFrame = v13.CFrame;
            v14.Parent = Model;
            Essentials:Weld(v14, v13);
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u15 = script.Vignette:Clone();
    u15.Parent = PlayerGui;
    u15.Enabled = true;
    local _ = u15.Vignette1;
    u15.Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", u5);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 0.9;
    Highlight.FillTransparency = 1;
    local u16 = nil;
    u16 = RunService.RenderStepped:Connect(function() -- Line: 148
        -- upvalues: u6 (copy), u16 (ref), u12 (copy)
        if u6 and u6.Parent then
            u12.Aura.CFrame = u6.Cylinder0011.Bone.Attachment.WorldCFrame;

            return;
        end;

        u16:Disconnect();
    end);
    task.delay(19.217 - PassedTime, function() -- Line: 157
        -- upvalues: u16 (ref)
        u16:Disconnect();
    end);
    task.spawn(function() -- Line: 161
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.CameraPart.nr1, true);
        end;
    end);
    task.delay(0.15 - PassedTime, function() -- Line: 169
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(Model.Head.EmitBreath);
    end);
    task.delay(1.7166666666666666 - PassedTime, function() -- Line: 175
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(Model.Head.EmitBreath);
    end);
    task.delay(2.95 - PassedTime, function() -- Line: 181
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(Model.Head.Part);
    end);
    task.delay(10.533333333333333 - PassedTime, function() -- Line: 187
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.CameraPart.nr1, false);
            VfxManager.Enable(CamRig.CameraPart.nr2, true);
        end;
    end);
    task.delay(10.55 - PassedTime, function() -- Line: 196
        -- upvalues: Folder (copy), u6 (copy), u5 (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            u6:Destroy();
        end;

        if u5 then
            u5:Destroy();
        end;

        if u12 then
            u12:Destroy();
        end;
    end);
    local u17 = {};

    local function v18() -- Line: 213
        -- upvalues: u17 (ref), Folder (copy), u6 (copy), u5 (copy), u15 (copy)
        for _, v in pairs(u17) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u6 then
            u6:Destroy();
        end;

        if u5 then
            u5:Destroy();
        end;

        if u15 then
            u15:Destroy();
        end;

        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v18));
    table.insert(u17, Folder.Destroying:Connect(v18));
end;