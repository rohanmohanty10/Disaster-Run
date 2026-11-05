  

 

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
    local TorsoBased = u7.TorsoBased;

    if TorsoBased then
        HumanoidRootPart = u5.Torso;
    end;

    local u9 = {
        Right = {},
        Left = {}
    };

    local function Create(p10) -- Line: 35
        -- upvalues: u5 (copy), u9 (copy)
        local v11 = p10 .. " Arm";
        local v12 = script:WaitForChild("Parent"):Clone();
        local v13 = u5:FindFirstChild(v11);

        if v13 then
            local v14 = v13:Clone();
            v14.Parent = v12;
            v14.Anchored = true;
            v14.CanCollide = false;
            v14.Massless = true;
            local v15 = next;
            local v16, v17 = v14:GetDescendants();

            for _, v in v15, v16, v17 do
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

            if u5:FindFirstChild("Stand") and u5:FindFirstChild("Stand"):FindFirstChild(v11) then
                local v18 = u5:FindFirstChild("Stand"):FindFirstChild(v11):Clone();

                for _, child in v18:GetChildren() do
                    if child:IsA("Motor6D") then
                        child:Destroy();
                    end;
                end;

                local Weld = Instance.new("Weld");
                Weld.Part0 = v14;
                Weld.Part1 = v18;
                Weld.Parent = v14;
                v18.Parent = v14;
            end;

            if u5:FindFirstChildOfClass("Shirt") then
                u5:FindFirstChildOfClass("Shirt"):Clone().Parent = v12;
            end;

            if u5:FindFirstChildWhichIsA("BodyColors") then
                v14.BrickColor = u5:FindFirstChildWhichIsA("BodyColors")[p10 .. "ArmColor"];
            end;

            v12:PivotTo(CFrame.new(0, 100000, 0));
            v12.Parent = workspace.Effects;
            local v19 = {
                Active = false,
                Model = v12
            };
            table.insert(u9[p10], v19);

            return v19;
        end;
    end;

    local function Get(p20) -- Line: 101
        -- upvalues: u9 (copy)
        for _, v in pairs(u9[p20]) do
            if not v.Active then
                return v;
            end;
        end;
    end;

    local function Retrieve(p21) -- Line: 109
        -- upvalues: u9 (copy), Create (copy)
        for _, v in pairs(u9[p21]) do
            if not v.Active then
                break;
            end;
        end;

        return v or Create(p21);
    end;

    local function BarrageEffect() -- Line: 126
        -- upvalues: u9 (copy), Create (copy), u1 (ref), HumanoidRootPart (ref), TorsoBased (copy), u7 (ref), u8 (copy), EffectsHandler (ref)
        for _, v in pairs(u9.Right) do
            if not v.Active then
                break;
            end;
        end;

        local v22 = v or Create("Right");
        local v23 = v22.Model["Right Arm"];
        v22.Active = true;
        v23.Transparency = 0;

        for _, descendant in pairs(v23:GetDescendants()) do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                if descendant.Name == "AbsorberGlow" then
                    descendant:Destroy();
                else
                    descendant.Transparency = 0;
                end;
            elseif descendant:IsA("Attachment") then
                descendant:Destroy();
            end;
        end;

        local v24 = u1:NextNumber(-1, 1) * 1;
        local v25 = u1:NextNumber(-0.7, 0.7);
        local v26 = u1:NextNumber(-0.25, 0.25);
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
                v23.Transparency = v41;

                for _, descendant in pairs(v23:GetDescendants()) do
                    if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                        if descendant.Name == "AbsorberGlow" then
                            descendant:Destroy();
                        else
                            descendant.Transparency = v41;
                        end;
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

    local function Clear(p45) -- Line: 116
        -- upvalues: u9 (copy)
        for _, v in pairs(u9[p45]) do
            if v.Model then
                v.Model:Destroy();
                v.Model = nil;
            end;
        end;
    end;

    while u5 and (u5:IsDescendantOf(workspace) and CollectionService:HasTag(u5, "Barraging")) do
        if os.clock() - v44 >= 0.03 then
            v44 = os.clock();
            task.spawn(BarrageEffect);
            task.spawn(BarrageEffect);
        end;

        EffectsHandler.Wait();
    end;

    EffectsHandler.Wait(1);
    Clear("Left");
    Clear("Right");
end;