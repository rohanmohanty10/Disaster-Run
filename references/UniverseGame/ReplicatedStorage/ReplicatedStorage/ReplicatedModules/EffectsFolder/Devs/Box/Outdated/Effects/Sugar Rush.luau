  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.Knit);
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

return function(u2, p3, p4) -- Line: 17
    -- upvalues: u1 (copy), Debris (copy), ParticleHandler (copy), EffectsHandler (copy), TweenService (copy), CollectionService (copy)
    local v5, v6;

    if u2 then
        v5 = u2:FindFirstChild("HumanoidRootPart") or u2.PrimaryPart;
        v6 = u2:FindFirstChild("Humanoid");
    else
        v5 = nil;
        v6 = nil;
    end;

    if v5 == nil then
        return;
    end;

    local u7 = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(255, 255, 255) };

    local function CreateClone() -- Line: 33
        -- upvalues: u2 (copy), u1 (ref), Debris (ref), u7 (copy), ParticleHandler (ref), EffectsHandler (ref), TweenService (ref)
        local v8 = math.random(1, 3);

        if not u2 then
            return;
        end;

        local u9 = u1.CloneFlash:Clone();
        u9.Parent = workspace.Effects;
        Debris:AddItem(u9, 1);
        local Head = u9:FindFirstChild("Head");
        local Torso = u9:FindFirstChild("Torso");
        local v10 = u9:FindFirstChild("Left Arm");
        local v11 = u9:FindFirstChild("Right Arm");
        local v12 = u9:FindFirstChild("Left Leg");
        local v13 = u9:FindFirstChild("Right Leg");
        local v14 = u7;
        local v15 = ParticleHandler.GetUnusualHSVData({
            Character = u2
        });

        if v15 ~= nil then
            v14 = table.clone(v14);

            for i, v in v14 do
                v14[i] = ParticleHandler.TryHSVShift(v, v15);
            end;
        end;

        for _, child in pairs(u9:GetChildren()) do
            if child:IsA("BasePart") then
                child.Size = child.Size + Vector3.new(0.1, 0.1, 0.1);
                child.Color = v14[v8];
            end;
        end;

        Head.CFrame = u2.Head.CFrame;
        Torso.CFrame = u2.Torso.CFrame;
        v10.CFrame = u2["Left Arm"].CFrame;
        v11.CFrame = u2["Right Arm"].CFrame;
        v12.CFrame = u2["Left Leg"].CFrame;
        v13.CFrame = u2["Right Leg"].CFrame;
        local Weld = Instance.new("Weld");
        Weld.Part0 = u2.Head;
        Weld.Part1 = Head;
        Weld.Parent = Head;
        local Weld2 = Instance.new("Weld");
        Weld2.Part0 = u2.Torso;
        Weld2.Part1 = Torso;
        Weld2.Parent = Torso;
        local Weld3 = Instance.new("Weld");
        Weld3.Part0 = u2["Left Arm"];
        Weld3.Part1 = v10;
        Weld3.Parent = v10;
        local Weld4 = Instance.new("Weld");
        Weld4.Part0 = u2["Right Arm"];
        Weld4.Part1 = v11;
        Weld4.Parent = v11;
        local Weld5 = Instance.new("Weld");
        Weld5.Part0 = u2["Left Leg"];
        Weld5.Part1 = v12;
        Weld5.Parent = v12;
        local Weld6 = Instance.new("Weld");
        Weld6.Part0 = u2["Right Leg"];
        Weld6.Part1 = v13;
        Weld6.Parent = v13;
        coroutine.wrap(function() -- Line: 102
            -- upvalues: EffectsHandler (ref), Weld (copy), Weld2 (copy), Weld3 (copy), Weld4 (copy), Weld5 (copy), Weld6 (copy), u9 (copy)
            EffectsHandler.Wait(0.15);
            Weld:Destroy();
            Weld2:Destroy();
            Weld3:Destroy();
            Weld4:Destroy();
            Weld5:Destroy();
            Weld6:Destroy();

            for _, child in pairs(u9:GetChildren()) do
                if child:IsA("BasePart") then
                    child.Anchored = true;
                end;
            end;
        end)();

        for _, child in pairs(u9:GetChildren()) do
            TweenService:Create(child, TweenInfo.new(0.8), {
                Transparency = 1
            }):Play();
        end;
    end;

    local function CreateCloneModern() -- Line: 118
        -- upvalues: u2 (copy), u7 (copy), ParticleHandler (ref), EffectsHandler (ref)
        if not u2 then
            return;
        end;

        local v16 = math.random(1, 3);
        local v17 = u7;
        local v18 = ParticleHandler.GetUnusualHSVData({
            Character = u2
        });

        if v18 ~= nil then
            v17 = table.clone(v17);

            for i, v in v17 do
                v17[i] = ParticleHandler.TryHSVShift(v, v18);
            end;
        end;

        local u19 = EffectsHandler.CallEffect("Neon AfterImage", {
            Duration = 0.8,
            VertexMultiplier = 2.5,
            Weld = true,
            Character = u2,
            Vertex = v17[v16]
        });
        task.spawn(function() -- Line: 140
            -- upvalues: EffectsHandler (ref), u19 (copy)
            EffectsHandler.Wait(0.15);

            if not u19 then
                return;
            end;

            for _, child in u19:GetChildren() do
                if not child:GetAttribute("IsAccessory") then
                    child.CharWeld:Destroy();
                    child.Anchored = true;
                end;
            end;
        end);
    end;

    local v20 = u1["Candy Cutlass"].SugarRush.SugarRushEffect:Clone();
    v20.Parent = v5;
    local v21 = tick();
    local v22 = p4 or 35;

    while true do
        if p3 then
            CreateClone();
        else
            CreateCloneModern();
        end;

        EffectsHandler.Wait(0.135);

        if not CollectionService:HasTag(u2, "Christmas Spirit") or (u2 == nil or (not u2.Parent or (v6.Health <= 0 or v22 < tick() - v21))) then
            for _, child in pairs(v20:GetChildren()) do
                if child:IsA("ParticleEmitter") then
                    child.Enabled = false;
                end;
            end;

            Debris:AddItem(v20, 1.5);

            return;
        end;
    end;
end;