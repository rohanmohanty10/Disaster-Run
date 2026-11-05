  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local CollectionService = game:GetService("CollectionService");
local u1 = Random.new();

local function Lerp(p2, p3, p4) -- Line: 14
    return p2 + (p3 - p2) * p4;
end;

return function(u5, p6) -- Line: 18
    -- upvalues: u1 (copy), CollectionService (copy), EffectsHandler (copy)
    local u7 = p6 or {};
    local u8 = -(u7.DistanceScale or 1);
    local HumanoidRootPart = u5:FindFirstChild("HumanoidRootPart");
    local UseOneArm = u7.UseOneArm;
    local FauxRig = u5:FindFirstChild("FauxRig");
    local TorsoBased = u7.TorsoBased;

    if TorsoBased then
        HumanoidRootPart = u5.Torso;
    end;

    local u9 = {
        Right = {},
        Left = {}
    };

    local function Create(p10) -- Line: 37
        -- upvalues: FauxRig (copy), u5 (copy), u7 (ref), u9 (copy)
        local v11 = p10 .. " Arm";
        local v12 = script:WaitForChild("Parent"):Clone();
        local v13;

        if FauxRig then
            v13 = script.FauxArm:Clone();
        elseif u5.Parent:GetAttribute("Revived") then
            v13 = script.RealArm:Clone();
        else
            v13 = script.Arm:Clone();
        end;

        v13.Anchored = true;
        v13.CanCollide = false;
        v13.Massless = true;
        v13.Name = "Right Arm";

        if FauxRig then
            v13.Clothing.Decal.Texture = FauxRig.RobloxClothing:FindFirstChild(v11).Decal.Texture;
            v13.Color = FauxRig:FindFirstChild(v11).Color;
        end;

        v13.Parent = v12;
        local v14 = next;
        local v15, v16 = v13:GetDescendants();

        for _, v in v14, v15, v16 do
            if v:IsA("Weld") or (v:IsA("Motor6D") or v:IsA("WeldConstraint")) then
                if v.Part0 == u5:FindFirstChild(v11) then
                    v.Part0 = u5:FindFirstChild(v11);
                elseif v.Part1 == u5:FindFirstChild(v11) then
                    v.Part1 = u5:FindFirstChild(v11);
                elseif v.Part1:FindFirstAncestorWhichIsA("Tool") then
                    v:Destroy();
                end;
            elseif v:IsA("BasePart") then
                v.Anchored = false;
                v.CanCollide = false;
                v.Massless = true;
            elseif v:IsA("ParticleEmitter") or (v:IsA("Trail") or v:IsA("Beam") and not v:GetAttribute("Linger")) then
                v:Destroy();
            end;
        end;

        if u5:FindFirstChildOfClass("Shirt") then
            u5:FindFirstChildOfClass("Shirt"):Clone().Parent = v12;
        end;

        if u5:FindFirstChildWhichIsA("BodyColors") then
            v13.BrickColor = u5:FindFirstChildWhichIsA("BodyColors")[p10 .. "ArmColor"];
        end;

        v12:PivotTo(CFrame.new(0, 100000, 0));
        v12.Parent = workspace.Effects;
        local v17 = {
            Active = false,
            Model = v12
        };

        if u7.Highlight then
            local Highlight = Instance.new("Highlight");
            Highlight.Parent = v12;
            Highlight.FillColor = u7.Highlight.FillColor or Color3.fromRGB(255, 255, 255);
            Highlight.FillTransparency = u7.Highlight.FillTransparency or 0.95;
            Highlight.OutlineColor = u7.Highlight.OutlineColor or Color3.fromRGB(255, 255, 255);
            Highlight.OutlineTransparency = u7.Highlight.OutlineTransparency or 0.5;
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        end;

        table.insert(u9[p10], v17);

        return v17;
    end;

    local function Get(p18) -- Line: 104
        -- upvalues: u9 (copy)
        for _, v in pairs(u9[p18]) do
            if not v.Active then
                return v;
            end;
        end;
    end;

    local function Retrieve(p19) -- Line: 112
        -- upvalues: u9 (copy), Create (copy)
        for _, v in pairs(u9[p19]) do
            if not v.Active then
                break;
            end;
        end;

        return v or Create(p19);
    end;

    local function BarrageEffect() -- Line: 129
        -- upvalues: u1 (ref), UseOneArm (copy), u9 (copy), Create (copy), FauxRig (copy), CollectionService (ref), HumanoidRootPart (ref), TorsoBased (copy), u7 (ref), u8 (copy), EffectsHandler (ref)
        local v20 = u1:NextInteger(1, 2);
        local v21 = v20 == 1 and "Left" or "Right";

        if UseOneArm and typeof(UseOneArm) == "string" then
            v21 = UseOneArm;
        end;

        for _, v in pairs(u9[v21]) do
            if not v.Active then
                break;
            end;
        end;

        local v22 = v or Create(v21);
        local v23 = v22.Model[v21 .. " Arm"];
        v22.Active = true;

        if not FauxRig then
            v23.Transparency = 1;
        end;

        for _, descendant in pairs(v23:GetDescendants()) do
            if (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) and (not CollectionService:HasTag(descendant, "Invisible") and descendant.Name ~= "Clothing") then
                descendant.Transparency = 0;
            end;
        end;

        local v24 = u1:NextInteger(0.25, 2) * (v20 == 1 and 1 or -1);
        local v25 = u1:NextInteger(-1, 1.5);
        local v26 = u1:NextInteger(-0.25, 0.25);
        local CFrame2 = HumanoidRootPart.CFrame;

        if TorsoBased and u7.LookAtPart then
            CFrame2 = CFrame.new(HumanoidRootPart.Position, u7.LookAtPart.Position);
        end;

        local v27 = CFrame2 * (u7.Offset or CFrame.identity);
        local v28 = CFrame.new(v24, v25, v26);
        local Angles = CFrame.Angles;
        local v29 = u1:NextNumber(-15, 15);
        local v30 = math.rad(v29);
        local v31 = u1:NextNumber(-10, 10);
        local v32 = v27 * (v28 * Angles(v30, math.rad(v31), 0));
        local v33 = v32 * CFrame.new(0, 0, u1:NextNumber(6.25, 7.25) * u8);
        local v34 = u7.ArmLength or 0.15;
        local v35 = u7.FadeOut or 0.05;
        local v36 = os.clock();
        local v37 = v32 * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0);
        local v38 = v33 * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0);

        while os.clock() - v36 <= v34 do
            if v35 <= os.clock() - v36 then
                local v39 = os.clock() - v36;
                local v40 = math.abs(v39) / (v34 - v35);
                local v41 = 0 + 1 * math.clamp(v40, 0, 1);
                v23.Transparency = not FauxRig and 1 or v41;

                for _, descendant in pairs(v23:GetDescendants()) do
                    if (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) and (not CollectionService:HasTag(descendant, "Invisible") and descendant.Name ~= "Clothing") then
                        descendant.Transparency = v41;
                    end;
                end;
            end;

            local v42 = os.clock() - v36;
            local v43 = math.abs(v42) / v34;
            v23:PivotTo(v37:Lerp(v38, (math.clamp(v43, 0, 1))));
            EffectsHandler.Wait();
        end;

        v22.Active = false;
    end;

    local v44 = 0;

    local function Clear(p45) -- Line: 119
        -- upvalues: u9 (copy)
        for _, v in pairs(u9[p45]) do
            if v.Model then
                v.Model:Destroy();
                v.Model = nil;
            end;
        end;
    end;

    while u5 and (u5:IsDescendantOf(workspace) and CollectionService:HasTag(u5, "Barraging")) do
        if os.clock() - v44 >= 0.05 then
            v44 = os.clock();

            for _ = 1, 6 do
                task.spawn(BarrageEffect);
            end;
        end;

        EffectsHandler.Wait();
    end;

    EffectsHandler.Wait(1);
    Clear("Left");
    Clear("Right");
end;