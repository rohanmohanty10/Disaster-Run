  

 

local u1 = {};
local u2 = {
    [Enum.BodyPart.Head] = "Head",
    [Enum.BodyPart.Torso] = "Torso",
    [Enum.BodyPart.LeftArm] = "Left Arm",
    [Enum.BodyPart.RightArm] = "Right Arm",
    [Enum.BodyPart.LeftLeg] = "Left Leg",
    [Enum.BodyPart.RightLeg] = "Right Leg"
};
local u3 = {
    Head = "rbxasset://avatar/heads/head.mesh",
    Torso = "rbxasset://avatar/meshes/torso.mesh",
    ["Left Arm"] = "rbxasset://avatar/meshes/leftarm.mesh",
    ["Right Arm"] = "rbxasset://avatar/meshes/rightarm.mesh",
    ["Left Leg"] = "rbxasset://avatar/meshes/leftleg.mesh",
    ["Right Leg"] = "rbxasset://avatar/meshes/rightleg.mesh"
};
require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function materialize(p4, u5, p6, p7, u8, p9, p10, p11, p12) -- Line: 22
    -- upvalues: u2 (copy), u1 (copy), u3 (copy), materialize (copy)
    local v13 = u5 == nil;

    if not u5 then
        u5 = {
            Humanoid = nil,
            Legacy = false,
            Root = p4,
            ToCopy = {},
            ToOriginal = {},
            SkinnedMeshParts = {},
            Model = Instance.new("Model"),
            CharacterMeshes = {},
            Instead = {},
            Color = p6
        };
        local v14 = p4:FindFirstChildWhichIsA("Humanoid");

        if v14 then
            u5.Humanoid = v14;
            u5.Legacy = v14.RigType == Enum.HumanoidRigType.R6;

            if u5.Legacy then
                for _, child in p4:GetChildren() do
                    if child:IsA("CharacterMesh") then
                        u5.CharacterMeshes[u2[child.BodyPart]] = child;
                    end;
                end;
            end;
        end;
    end;

    for _, child in p4:GetChildren() do
        if child:IsA("BasePart") then
            local CFrame2 = child.CFrame;
            local v15;

            if child:IsA("MeshPart") then
                v15 = Instance.fromExisting(child);
                v15.TextureID = "";
            else
                local v16 = child:FindFirstChildWhichIsA("SpecialMesh");

                if v16 and v16.MeshType == Enum.MeshType.FileMesh then
                    local v17 = u1[v16];

                    if v17 == nil then
                        v17 = game.AssetService:CreateMeshPartAsync(Content.fromUri(v16.MeshId), {
                            CollisionFidelity = Enum.CollisionFidelity.Box,
                            FluidFidelity = Enum.FluidFidelity.UseCollisionGeometry
                        });
                        v17.Name = child.Name;
                        u1[v16] = v17;
                    end;

                    v15 = Instance.fromExisting(v17);
                    v15.CFrame = CFrame2 * CFrame.new(v16.Offset);
                    v15.Size = v15.MeshSize * v16.Scale;
                elseif v13 and (u5.Legacy and u3[child.Name]) then
                    local v18 = u1[child];

                    if v18 == nil then
                        local v19;

                        if u5.CharacterMeshes[child.Name] then
                            v19 = u5.CharacterMeshes[child.Name].MeshId;
                        else
                            v19 = u3[child.Name];
                        end;

                        if not string.find(v19, "/") then
                            v19 = "rbxassetid://" .. v19;
                        end;

                        v18 = game.AssetService:CreateMeshPartAsync(Content.fromUri(v19), {
                            CollisionFidelity = Enum.CollisionFidelity.Box,
                            FluidFidelity = Enum.FluidFidelity.UseCollisionGeometry
                        });
                        v18.Name = child.Name;
                        u1[child] = v18;
                    end;

                    v15 = Instance.fromExisting(v18);
                    v15.CFrame = CFrame2;
                    v15.Size = v15.MeshSize;
                else
                    v15 = Instance.fromExisting(child);
                end;
            end;

            v15.Anchored = not p9;
            v15.CanCollide = false;
            v15.CanQuery = false;
            v15.Massless = true;
            v15.Reflectance = p12;
            v15.Size = v15.Size * p11;
            v15.RootPriority = v15.RootPriority - 1;
            v15.Color = u5.Color;
            v15.Material = p7;
            v15.MaterialVariant = "weh";
            v15.Transparency = child.Name == "HumanoidRootPart" and 1 or p10;
            u5.ToCopy[child] = v15;
            u5.ToOriginal[v15] = child;

            if child:FindFirstChildWhichIsA("Bone") then
                u5.SkinnedMeshParts[child] = v15;

                for _, child2 in child:GetChildren() do
                    if child2:IsA("Bone") then
                        child2:Clone().Parent = v15;
                    end;
                end;
            end;
        end;

        materialize(child, u5, p6, p7, u8, p9, p10, p11, p12);
    end;

    if v13 then
        local v20 = {};
        local v21 = {};

        for i, v in u5.SkinnedMeshParts do
            for _, v2 in i:GetJoints() do
                if v2:IsA("Motor6D") and (v2.Part0 and v2.Part1) then
                    v20[v] = true;
                    table.insert(v21, v2);
                    local v22 = Instance.fromExisting(v2);
                    v22.Part0 = u5.ToCopy[v22.Part0];
                    v22.Part1 = u5.ToCopy[v22.Part1];
                    v22.Parent = u5.ToCopy[v22.Part0];
                end;
            end;
        end;

        for _, v in v21 do
            local Motor6D = Instance.new("Motor6D");
            Motor6D.Part0 = u5.ToCopy[v.Part0];
            Motor6D.Part1 = u5.ToCopy[v.Part1];
            Motor6D.C0 = Motor6D.Part0.CFrame:ToObjectSpace(Motor6D.Part1.CFrame);
            Motor6D.Parent = u5.ToCopy[v.Part0];
        end;

        for i, v in u5.ToOriginal do
            if u5.SkinnedMeshParts[v] or v.Transparency < 1 then
                if v20[i] then
                    i.Parent = u5.Model;
                else
                    if p9 then
                        local Weld = Instance.new("Weld");
                        Weld.Part0 = i;
                        Weld.Part1 = v;
                        Weld.Parent = i;
                    end;

                    i.Parent = u5.Model;

                    if i.Name == "HumanoidRootPart" then
                        u5.Model.PrimaryPart = i;
                    end;
                end;
            end;
        end;

        u5.Model.Parent = workspace.Effects;

        function u5.Destroy(p23) -- Line: 181
            -- upvalues: u8 (copy), u5 (ref)
            if not u8 then
                u5.Model:Destroy();

                return;
            end;

            for _, v in u5.ToCopy do
                game.TweenService:Create(v, TweenInfo.new(u8), {
                    Transparency = 1
                }):Play();
            end;

            task.delay(u8, u5.Model.Destroy, u5.Model);
        end;

        return u5;
    end;
