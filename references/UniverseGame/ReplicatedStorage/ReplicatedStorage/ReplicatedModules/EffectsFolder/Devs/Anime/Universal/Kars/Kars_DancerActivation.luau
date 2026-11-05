  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local u1 = game.ReplicatedStorage["Client Assets"];
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(u2, p3) -- Line: 13
    -- upvalues: TweenService (copy), ParticleHandler (copy), u1 (copy), Debris (copy)
    if not u2 then
        return;
    end;

    if game.Players:GetPlayerFromCharacter(u2) == game.Players.LocalPlayer then
        local BloomEffect = Instance.new("BloomEffect");
        BloomEffect.Intensity = 3.5;
        BloomEffect.Parent = game.Lighting;
        task.delay(p3, function() -- Line: 24
            -- upvalues: TweenService (ref), BloomEffect (copy)
            local v4 = TweenService:Create(BloomEffect, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Intensity = 0
            });
            v4.Completed:Connect(function() -- Line: 28
                -- upvalues: BloomEffect (ref)
                BloomEffect:Destroy();
            end);
            v4:Play();
        end);
    end;

    local v5;

    if u2 then
        local _ = u2:FindFirstChild("HumanoidRootPart") or u2.PrimaryPart;
        v5 = u2:FindFirstChild("Humanoid");
    else
        v5 = nil;
    end;

    local u6 = { Color3.fromRGB(255, 102, 204), Color3.fromRGB(128, 187, 219) };
    local v7 = ParticleHandler.GetUnusualHSVData({
        Character = u2
    });

    if v7 ~= nil then
        for i, v in u6 do
            u6[i] = ParticleHandler.HSVShift(v, v7);
        end;
    end;

    local function CreateClone() -- Line: 54
        -- upvalues: u2 (copy), u1 (ref), Debris (ref), u6 (copy)
        local v8 = math.random(1, 2);

        if u2 == nil then
            return;
        end;

        local u9 = u1.CloneFlash:Clone();
        u9.Parent = workspace.Effects;
        Debris:AddItem(u9, 0.08);
        local Head = u9:FindFirstChild("Head");
        local Torso = u9:FindFirstChild("Torso");
        local v10 = u9:FindFirstChild("Left Arm");
        local v11 = u9:FindFirstChild("Right Arm");
        local v12 = u9:FindFirstChild("Left Leg");
        local v13 = u9:FindFirstChild("Right Leg");

        for _, child in pairs(u9:GetChildren()) do
            if child:IsA("BasePart") then
                child.Size = child.Size + Vector3.new(0.1, 0.1, 0.1);
                child.Color = u6[v8];
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
        coroutine.wrap(function() -- Line: 114
            -- upvalues: Weld (copy), Weld2 (copy), Weld3 (copy), Weld4 (copy), Weld5 (copy), Weld6 (copy), u9 (copy)
            task.wait(0.15);
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
            child.Transparency = 0.7;
        end;
    end;

    local v14 = os.clock();

    repeat
        CreateClone();
        task.wait(0.11);
    until (p3 or 1) < os.clock() - v14 or (u2 == nil or (not u2.Parent or v5.Health <= 0));
end;