  

 

game:GetService("TweenService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = {};
local _ = PathShortcuts.ClientAssets.Assets.Abilities.Umbra.MAYHEM_Assets;

return function(p2) -- Line: 15
    -- upvalues: u1 (copy), Trove (copy), AssetHandler (copy), ParticleHandler (copy), PathShortcuts (copy)
    if u1[p2.Character] then
        u1[p2.Character]:Destroy();
    end;

    if p2.Remove then
        return;
    end;

    local HumanoidRootPart = p2.Character.HumanoidRootPart;
    local _ = p2.Character.Humanoid;
    local v3 = Trove.new();
    v3:AttachToInstance(p2.Character);
    u1[p2.Character] = v3;
    local v4 = AssetHandler.GetAsset(`Poses/{p2.Form}`, {
        AbilityName = "Umbra",
        SkinName = "MAYHEM_Assets"
    });
    local v5;

    if v4 then
        v5 = false;
    else
        v4 = AssetHandler.GetAsset("Poses/Universal", {
            AbilityName = "Umbra",
            SkinName = "MAYHEM_Assets"
        });
        v5 = true;
    end;

    local Aura = v4:FindFirstChild("Aura");

    if Aura then
        local u6 = Aura:Clone();
        u6.Parent = workspace.Effects;
        u6.Name = "MAYHEMAuraContainer";

        for _, child in u6:GetChildren() do
            local v7 = p2.Character:FindFirstChild(child.Name);

            if v7 then
                child.CFrame = v7.CFrame;
                ParticleHandler.AttachTo(child, {
                    Part = v7
                });

                if p2.Character:GetAttribute("ChromaUnusual") then
                    PathShortcuts.Remotes.ClientBind:Fire(p2.Character, "Chroma", child);
                end;
            else
                child:Destroy();
            end;
        end;

        v3:Add(function() -- Line: 67
            -- upvalues: ParticleHandler (ref), u6 (copy)
            task.delay(ParticleHandler.EnableAllParticles(u6, false), u6.Destroy, u6);
        end);
    end;

    local u8 = {};

    for _, child in v4:GetChildren() do
        if child:IsA("BasePart") then
            local v9 = child:Clone();
            v9.Parent = workspace.Effects;
            v9.CFrame = HumanoidRootPart.CFrame * (v9:GetAttribute("Offset") or CFrame.identity);
            ParticleHandler.AttachTo(v9, {
                Part = HumanoidRootPart,
                Offset = (v9:GetAttribute("Offset") or CFrame.identity):Inverse()
            }).Name = "WeldTo";
            table.insert(u8, v9);

            if p2.Character:GetAttribute("ChromaUnusual") then
                PathShortcuts.Remotes.ClientBind:Fire(p2.Character, "Chroma", v9);
            elseif not p2.Character:GetAttribute("ChromaUnusual") and v5 then
                ParticleHandler.Unusualify(v9, {
                    IncludeParts = true,
                    Character = p2.Character
                });
            end;

            for _, descendant in v9:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(1);
                end;
            end;
        end;
    end;

    if #u8 > 0 then
        v3:Add(function() -- Line: 98
            -- upvalues: u8 (copy), ParticleHandler (ref)
            for _, v in u8 do
                local WeldTo = v:FindFirstChild("WeldTo");

                if WeldTo then
                    WeldTo:Destroy();
                    v.Anchored = true;
                end;

                task.delay(ParticleHandler.EnableAllParticles(v, false), v.Destroy, v);
            end;
        end);
    end;

    local Callback = v4:FindFirstChild("Callback");

    if Callback then
        local v10 = require(Callback);
        xpcall(v10, function(p11) -- Line: 114
            warn(p11, "\n", debug.traceback());
        end, p2, v3);
    end;
end;