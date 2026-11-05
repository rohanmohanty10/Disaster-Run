  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 12
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.KnitPath.Trove);
end);
local u2 = {
    [Enum.BodyPart.LeftArm] = "Left Arm",
    [Enum.BodyPart.RightArm] = "Right Arm",
    [Enum.BodyPart.LeftLeg] = "Left Leg",
    [Enum.BodyPart.RightLeg] = "Right Leg",
    [Enum.BodyPart.Torso] = "Torso",
    [Enum.BodyPart.Head] = "Head"
};

local function CreateClone(p3) -- Line: 25
    -- upvalues: AssetHandler (copy), u2 (copy)
    local v4 = p3.Transparency or 0.35;
    local v5 = p3.Color or Color3.new();
    local v6 = p3.Material or Enum.Material.Neon;
    local v7 = AssetHandler.CloneAsset("Models/ShadowClone", {
        AbilityName = "Uber Oni"
    });

    for _, child in p3.Character:GetChildren() do
        if child:IsA("CharacterMesh") then
            v7[u2[child.BodyPart]].Mesh.MeshId = "rbxassetid://" .. child.MeshId;
        elseif child:IsA("Accessory") then
            local v8 = child:FindFirstChild("Handle") or child:FindFirstChildWhichIsA("BasePart");
            local v9;

            if v8 then
                v9 = v8:FindFirstChild("AccessoryWeld") or v8:FindFirstChildOfClass("Weld");
            else
                v9 = v8;
            end;

            if v8 then
                local v10 = v8:Clone();
                local v11 = v10:FindFirstChild("AccessoryWeld") or v10:FindFirstChildOfClass("Weld");
                local v12 = v10:FindFirstChildWhichIsA("LuaContainer");

                if v12 then
                    v12:Destroy();
                end;

                local v13 = v10 and not v10:IsA("MeshPart") and (v10:FindFirstChild("Mesh") or v10:FindFirstChildOfClass("SpecialMesh"));
                v10.Parent = v7;
                v10.Transparency = v4;
                v10.Color = v5;
                v10.Material = v6;

                if v13 then
                    v13.TextureId = "";
                end;

                if v9 and v11 then
                    v11.Part1 = v7:FindFirstChild(v9.Part1.Name);
                else
                    local v14 = v10:FindFirstChildOfClass("Attachment");
                    local v15 = v7:FindFirstChild(v14.Name, true);
                    v10.CFrame = v15.WorldCFrame * v14.CFrame:Inverse();
                    local WeldConstraint = Instance.new("WeldConstraint");
                    WeldConstraint.Parent = v10;
                    WeldConstraint.Part0 = v10;
                    WeldConstraint.Part1 = v15.Parent;
                end;
            end;
        elseif child:IsA("BasePart") and (child.Name ~= v7.PrimaryPart.Name and v7:FindFirstChild(child.Name)) then
            local v16 = v7[child.Name];
            v16.Transparency = v4;
            v16.Color = v5;
            v16.Material = v6;
        end;
    end;

    return v7;
end;

return function(u17) -- Line: 79
    -- upvalues: CreateClone (copy), u1 (ref), TweenService (copy), LocalPlayer (copy)
    local v18 = CreateClone(u17);
    local u19 = {};
    local u20 = u1.new();
    u20:Add(v18);
    local u21 = false;
    local v22 = u17.Amount or 5;
    local u23 = u17.Radius or 10;
    local v24 = 360 / v22;
    local v25 = u17.Origin or u17.Character.HumanoidRootPart.CFrame;
    local v26;

    if u17.Animation then
        v26 = Instance.new("Animation");
        v26.AnimationId = "rbxassetid://" .. u17.Animation;
        u20:Add(v26);
    else
        v26 = nil;
    end;

    local u27;

    if u17.Host then
        u27 = u17.Host;
    else
        u27 = Instance.new("Part");
        u27.Size = Vector3.new(1, 1, 1);
        u27.Anchored = true;
        u27.CFrame = v25;
        u27.Transparency = 1;
        u27.CanCollide = false;
        u27.CanQuery = false;
        u27.CanTouch = false;
        u27.Parent = workspace.Effects;
        u20:Add(u27);
    end;

    for i = 1, v22 do
        local v28 = v18:Clone();
        local v29 = math.rad(v24 * i);
        v28.Parent = workspace.Effects;
        v28.HumanoidRootPart.CFrame = v25 * CFrame.Angles(0, v29, 0) * CFrame.new(0.1, 0, 0);
        table.insert(u19, v28);
        u20:Add(v28);
        local _, v30, _ = CFrame.lookAt(v28.HumanoidRootPart.Position, v25.Position):ToOrientation();
        v28:SetAttribute("StartAngle", v29);
        v28:SetAttribute("Angle", v30);

        if v26 then
            local v31 = v28.AnimationController.Animator:LoadAnimation(v26);
            v31:Play(0, 1, 0.1);
            v31:AdjustSpeed(0);
            v31.TimePosition = u17.AnimationPosition or 0;
        end;
    end;

    local u33 = task.spawn(function() -- Line: 136
        -- upvalues: u19 (copy), u27 (ref), u23 (copy), u17 (copy)
        while true do
            for _, v in u19 do
                v.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame:Lerp(u27.CFrame * CFrame.fromOrientation(0, v:GetAttribute("Angle"), 0) * CFrame.new(0, 0, u23 / 2), 0.1);
            end;

            if u27 ~= u17.Host then
                local v32 = u27;
                v32.CFrame = v32.CFrame * CFrame.Angles(0, math.rad(u17.Spin or 1), 0);
            end;

            task.wait();
        end;
    end);

    local function Clear() -- Line: 148
        -- upvalues: u21 (ref), u17 (copy), u33 (copy), u20 (copy), u19 (copy), TweenService (ref), u27 (ref)
        if u21 then
            return;
        end;

        u21 = true;

        if u17.Host then
            task.cancel(u33);
            u20:Destroy();
            table.clear(u19);

            return;
        end;

        local u34 = TweenService:Create(u27, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            CFrame = CFrame.new(u27.Position + Vector3.new(0, 100, 0))
        });
        u34:Play();
        u34.Completed:Once(function() -- Line: 160
            -- upvalues: u33 (ref), u20 (ref), u19 (ref), u34 (copy)
            task.cancel(u33);
            u20:Destroy();
            table.clear(u19);
            u34:Destroy();
        end);
    end;

    u20:Add(u17.Character.AncestryChanged:Connect(function(p35, p36) -- Line: 169
        -- upvalues: Clear (copy)
        if not (p36 and p36:IsDescendantOf(game)) then
            Clear();
        end;
    end));

    if u17.Hook then
        u20:Add(u17.Character:GetAttributeChangedSignal(u17.Hook):Once(Clear));
    end;

    u20:Add(LocalPlayer.CharacterAdded:Once(Clear));
end;