  

 

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
    -- upvalues: u1 (copy), EffectsHandler (copy), CollectionService (copy)
    local u7 = p6 or {};
    local u8 = -(u7.DistanceScale or 1);
    local HumanoidRootPart = u5:FindFirstChild("HumanoidRootPart");
    local UseOneArm = u7.UseOneArm;
    local u9 = u7.LimbType or "Arm";
    local TorsoBased = u7.TorsoBased;

    if TorsoBased then
        HumanoidRootPart = u5.Torso;
    end;

    local u10 = {
        Right = {},
        Left = {}
    };

    local function Create(p11) -- Line: 37
        -- upvalues: u9 (copy), u5 (copy), u7 (ref), u10 (copy)
        local v12 = p11 .. " " .. u9;
        local v13 = script:WaitForChild("Parent"):Clone();
        local v14 = u5:FindFirstChild(v12);

        if v14 then
            local v15 = v14:Clone();
            v15.Parent = v13;
            v15.Anchored = true;
            v15.CanCollide = false;
            v15.Massless = true;
            local v16 = next;
            local v17, v18 = v15:GetDescendants();

            for _, v in v16, v17, v18 do
                if v:IsA("Weld") or (v:IsA("Motor6D") or v:IsA("WeldConstraint")) then
                    if v.Part0 == u5:FindFirstChild(v12) then
                        v.Part0 = u5:FindFirstChild(v12);
                    elseif v.Part1 == u5:FindFirstChild(v12) then
                        v.Part1 = u5:FindFirstChild(v12);
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

            if u5:FindFirstChildOfClass("Pants") then
                u5:FindFirstChildOfClass("Pants"):Clone().Parent = v13;
            end;

            if u5:FindFirstChildOfClass("Shirt") then
                u5:FindFirstChildOfClass("Shirt"):Clone().Parent = v13;
            end;

            if u5:FindFirstChildWhichIsA("BodyColors") then
                v15.BrickColor = u5:FindFirstChildWhichIsA("BodyColors")[p11 .. u9 .. "Color"];
            end;

            v13:PivotTo(CFrame.new(0, 100000, 0));
            v13.Parent = workspace.Effects;
            local v19 = {
                Active = false,
                Model = v13
            };

            if u7.Highlight then
                local Highlight = Instance.new("Highlight");
                Highlight.Parent = v13;
                Highlight.FillColor = u7.Highlight.FillColor or Color3.fromRGB(255, 255, 255);
                Highlight.FillTransparency = u7.Highlight.FillTransparency or 0.95;
                Highlight.OutlineColor = u7.Highlight.OutlineColor or Color3.fromRGB(255, 255, 255);
                Highlight.OutlineTransparency = u7.Highlight.OutlineTransparency or 0.5;
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            end;

            table.insert(u10[p11], v19);

            return v19;
        end;
    end;

    local function Get(p20) -- Line: 103
        -- upvalues: u10 (copy)
        for _, v in pairs(u10[p20]) do
            if not v.Active then
                return v;
            end;
        end;
    end;

    local function Retrieve(p21) -- Line: 111
        -- upvalues: u10 (copy), Create (copy)
        for _, v in pairs(u10[p21]) do
            if not v.Active then
                break;
            end;
        end;

        return v or Create(p21);
    end;

    local function BarrageEffect() -- Line: 128
        -- upvalues: u1 (ref), UseOneArm (copy), u10 (copy), Create (copy), u9 (copy), HumanoidRootPart (ref), TorsoBased (copy), u7 (ref), u8 (copy), EffectsHandler (ref)
        local v22 = u1:NextInteger(1, 2);
        local v23 = v22 == 1 and "Left" or "Right";

        if UseOneArm and typeof(UseOneArm) == "string" then
            v23 = UseOneArm;
        end;

        for _, v in pairs(u10[v23]) do
            if not v.Active then
                break;
            end;
        end;

        local v24 = v or Create(v23);
        local v25 = v24.Model[v23 .. " " .. u9];
        v24.Active = true;
        v25.Transparency = 0;

        for _, descendant in pairs(v25:GetDescendants()) do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                descendant.Transparency = 0;
            end;
        end;

        local v26 = u1:NextInteger(0.25, 2) * (v22 == 1 and 1 or -1);
        local v27 = u1:NextInteger(-1, 1.5);
        local v28 = u1:NextInteger(-0.25, 0.25);
        local CFrame2 = HumanoidRootPart.CFrame;

        if TorsoBased and u7.LookAtPart then
            CFrame2 = CFrame.new(HumanoidRootPart.Position, u7.LookAtPart.Position);
        end;

        local v29 = CFrame2 * (u7.Offset or CFrame.identity);
        local v30 = CFrame.new(v26, v27, v28);
        local Angles = CFrame.Angles;
        local v31 = u1:NextNumber(-15, 15);
        local v32 = math.rad(v31);
        local v33 = u1:NextNumber(-10, 10);
        local v34 = v29 * (v30 * Angles(v32, math.rad(v33), 0));
        local v35 = v34 * CFrame.new(0, 0, u1:NextNumber(6.25, 7.25) * u8);
        local v36 = u7.ArmLength or 0.15;
        local v37 = u7.FadeOut or 0.05;
        local v38 = os.clock();
        local v39 = v34 * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0);
        local v40 = v35 * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0);

        while os.clock() - v38 <= v36 do
            if v37 <= os.clock() - v38 then
                local v41 = os.clock() - v38;
                local v42 = math.abs(v41) / (v36 - v37);
                local v43 = 0 + 1 * math.clamp(v42, 0, 1);
                v25.Transparency = v43;

                for _, descendant in pairs(v25:GetDescendants()) do
                    if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                        descendant.Transparency = v43;
                    end;
                end;
            end;

            local v44 = os.clock() - v38;
            local v45 = math.abs(v44) / v36;
            v25:PivotTo(v39:Lerp(v40, (math.clamp(v45, 0, 1))));
            EffectsHandler.Wait();
        end;

        v24.Active = false;
    end;

    local v46 = 0;

    local function Clear(p47) -- Line: 118
        -- upvalues: u10 (copy)
        for _, v in pairs(u10[p47]) do
            if v.Model then
                v.Model:Destroy();
                v.Model = nil;
            end;
        end;
    end;

    while u5 and (u5:IsDescendantOf(workspace) and CollectionService:HasTag(u5, "Barraging")) do
        if os.clock() - v46 >= 0.05 then
            v46 = os.clock();

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