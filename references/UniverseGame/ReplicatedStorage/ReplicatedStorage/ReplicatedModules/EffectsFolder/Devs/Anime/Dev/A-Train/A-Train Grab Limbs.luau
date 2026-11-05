  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
ReplicatedStorage:FindFirstChild("Client Assets");
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();

return function(p2) -- Line: 13
    -- upvalues: u1 (copy), TweenService (copy), AssetHandler (copy), ParticleHandler (copy)
    local v3 = p2 or {};
    local Character = v3.Character;
    local Duration = v3.Duration;

    if not Character then
        return;
    end;

    local u4 = Character:Clone();
    u4.Parent = workspace.Effects;
    task.delay(Duration + 8, u4.Destroy, u4);

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("BillboardGui") or (descendant:IsA("Script") or (descendant:IsA("Decal") or (descendant:IsA("Texture") or (descendant:IsA("Motor6D") or (descendant:IsA("Weld") or descendant:IsA("Accessory")))))) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;

    for _, v in { "Left Leg", "Left Arm", "Right Leg", "Right Arm", "Torso" } do
        local v5 = v == "Torso" and Duration * 0.75 or Duration * u1:NextNumber(0.23, 0.6);
        task.delay(v5, function() -- Line: 38
            -- upvalues: Character (copy), v (copy), u4 (copy), TweenService (ref), AssetHandler (ref)
            local v6 = Character[v];
            local u7 = u4[v];
            v6.Transparency = 1;
            u7.CFrame = v6.CFrame;
            u7.Anchored = false;
            u7.CollisionGroup = "Ghosted";
            u7.CanCollide = true;
            TweenService:Create(u7, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 5), {
                Size = Vector3.new(0, 0, 0)
            }):Play();

            for _, child in AssetHandler.GetAsset("Particles/LimbBlood", {
                AbilityName = "UGrain"
            }):GetChildren() do
                child:Clone().Parent = u7;
            end;

            task.delay(5, function() -- Line: 57
                -- upvalues: u7 (copy)
                for _, descendant in u7:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                        descendant.Enabled = false;
                    end;
                end;
            end);
        end);
    end;

    local v8 = AssetHandler.CloneAsset("Models/SkeletonHead", {
        AbilityName = "UGrain"
    });
    v8.Parent = Character;
    ParticleHandler.AttachTo(v8, {
        Part = Character.Head
    });
    local v9 = TweenInfo.new(Duration * 0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, Duration * 0.25);

    for _, descendant in v8:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.Transparency = 1;
            TweenService:Create(descendant, v9, {
                Transparency = 0
            }):Play();
        end;
    end;

    TweenService:Create(Character.Head, v9, {
        Transparency = 1
    }):Play();
    local v10 = { "FaceCenterAttachment", "FaceFrontAttachment", "HatAttachment", "HairAttachment" };

    for _, child in Character:GetChildren() do
        if child:IsA("Accessory") then
            for _, v in v10 do
                if child.Handle:FindFirstChild(v) then
                    for _, descendant in child:GetDescendants() do
                        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                            TweenService:Create(child.Handle, v9, {
                                Transparency = 1
                            }):Play();
                        end;
                    end;
                end;
            end;
        end;
    end;
end;