end;

return function(p24) -- Line: 196
    -- upvalues: materialize (copy), ParticleHandler (copy)
    local v25 = p24 or {};
    local Character = v25.Character;
    local v26 = v25.Color or Color3.fromHSV(0.600222, 0.6, 1);
    local v27 = v25.Weld or false;
    local Origin = v25.Origin;
    local Attribute = v25.Attribute;
    local u28 = materialize(Character, nil, v26, v25.Material or Enum.Material.Ice, v25.Duration == nil and 0.5 or v25.Duration, v27, v25.StartingTransparency or 0, v25.Scale or 1, v25.Reflectance or 0);

    if v27 then
        Character.AncestryChanged:Connect(function(p29, p30) -- Line: 213
            -- upvalues: u28 (copy)
            if not p30 then
                u28:Destroy();
            end;
        end);
    elseif Origin then
        u28.Model:PivotTo(ParticleHandler.TranslateToCFrame(Origin));
    end;

    if not Attribute then
        u28:Destroy();

        return u28;
    end;

    local u31 = nil;
    u31 = Character:GetAttributeChangedSignal(Attribute):Connect(function() -- Line: 221
        -- upvalues: Character (copy), Attribute (copy), u31 (ref), u28 (copy)
        if not Character:GetAttribute(Attribute) then
            u31:Disconnect();
            u31 = nil;
            u28:Destroy();
        end;
    end);

    return u28;
end;