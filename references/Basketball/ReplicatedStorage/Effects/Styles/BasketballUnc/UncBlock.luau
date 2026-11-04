 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 21
    -- upvalues: Players (copy), Effects (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local v3 = Character.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local v5 = Players:FindFirstChild(Character.Name);
    Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    Effects:SubtitleV2({
        { v5, "Not in my house, son!", 1 }
    });

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(2.5 - PassedTime, function() -- Line: 52
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Basketball Unc Unc Block",
        Parent = workspace
    }).TimePosition = PassedTime;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u6 = script.Vignette:Clone();
    u6.Parent = PlayerGui;
    u6.Enabled = true;
    local _ = u6.Vignette1;
    u6.Vignette.ImageTransparency = 0;

    if CamRig and CamRig:FindFirstChild("Cane") then
        local Highlight = Instance.new("Highlight", CamRig.Cane.Cane);
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = Color3.fromRGB(0, 0, 0);
        Highlight.OutlineColor = Color3.new(255, 255, 255);
        Highlight.OutlineTransparency = 0;
        Highlight.FillTransparency = 1;
    end;

    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u7 = ColorCorrection:Clone();
    u7.Name = "CC";
    u7.Parent = Lighting;
    u7.Enabled = true;
    task.delay(2.5, function() -- Line: 87
        -- upvalues: u7 (copy), Lighting (ref), ColorCorrection (copy)
        u7:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(0.21666666666666667 - PassedTime, function() -- Line: 94
        -- upvalues: Folder (copy), u7 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u7.Saturation = -1;
    end);
    task.delay(1.1333333333333333 - PassedTime, function() -- Line: 100
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref), u7 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v8 = script.Ball:Clone();
        v8.Parent = Folder;
        v8.CFrame = BALL.CFrame;
        VfxManager.Emit(v8);
        VfxManager.DestroyEffect(v8);
        u7.Saturation = ColorCorrection.Saturation;
    end);
    local u9 = {};

    local function v10() -- Line: 113
        -- upvalues: u9 (ref), u6 (copy), u7 (copy), Lighting (ref), ColorCorrection (copy), Folder (copy), VfxManager (ref)
        for _, v in pairs(u9) do
            v:Disconnect();
        end;

        if u6 then
            u6:Destroy();
        end;

        if u7 then
            u7:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if Folder then
            VfxManager.DestroyEffect(Folder, 2);
        end;

        u9 = nil;
    end;

    table.insert(u9, Folder.AttributeChanged:Connect(v10));
    table.insert(u9, Folder.Destroying:Connect(v10));
end;