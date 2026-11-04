 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), RunService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    Character:FindFirstChild("RightArm");
    Character:FindFirstChild("Torso");
    local v6 = Character:FindFirstChild(script.Name .. "ChatBubble");
    local u7 = Character:FindFirstChild(script.Name .. "Whistle");
    local u8 = workspace:FindFirstChild(script.Name .. "Ball");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    SfxManager:playSound({
        Sound = script.Sound,
        Parent = workspace
    }).TimePosition = v3;
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(5 - v3, function() -- Line: 45
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u9 = script.Cutscene_VFX:Clone();
    u9.Name = v4;
    u9.Parent = Folder;
    u9:PivotTo(HumanoidRootPart.CFrame);
    local u10 = {};

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v11 = Character:FindFirstChild(child.Name);

        if v11 then
            for _, child2 in pairs(child:GetChildren()) do
                if child2:IsA("ParticleEmitter") then
                    local v12 = child2:Clone();
                    v12.Parent = v11;
                    table.insert(u10, v12);
                end;
            end;
        end;
    end;

    task.delay(0.25 - v3, function() -- Line: 71
        -- upvalues: Folder (copy), u8 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u8 and u8:FindFirstChild("Anims") then
            VfxManager.Emit(u8.Anims.BALL.Catch);
        end;
    end);
    task.delay(1.4333333333333333 - v3, function() -- Line: 79
        -- upvalues: Folder (copy), u7 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u7 then
            VfxManager.Enable(u7, true);
        end;
    end);
    task.delay(1.7666666666666666 - v3, function() -- Line: 87
        -- upvalues: Folder (copy), u7 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u7 then
            VfxManager.Enable(u7, false);
        end;
    end);
    task.delay(2.4166666666666665 - v3, function() -- Line: 95
        -- upvalues: Folder (copy), u10 (copy), CamRig (copy), VfxManager (ref), u9 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        for _, v in pairs(u10) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;

        if CamRig then
            VfxManager.Enable(CamRig, true);
        end;

        VfxManager.Enable(u9, true);
    end);
    task.delay(4 - v3, function() -- Line: 111
        -- upvalues: Folder (copy), u10 (copy), CamRig (copy), VfxManager (ref), u9 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        for _, v in pairs(u10) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;

        if CamRig then
            VfxManager.Enable(CamRig, false);
        end;

        VfxManager.Enable(u9, false);
    end);
    local u13 = {};

    local function v14() -- Line: 128
        -- upvalues: u13 (ref), u10 (copy), VfxManager (ref), Folder (copy)
        for _, v in pairs(u13) do
            v:Disconnect();
        end;

        for _, v in pairs(u10) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
                VfxManager.DestroyEffect(v, 2);
            end;
        end;

        if Folder then
            Folder:Destroy();
        end;

        u13 = nil;
    end;

    if v6 and v6:FindFirstChild("ChatBubble") then
        local u15 = {};

        for _, child in pairs(v6:GetChildren()) do
            if child:IsA("MeshPart") then
                table.insert(u15, child);
            end;
        end;

        local v16 = RunService.RenderStepped:Connect(function() -- Line: 156
            -- upvalues: u15 (copy), Head (copy)
            for _, v in pairs(u15) do
                if Head and (v.Position - Head.Position).Magnitude > 0.5 then
                    v.Transparency = 0;
                else
                    v.Transparency = 1;
                end;
            end;
        end);
        table.insert(u13, v16);
    end;

    table.insert(u13, Folder.AttributeChanged:Connect(v14));
    table.insert(u13, Folder.Destroying:Connect(v14));
end;