  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.Knit);
local u1 = {
    [Enum.BodyPart.LeftArm] = "Left Arm",
    [Enum.BodyPart.RightArm] = "Right Arm",
    [Enum.BodyPart.LeftLeg] = "Left Leg",
    [Enum.BodyPart.RightLeg] = "Right Leg",
    [Enum.BodyPart.Torso] = "Torso",
    [Enum.BodyPart.Head] = "Head"
};
local u2 = { "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso", "Head" };

local function Lerp(p3, p4, p5) -- Line: 35
    return p3 + (p4 - p3) * p5;
end;

local function AfterImage(p6, p7, p8, p9, p10, p11, p12, p13, p14, p15) -- Line: 39
    -- upvalues: u1 (copy), TweenService (copy), u2 (copy), EffectsHandler (copy), Debris (copy)
    local v16 = p13 or {};
    local v17 = p6:GetScale();
    local u18 = p10 or TweenInfo.new(p8 or 0.25);
    local u19 = script.MeshChar:Clone();

    if typeof(p7) == "Color3" then
        p7 = Vector3.new(p7.R, p7.G, p7.B) or p7;
    end;

    local v20 = p7 * (p15 or 1);
    u19.Root.CFrame = p6:FindFirstChild("HumanoidRootPart") and p6.HumanoidRootPart.CFrame or p6:GetPivot();
    local v21 = u19.Root:GetChildren();

    for _, v in v21 do
        if v:IsA("WeldConstraint") then
            v.Enabled = false;
        end;
    end;

    local v22;

    if p6:FindFirstChild("Head") then
        v22 = p6.Head:FindFirstChild("Mesh") or nil;
    else
        v22 = nil;
    end;

    if v22 then
        if v22.MeshId == "" then
            u19.Head.Mesh.MeshId = "rbxassetid://5058520874";
            u19.Head.Mesh.Scale = Vector3.new(1, 1, 1);
        else
            u19.Head.Mesh.MeshId = v22.MeshId;
            u19.Head.Mesh.Scale = v22.Scale;
        end;
    end;

    local v23 = p6:GetChildren();
    u19.Parent = workspace.Effects;

    for _, v in v23 do
        if v:IsA("CharacterMesh") then
            u19[u1[v.BodyPart]].Mesh.MeshId = "rbxassetid://" .. v.MeshId;
        end;

        if v:IsA("Accessory") then
            local v24 = v:FindFirstChild("Handle") or v:FindFirstChildWhichIsA("BasePart");

            if v24 and (v24:FindFirstChild("AccessoryWeld") and (v24.AccessoryWeld.Part1 and (u19:FindFirstChild(v24.AccessoryWeld.Part1.Name) and v24.Transparency < 1))) then
                local v25 = v24.CFrame:ToObjectSpace(v24.AccessoryWeld.Part1.CFrame):Inverse();
                local v26 = v24:Clone();
                v26.CollisionGroup = "NoCollision";
                v26.AccessoryWeld:Destroy();
                v26.Parent = u19;
                v26.Anchored = false;
                v26.CanCollide = false;
                v26.Massless = true;
                v26.Material = v16.Material or Enum.Material.Neon;
                v26.Transparency = p9 or 0;
                v26:SetAttribute("IsAccessory", true);
                local Weld = Instance.new("Weld");
                Weld.Part0 = u19[v24.AccessoryWeld.Part1.Name];
                Weld.Part1 = v26;
                Weld.Parent = v26;
                Weld.C0 = v25;
                Weld.C1 = CFrame.identity;
                local v27 = v26:FindFirstChildOfClass("SpecialMesh");

                if v27 then
                    v27.TextureId = "rbxassetid://13803932886";
                    v27.VertexColor = v20;
                    v27.Scale = v27.Scale * (v16.AccessoryStartScale or 1);
                else
                    v26.TextureID = "";
                    v26.Color = Color3.new(p7.X, p7.Y, p7.Z);
                    v26.Size = v26.Size * (v16.AccessoryStartScale or 1);
                end;

                v26.Name = v.Name;
                v26.Transparency = p9 or 0;
                TweenService:Create(v26, u18, p11 or {
                    Transparency = 1
                }):Play();

                if v16.AccessoryScale or v16.SecondaryVertex then
                    if v27 then
                        TweenService:Create(v27, u18, p11 or {
                            Scale = v27.Scale * (v16.AccessoryScale or 1),
                            VertexColor = v16.SecondaryVertex or v27.VertexColor
                        }):Play();
                    else
                        TweenService:Create(v26, u18, p11 or {
                            Size = v26.Size * (v16.AccessoryScale or 1),
                            Color = Color3.new(v16.SecondaryVertex.X, v16.SecondaryVertex.Y, v16.SecondaryVertex.Z) or v26.Color
                        }):Play();
                    end;
                end;
            end;
        end;
    end;

    table.clear(v23);

    for _, v in u2 do
        local v28 = p6:FindFirstChild(v);

        if v28 and v28.Transparency < 1 then
            local v29 = u19[v];
            v29.CollisionGroup = "NoCollision";
            v29.Transparency = p9 or 0;
            v29.Mesh.VertexColor = v20;
            v29.Material = v16.Material or Enum.Material.Neon;
            v29.CFrame = v28.CFrame;
            local Mesh = v29.Mesh;
            Mesh.Scale = Mesh.Scale * (v17 * (v16.LimbStartScale or 1));
            TweenService:Create(v29, u18, p11 or {
                Transparency = 1
            }):Play();

            if v16.LimbScale or v16.SecondaryVertex then
                TweenService:Create(v29.Mesh, u18, p11 or {
                    Scale = v29.Mesh.Scale * (v16.LimbScale or 1),
                    VertexColor = v16.SecondaryVertex or v29.Mesh.VertexColor
                }):Play();
            end;
        else
            u19[v]:Destroy();
        end;
    end;

    if v16.StartScale then
        u19:ScaleTo(v16.StartScale);
    end;

    if v16.Scale then
        local u30 = 0;
        local Scale = v16.Scale;
        local u31 = v16.StartScale or 1;
        local u32 = u19:GetPivot();
        task.spawn(function() -- Line: 165
            -- upvalues: u30 (ref), EffectsHandler (ref), u18 (copy), u19 (copy), u31 (copy), Scale (copy), u32 (copy)
            while true do
                u30 = u30 + EffectsHandler.Wait() / u18.Time;

                if u19 then
                    local v33 = u31;
                    u19:ScaleTo(v33 + (Scale - v33) * u30);
                    u19:PivotTo(u32);
                end;

                if u30 >= 1 or not u19 then
                    return;
                end;
            end;
        end);
    end;

    for _, v in v21 do
        if v:IsA("WeldConstraint") then
            v.Enabled = true;
        end;
    end;

    u19.Root.CFrame = p12 or u19.Root.CFrame;

    if p14 then
        for _, v in v21 do
            if v:IsA("WeldConstraint") then
                v:Destroy();
            end;
        end;

        u19.Root:Destroy();

        for _, child in u19:GetChildren() do
            local v34 = not child:GetAttribute("IsAccessory") and p6:FindFirstChild(child.Name);

            if v34 then
                local WeldConstraint = Instance.new("WeldConstraint");
                WeldConstraint.Part0 = child;
                WeldConstraint.Part1 = v34;
                WeldConstraint.Parent = child;
                WeldConstraint.Name = "CharWeld";
            end;
        end;
    end;

    table.clear(v21);
    table.clear(v16);
    Debris:AddItem(u19, (p8 or 0.25) + 0.03333333333333333);

    return u19;
