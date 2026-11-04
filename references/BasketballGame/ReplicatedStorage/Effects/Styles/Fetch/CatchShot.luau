 
 

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

    local other = p2.other;
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
    task.delay(5.367 - u3, function() -- Line: 57
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
    task.delay(5.367, function() -- Line: 72
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "Catch shoot",
        Parent = HumanoidRootPart
    });
    local u11 = script.Camera_VFX:Clone();
    u11:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u11.Parent = Folder;
    u11.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u11.PrimaryPart, CamRig.camera);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.Aura:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v12 = child:Clone();
            v12.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v12.Parent = Model;
            Essentials:Weld(v12, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v12, false);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    for _, child in script.Player2:GetChildren() do
        if other:FindFirstChild(child.Name) then
            local v13 = child:Clone();
            v13.CFrame = other:FindFirstChild(child.Name).CFrame;
            v13.Parent = Model2;
            Essentials:Weld(v13, other:FindFirstChild(child.Name));
            VfxManager.Enable(v13, false);
        end;
    end;

    local v14 = script.BALL:Clone();
    v14.CFrame = BALL.CFrame;
    v14.Parent = Folder;
    Essentials:Weld(v14, BALL);
    VfxManager.Enable(v14, false);
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(27, 53, 140);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Char;
    local Highlight2 = Instance.new("Highlight");
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight2.FillTransparency = 1;
    Highlight2.OutlineColor = Color3.new(0, 0, 0);
    Highlight2.OutlineTransparency = 1;
    Highlight2.Parent = BALL;
    local u15 = script.Cutscene_VFX:Clone();
    u15:PivotTo(HumanoidRootPart.CFrame);
    u15.Parent = Folder;
    VfxManager.Emit(Model);
    VfxManager.Emit(Model2);
    VfxManager.Emit(v14);
    VfxManager.Emit(u15.Sky);
    task.delay(0.65 - u3, function() -- Line: 150
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u11.Speedlines);
    end);
    task.delay(0.783 - u3, function() -- Line: 156
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.Catch);
    end);
    task.delay(2.667 - u3, function() -- Line: 162
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.Floor);
    end);

    local function v16() -- Line: 168
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref), Highlight (copy), Highlight2 (copy)
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

        if Highlight then
            Highlight:Destroy();
        end;

        if Highlight2 then
            Highlight2:Destroy();
        end;

        u10 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v16));
    table.insert(u10, Folder.Destroying:Connect(v16));
end;