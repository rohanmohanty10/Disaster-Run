  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Players");
game:GetService("Debris");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local StandSounds = game:GetService("SoundService").StandSounds;
local u1 = {
    Head = 0,
    ["Left Arm"] = 0.65,
    ["Right Arm"] = 0.65,
    Torso = 0.65,
    ["Left Leg"] = 1.5,
    ["Right Leg"] = 1.5
};

local function Emit(u2) -- Line: 21
    -- upvalues: Emit (copy), EffectsHandler (copy)
    if not u2 then
        return;
    end;

    if u2:IsA("Attachment") then
        for _, child in u2:GetChildren() do
            Emit(child);
        end;

        return;
    end;

    if u2:IsA("ParticleEmitter") then
        local u3 = u2:GetAttribute("EmitDelay");
        local u4 = u2:GetAttribute("EmitCount");

        if u3 and u3 > 0 then
            task.spawn(function() -- Line: 31
                -- upvalues: EffectsHandler (ref), u3 (copy), u2 (copy), u4 (copy)
                EffectsHandler.Wait(u3);
                u2:Emit(u4);
            end);

            return;
        end;

        u2:Emit(u4);
    end;
end;

return function(p5) -- Line: 41
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), u1 (copy), StandSounds (copy), Emit (copy), TweenService (copy)
    local TargetCharacter = p5.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    for _, child in TargetCharacter:GetChildren() do
        if child:IsA("BasePart") then
            child.CollisionGroup = "NoCollision";
            child.CanCollide = false;

            if child == HumanoidRootPart then
                child.Anchored = true;
            end;
        elseif child:IsA("Model") then
            child:Destroy();
        end;
    end;

    local v6 = Random.new();
    local v7 = AssetHandler.CloneAsset("Hakai/DummyModel", {
        AbilityName = "KillEffects"
    });
    v7.Parent = workspace.Effects;
    local HumanoidRootPart2 = v7.HumanoidRootPart;
    EffectsHandler.CallEffect("Dress Character As", v7, nil, nil, TargetCharacter);
    local v8 = v7:GetDescendants();
    local v9 = {};

    for _, v in v8 do
        if v:IsA("Decal") or v:IsA("BasePart") then
            v.Transparency = v.Transparency < 1 and 0.5 or 1;

            if v:IsA("BasePart") then
                v.CollisionGroup = "NoCollision";
                v.CanCollide = false;

                if v.Parent == v7 and TargetCharacter:FindFirstChild(v.Name) then
                    v.Anchored = true;
                    v.CFrame = TargetCharacter[v.Name].CFrame;
                end;

                if v.Parent:IsA("Accessory") then
                    local v10 = v:FindFirstChildOfClass("Weld") or v:FindFirstChildOfClass("WeldConstraint");

                    if v10 and v10.Part1 then
                        local Name = v10.Part1.Name;

                        if not v9[Name] then
                            v9[Name] = {};
                        end;

                        table.insert(v9[Name], v);
                    end;
                end;
            end;
        end;
    end;

    local v11 = TargetCharacter and TargetCharacter:GetPivot() or v7:GetPivot();
    v7:ScaleTo(TargetCharacter:GetScale());
    HumanoidRootPart2.CFrame = HumanoidRootPart.CFrame;
    v7:PivotTo(v11);
    local v12 = 0;

    for _, v in u1 do
        v12 = v12 + v;
    end;

    local v13 = AssetHandler.CloneAsset("Hakai/Sounds/Start", {
        AbilityName = "KillEffects"
    });
    v13.Parent = HumanoidRootPart2;
    v13.SoundGroup = StandSounds;
    v13:Play();
    local u14 = AssetHandler.CloneAsset("Hakai/Hakai", {
        AbilityName = "KillEffects"
    });
    u14.Parent = workspace.Effects;

    for _, child in u14:GetChildren() do
        child.Anchored = true;
        child.CollisionGroup = "Ghosted";
        child.CFrame = v7[child.Name].CFrame;
        Emit(child.Glow);
        Emit(child:FindFirstChild("BurstGlow"));
    end;

    local v15 = v7:GetScale();
    local v16 = v15;
    local v17 = 0.055;

    repeat
        v7:ScaleTo(v15 + v17);
        v15 = v7:GetScale();
        v17 = v16 + 1.15 <= v15 and -0.055 or v17;
        v7:PivotTo(v11 * CFrame.new(v6:NextNumber(-0.15, 0.15), v6:NextNumber(-0.15, 0.15), v6:NextNumber(-0.15, 0.15)));
        EffectsHandler.Wait(0.01);
    until v17 < 0 and v15 <= v16;

    local v18 = AssetHandler.CloneAsset("Hakai/Sounds/Erasure", {
        AbilityName = "KillEffects"
    });
    v18.Parent = v7.HumanoidRootPart;
    v18.SoundGroup = StandSounds;
    v18:Play();
    TweenService:Create(v18, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, v12 / 2), {
        Volume = 0
    }):Play();
    local v19 = AssetHandler.CloneAsset("Hakai/Sounds/Shine", {
        AbilityName = "KillEffects"
    });
    v19.Parent = HumanoidRootPart2;
    v19.SoundGroup = StandSounds;
    v19:Play();

    for _, child in u14.Torso.ConstantGlow:GetChildren() do
        child.Enabled = true;
    end;

    v7:ScaleTo(v16);
    v7:PivotTo(v11);

    if TargetCharacter then
        TargetCharacter:Destroy();
    end;

    for _, v in v8 do
        if v:IsA("Decal") or v:IsA("BasePart") then
            v.Transparency = v.Transparency < 1 and 0 or 1;
        end;
    end;

    for i, v in u1 do
        local v20 = v7:FindFirstChild(i);

        if v20 then
            local v21 = v20:FindFirstChildOfClass("Decal");

            if v9[i] then
                for _, v2 in v9[i] do
                    TweenService:Create(v2, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, v), {
                        Transparency = 1
                    }):Play();
                end;
            end;

            if v21 then
                TweenService:Create(v21, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, v), {
                    Transparency = 1
                }):Play();
            end;

            if i == "Torso" then
                task.spawn(function() -- Line: 173
                    -- upvalues: EffectsHandler (ref), v (copy), u14 (copy), i (copy)
                    EffectsHandler.Wait(v + 1.1111111111111112);

                    for _, child in u14[i].ConstantGlow:GetChildren() do
                        if child:IsA("ParticleEmitter") then
                            child.Enabled = false;
                        end;
                    end;
                end);
            end;

            task.spawn(function() -- Line: 183
                -- upvalues: EffectsHandler (ref), v (copy), u14 (copy), i (copy)
                EffectsHandler.Wait(v);

                for _, child in u14[i]:GetChildren() do
                    if child:IsA("ParticleEmitter") and child.Name ~= "Glow" then
                        child.Enabled = true;
                    end;
                end;
            end);
            local u22 = TweenService:Create(v20, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, v), {
                Transparency = 1
            });
            u22:Play();
            task.spawn(function() -- Line: 194
                -- upvalues: u22 (copy), u14 (copy), i (copy)
                u22.Completed:Wait();

                for _, child in u14[i]:GetChildren() do
                    if child:IsA("ParticleEmitter") then
                        child.Enabled = false;
                    end;
                end;
            end);
        end;
    end;

    EffectsHandler.Wait(v12 * 2.5 + 1);
    table.clear(v8);
    v7:Destroy();
    u14:Destroy();
end;