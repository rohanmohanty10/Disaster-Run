 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
require(script.Parent.Parent.Parent.TekrinnDialogue);
local MeshEmitter = require(script.Parent.Parent.Parent.MeshEmitter);
local raycast = require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.util.SignalValue);
local LocalPlayer = Players.LocalPlayer;

return function(p1: table) -- Line: 24
    -- upvalues: ReplicatedStorage (copy), Debris (copy), MeshEmitter (copy), raycast (copy), mainreplication (copy), Players (copy), Lighting (copy), TweenService (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy)
    local Value = p1.Character.Value;
    local Value2 = p1.Speed.Value;
    local v2 = Value.HumanoidRootPart or Value.PrimaryPart;
    local chigiri = ReplicatedStorage.Resources.chigiri;
    local Part = Instance.new("Part");
    local Weld = Instance.new("Weld");
    Weld.Part0 = v2;
    Weld.Part1 = Part;
    Part.Transparency = 1;
    Part.Massless = true;
    Part.CanCollide = false;
    Part.Anchored = false;
    Weld.C0 = Weld.C0 * CFrame.new(0, 0, 40);
    Part.Parent = v2;
    Weld.Parent = Part;
    Part.Size = Vector3.new(1, 1, 1);
    Debris:AddItem(Part, 5 / Value2);

    if not (shared.allvfxcheck and shared.allvfxcheck()) then
        MeshEmitter.StartMeshEmitter(Part, ReplicatedStorage.Resources.chigiri["Blitz MeshEmitter"]);
    end;

    task.wait(0.36 / Value2);
    local v3 = 0.6 / Value2;
    local v4 = raycast(v2.Position, v2.CFrame.LookVector * 30, nil, { workspace.map });

    if v4 then
        v2.CFrame = CFrame.new(v4.Position);
    else
        v2.CFrame = v2.CFrame * CFrame.new(0, 0, -30);
    end;

    mainreplication.bodyVelocity(v2, 200 * Value2, v3, nil, nil, nil, TweenInfo.new(v3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 2 / Value2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(30, 50);
        local v5 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v5.Parent = Lighting;
        v5.TintColor = Color3.fromRGB(255, 111, 142);
        v5.Brightness = 0.4;
        v5.Contrast = 1;
        v5.Saturation = -0.4;
        TweenService:Create(v5, TweenInfo.new(1.5 / Value2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v5, TweenInfo.new(3 / Value2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2 / Value2, v5.Destroy, v5);
    end;

    local v6 = chigiri.chigiriflashstepemitthingaaa:Clone();
    v6.CFrame = v2.CFrame;
    v6.Parent = workspace;
    Debris:AddItem(v6, 5 / Value2);
    Util.EmitAll(v6);
    local v7 = chigiri.FloorGrasaaas:Clone();
    v7.CFrame = v2.CFrame * CFrame.new(0, 2, 3);
    v7.Parent = workspace;
    Debris:AddItem(v7, 5 / Value2);
    Util.EmitAll(v7);
    local v8 = chigiri.rootparticle:Clone();
    v8.CFrame = v2.CFrame;
    v8.Parent = workspace;
    Debris:AddItem(v8, 5 / Value2);
    Util.EmitAll(v8);
    local v9 = chigiri.FrontDashGlowFaaX:Clone();
    v9.CFrame = v2.CFrame;
    v9.Parent = workspace;
    Debris:AddItem(v9, 5 / Value2);
    Util.EmitAll(v9);

    if Value:GetAttribute("ReoCopy") or Value:GetAttribute("CustomColor") and (LocalPlayer and (Value == LocalPlayer.Character or Value ~= LocalPlayer.Character and (LocalPlayer:FindFirstChild("setting") and (LocalPlayer:FindFirstChild("setting"):FindFirstChild("CustomVFXEnabled") and LocalPlayer:FindFirstChild("setting"):FindFirstChild("CustomVFXEnabled").Value == true)))) then
        vfxUtil.LeanTowardsColor({
            v6,
            v7,
            v2,
            v9
        }, Value:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), Value:GetAttribute("CustomAlpha") or 0.985);
    end;
end;