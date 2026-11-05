  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = { Enum.Material.Glass, Enum.Material.Neon };
local u2 = TweenInfo.new(0.69, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
local StandSounds = game:GetService("SoundService").StandSounds;

return function(p3, p4) -- Line: 55
    -- upvalues: Debris (copy), u2 (copy), AssetHandler (copy), StandSounds (copy), TweenService (copy), u1 (copy)
    local u5 = Random.new();
    local Model = Instance.new("Model");
    Model.Parent = workspace.Effects;
    Debris:AddItem(Model, u2.Time + 1);
    local v6 = AssetHandler.CloneAsset("Banish/Audio", {
        AbilityName = "KillEffects"
    });
    v6.SoundGroup = StandSounds;
    v6.Parent = p3.HumanoidRootPart;
    v6.PlayOnRemove = true;
    local u7 = {};
    local v8 = nil;

    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
            descendant.Transparency = 1;

            if descendant.Parent:IsA("Accessory") then
                descendant.Transparency = 0;
                table.insert(u7, descendant);
                local v9 = descendant:FindFirstChildOfClass("SpecialMesh");
                local v10 = descendant:FindFirstChild("AccessoryWeld") or descendant:FindFirstChildOfClass("Weld");

                if descendant:IsA("MeshPart") then
                    descendant.TextureID = "";
                elseif v9 then
                    v9.TextureId = "";
                end;

                if v10 then
                    v10:Destroy();
                end;

                descendant.Anchored = true;
                v8 = TweenService:Create(descendant, u2, {
                    Transparency = 0.8
                });
                v8:Play();
            elseif descendant.Parent == p3 then
                table.insert(u7, descendant);
                descendant.Anchored = true;
                descendant.Transparency = 0;
                v8 = TweenService:Create(descendant, u2, {
                    Transparency = 0.8
                });
                v8:Play();
            end;
        elseif descendant:IsA("Beam") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Motor6D") and descendant.Parent.Parent == p3)) then
            descendant:Destroy();
        end;
    end;

    v6:Destroy();

    for _, v in u7 do
        v.Parent = Model;
    end;

    local v12 = task.spawn(function() -- Line: 166
        -- upvalues: u1 (ref), u5 (copy), u7 (copy)
        while true do
            task.wait();
            local v11 = u1[u5:NextInteger(1, #u1)];

            for _, v in u7 do
                v.CFrame = v.CFrame * CFrame.new(u5:NextNumber(-1, 1), u5:NextNumber(-1, 1), u5:NextNumber(-1, 1));
                v.Material = v11;
            end;
        end;
    end);
    v8.Completed:Wait();
    pcall(task.cancel, v12);

    if Model then
        Model:Destroy();
    end;
end;