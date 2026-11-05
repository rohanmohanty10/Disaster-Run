  

 

local _ = game:GetService("Players").LocalPlayer;
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
    v7.Parent = workspace.Effects;

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
            v16.CFrame = child.CFrame;
        end;
    end;

    return v7;
end;

return function(p17) -- Line: 81
    -- upvalues: AssetHandler (copy), u2 (copy), TweenService (copy)
    local v18 = p17.Transparency or 0.35;
    local v19 = p17.Color or Color3.new();
    local v20 = p17.Material or Enum.Material.Neon;
    local u21 = AssetHandler.CloneAsset("Models/ShadowClone_Lite", {
        AbilityName = "Uber Oni"
    });
    u21.Parent = workspace.Effects;
    local v22 = TweenInfo.new(p17.Time or 1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, p17.Delay or 0);
    local u23 = {};

    for _, child in p17.Character:GetChildren() do
        if child:IsA("CharacterMesh") then
            u21[u2[child.BodyPart]].Mesh.MeshId = "rbxassetid://" .. child.MeshId;
        elseif child:IsA("Accessory") then
            local v24 = child:FindFirstChild("Handle") or child:FindFirstChildWhichIsA("BasePart");
            local v25;

            if v24 then
                v25 = v24:FindFirstChild("AccessoryWeld") or v24:FindFirstChildOfClass("Weld");
            else
                v25 = v24;
            end;

            if v24 then
                local v26 = v24:Clone();
                local v27 = v26:FindFirstChild("AccessoryWeld") or v26:FindFirstChildOfClass("Weld");
                local v28 = v26:FindFirstChildWhichIsA("LuaContainer");

                if v28 then
                    v28:Destroy();
                end;

                local v29 = v26 and not v26:IsA("MeshPart") and (v26:FindFirstChild("Mesh") or v26:FindFirstChildOfClass("SpecialMesh"));
                v26.Parent = u21;
                v26.Transparency = v18;
                v26.Color = v19;
                v26.Material = v20;
                v26.Massless = true;

                if v29 then
                    v29.TextureId = "";
                end;

                if v25 and v27 then
                    v27.Part1 = u21:FindFirstChild(v25.Part1.Name);
                else
                    local v30 = v26:FindFirstChildOfClass("Attachment");
                    local v31 = u21:FindFirstChild(v30.Name, true);
                    v26.CFrame = v31.WorldCFrame * v30.CFrame:Inverse();
                    local WeldConstraint = Instance.new("WeldConstraint");
                    WeldConstraint.Parent = v26;
                    WeldConstraint.Part0 = v26;
                    WeldConstraint.Part1 = v31.Parent;
                end;

                table.insert(u23, TweenService:Create(v26, v22, {
                    Transparency = 1
                }));
            end;
        elseif child:IsA("BasePart") and u21:FindFirstChild(child.Name) then
            local v32 = u21[child.Name];
            v32.Transparency = v18;
            v32.Color = v19;
            v32.Material = v20;
            v32.CFrame = child.CFrame;
            table.insert(u23, TweenService:Create(v32, v22, {
                Transparency = 1
            }));
        end;
    end;

    task.spawn(function() -- Line: 144
        -- upvalues: u23 (copy), u21 (copy)
        for i, v in u23 do
            v:Play();

            if i == #u23 then
                v.Completed:Wait();
            end;
        end;

        u21:Destroy();
    end);
end;