  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Controllers.SpectatorController);
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.BubbleModule);
local createAfterImage = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;

return function(p1) -- Line: 17
    -- upvalues: SoundManager (copy), VfxManager (copy), createAfterImage (copy), Debris (copy), Players (copy), TweenService (copy), Lighting (copy), CameraController (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if p1.State == "Start" then
        SoundManager.SpawnSound("Godspeed Distortion", 0.6, workspace, 150).TimePosition = 2.5;
        local v2 = script.Dash:Clone();
        v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 5, -30) * CFrame.fromOrientation(0.17453292519943295, 0, 0));
        v2.Parent = workspace.Debris;
        VfxManager.Emit(v2);
        local v3 = 0.007;

        for i = 1, 5 do
            createAfterImage(Char):PivotTo(Char:GetPivot());
            task.wait(v3);
            v3 = v3 + 0.003;
            local _ = i;
        end;

        task.wait(2);
        v2:Destroy();

        return;
    end;

    if p1.State ~= "Teleport" then
        if p1.State ~= "Kick" then
            if p1.State == "Daze" and p1.Enemy == Players.LocalPlayer.Character then
                TweenService:Create(Lighting.Blur, TweenInfo.new(0.1), {
                    Size = 56
                }):Play();
                CameraController:Shake("Hit");
                task.wait(0.1);
                TweenService:Create(Lighting.Blur, TweenInfo.new(0.5), {
                    Size = 0
                }):Play();
            end;

            return;
        end;

        local v4 = script.Kick:Clone();
        Debris:AddItem(v4, 5);
        v4:PivotTo(HumanoidRootPart.CFrame);
        v4.Parent = workspace.Debris;
        VfxManager.Emit(v4);
        task.wait(2);
        v4:Destroy();

        return;
    end;

    local u5 = {};

    local function addtoTransparencyTable(p6) -- Line: 54
        -- upvalues: u5 (copy)
        if p6.Transparency ~= 1 then
            u5[#u5 + 1] = { p6, p6.Transparency };
            p6.Transparency = 1;
        end;
    end;

    for _, child in Char:GetChildren() do
        if child:IsA("BasePart") then
            if child.Transparency ~= 1 then
                u5[#u5 + 1] = { child, child.Transparency };
                child.Transparency = 1;
            end;

            for _, child2 in ipairs(child:GetChildren()) do
                if (child2:IsA("Decal") or child2:IsA("Texture")) and child2.Transparency ~= 1 then
                    u5[#u5 + 1] = { child2, child2.Transparency };
                    child2.Transparency = 1;
                end;
            end;
        elseif child:IsA("Accessory") then
            local Handle = child.Handle;

            if Handle.Transparency ~= 1 then
                u5[#u5 + 1] = { Handle, Handle.Transparency };
                Handle.Transparency = 1;
            end;
        end;
    end;

    task.delay(0.25, function() -- Line: 74
        -- upvalues: u5 (copy)
        for _, v in u5 do
            v[1].Transparency = v[2];
        end;
    end);
    local v7 = script["Instant Transmission"]:Clone();
    v7.Parent = workspace.Debris;
    VfxManager.Emit(v7);
    local Weld = Instance.new("Weld");
    Weld.Parent = v7.PrimaryPart;
    Weld.Part0 = v7.PrimaryPart;
    Weld.Part1 = Char.HumanoidRootPart;
    Weld.C0 = CFrame.new(0, 2.75, 0);
    local v8 = 0.007;

    for i = 1, 5 do
        createAfterImage(Char):PivotTo(Char:GetPivot());
        task.wait(v8);
        v8 = v8 + 0.003;
        local _ = i;
    end;

    task.wait(2);
    v7:Destroy();
end;