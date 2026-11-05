  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function lerp(p1, p2, p3) -- Line: 8
    return p1 + (p2 - p1) * p3;
end;

return function(p4) -- Line: 12
    -- upvalues: EffectsHandler (copy), AssetHandler (copy)
    local v5 = p4 or {};
    local TargetCharacter = v5.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v5.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    local u6 = Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local v7 = HumanoidRootPart.Position - Vector3.new(0, 2.5, 0);
    local Folder = Instance.new("Folder");
    Folder.Name = "_ref";
    Folder.Parent = workspace.Effects;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset("Time Displacement/Trigger", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    task.delay(2, Folder.Destroy, Folder);
    EffectsHandler.CallEffect("ChronoWarden_IcosphereUnstable", {
        Scale = 9,
        Duration = 2,
        Reference = Folder,
        Origin = v7
    });
    task.delay(2, function() -- Line: 47
        -- upvalues: EffectsHandler (ref), AssetHandler (ref), HumanoidRootPart (copy), TargetCharacter (copy), u6 (copy)
        EffectsHandler.CallEffect("Play Sound At", {
            Object = AssetHandler.GetAsset("Time Displacement/Break", {
                AbilityName = "KillEffects"
            }),
            Origin = CFrame.new(HumanoidRootPart.Position)
        });
        TargetCharacter.Archivable = true;
        local u8 = TargetCharacter:Clone();
        u8.Parent = workspace.Effects;

        for _, descendant in u8:GetDescendants() do
            if descendant:IsA("Shirt") or (descendant:IsA("Pants") or (descendant:IsA("ShirtGraphic") or (descendant:IsA("LuaSourceContainer") or (descendant:IsA("JointInstance") or (descendant:IsA("Decal") or (descendant:IsA("Texture") or (descendant:IsA("Humanoid") or descendant:IsA("GuiBase")))))))) then
                descendant:Destroy();
            elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in u8:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.Material = "Neon";
                descendant.Color = Color3.fromRGB(111, 137, 255);

                if descendant:FindFirstChildOfClass("SpecialMesh") then
                    descendant:FindFirstChildOfClass("SpecialMesh").TextureId = "";
                elseif descendant:IsA("MeshPart") then
                    descendant.TextureID = "";
                end;

                local v9 = CFrame.new(u6:NextNumber(-6, 6), u6:NextNumber(2, 4), u6:NextNumber(-6, 6));
                local v10 = CFrame.Angles(u6:NextNumber(-4.71238898038469, 4.71238898038469), u6:NextNumber(-4.71238898038469, 4.71238898038469), u6:NextNumber(-4.71238898038469, 4.71238898038469));
                game.TweenService:Create(descendant, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    CFrame = descendant.CFrame * v9 * v10
                }):Play();
                game.TweenService:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Transparency = 1
                }):Play();
            end;
        end;

        EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
        task.delay(3, function() -- Line: 94
            -- upvalues: u8 (ref)
            u8:Destroy();
            u8 = nil;
        end);
    end);
end;