end;

return function(p35) -- Line: 213
    -- upvalues: RunService (copy), AfterImage (copy), EffectsHandler (copy)
    if not (p35.HookAttribute and p35.Character:GetAttribute(p35.HookAttribute)) then
        return AfterImage(p35.Character, p35.Vertex, p35.Duration, p35.StartingTransparency, p35.CustomTween, p35.CustomProperties, p35.CustomCFrame, p35.CustomData, p35.Weld, p35.VertexMultiplier);
    end;

    local u36 = p35.Character:FindFirstChildOfClass("Humanoid");

    if not u36 then
        return;
    end;

    local v37 = p35.Character:GetAttribute(p35.HookAttribute);
    local v38 = typeof(v37);
    local BoundToMovement = p35.BoundToMovement;
    local u39 = 0;
    local u40 = true;
    local v41;

    if BoundToMovement then
        v41 = RunService.RenderStepped:Connect(function() -- Line: 230
            -- upvalues: u39 (ref), u36 (copy), u40 (ref), BoundToMovement (copy)
            u39 = math.floor(u36.RootPart.Velocity.Magnitude);
            local v42;

            if BoundToMovement == "Walk" then
                v42 = u39 ~= 0;
            else
                v42 = u39 == 0;
            end;

            u40 = v42;
        end) or nil;
    else
        v41 = nil;
    end;

    while p35.Character and (p35.Character.Parent and p35.Character:GetAttribute(p35.HookAttribute)) do
        local v43 = p35.Character:GetAttribute(p35.HookAttribute);

        if v38 == "Color3" then
            p35.Vertex = Vector3.new(v43.R, v43.G, v43.B);
        elseif v38 == "CFrame" then
            p35.CustomCFrame = v43;
        end;

        if u40 then
            AfterImage(p35.Character, p35.Vertex, p35.Duration, p35.StartingTransparency, p35.CustomTween, p35.CustomProperties, p35.CustomCFrame, p35.CustomData, nil, p35.VertexMultiplier);
        end;

        EffectsHandler.Wait(u40 and (p35.Wait or 0) or 0);
    end;

    if v41 then
        if typeof(v41) == "thread" then
            print(task.cancel, v41);
        else
            v41:Disconnect();
        end;
    end;
end;