  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedRoot = ReplicatedStorage.ReplicatedRoot;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local CombatService = require(ReplicatedRoot.Services.CombatService);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local Petal = _G.Petal;
local u2 = Petal("Util");
Petal("New");
local v3 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local Rng = v3.Rng;

local function debugprint(...) -- Line: 39
    -- upvalues: RunService (copy)
    if RunService:IsStudio() then
        print(...);
    end;
end;

local u4 = {};

local function CreateEntry(u5) -- Line: 49
    -- upvalues: u4 (copy), Trove (copy), debugprint (copy)
    if u5 and u5.Parent then
        if u4[u5] then
            return u4[u5];
        end;

        local u6 = {
            Trove = Trove.new()
        };
        u6.Trove:AttachToInstance(u5);
        u6.Targets = {};
        u6.Looping = false;

        function u6.Destroy(p7) -- Line: 59
            -- upvalues: u6 (copy), u4 (ref), u5 (copy), debugprint (ref)
            if u6.Trove then
                u6.Trove:Destroy();
            end;

            if u4[u5] and u4[u5] == u6 then
                table.clear(u6);
                table.freeze(u6);
                u4[u5] = nil;
                debugprint("Destroyed cache entry");
            end;
        end;

        u4[u5] = u6;

        return u6;
    end;
end;

return function(p8, p9) -- Line: 74
    -- upvalues: u4 (copy), AssetHandler (copy), CreateEntry (copy), ParticleHandler (copy), u2 (copy), EffectsHandler (copy), CombatService (copy), Rng (copy), debugprint (copy)
    if typeof(p9) == "boolean" and p9 == false then
        if u4[p8] then
            u4[p8]:Destroy();
        end;

        return;
    end;

    if not p8 then
        warn("No character");

        return;
    end;

    debug.setmemorycategory("Delta Triangulation Effect");
    local v10 = p8:GetAttribute("IsTetherActive") and "Particles/Tether/Tether" or "Particles/Triangulation/Triangulation";
    local v11 = AssetHandler.GetAsset(`{v10}Beam`, AssetHandler.GetAbilityData(p8));
    local v12 = CreateEntry(p8);
    local Targets = v12.Targets;
    local v13 = {};
    local v14 = {};

    for i = 1, #p9.Targets do
        v13[p9.Targets[i]] = true;
    end;

    for i, v in Targets do
        if not v13[i] then
            v:Destroy();
            table.clear(v);
        end;
    end;

    for i in v13 do
        if Targets[i] then
            v14[i] = Targets[i];
        else
            local u15 = v11.Attachment:Clone();
            u15.Parent = p8:FindFirstChild("HumanoidRootPart");
            u15.Position = Vector3.new(0, 1, 0);
            ParticleHandler.Unusualify(u15, {
                Player = p8,
                Character = p8
            });
            local u16 = AssetHandler.CloneAsset(`{v10}Attach/Attach`, AssetHandler.GetAbilityData(p8));
            u16.Parent = i:FindFirstChild("HumanoidRootPart");
            ParticleHandler.Unusualify(u16, {
                Player = p8,
                Character = p8
            });

            for _, child in u15:GetChildren() do
                if child:IsA("Beam") then
                    local Width0 = child.Width0;
                    local Width1 = child.Width1;
                    child.Attachment1 = u16;
                    child.Width0 = 0;
                    child.Width1 = 0;
                    child.Enabled = true;
                    u2.Tween(child, 0.5, "Quart", "Out", {
                        Width0 = Width0,
                        Width1 = Width1
                    });
                end;
            end;

            local function Destroy() -- Line: 138
                -- upvalues: u15 (copy), u2 (ref), ParticleHandler (ref), u16 (copy)
                for _, child in u15:GetChildren() do
                    if child:IsA("Beam") then
                        u2.Tween(child, 0.275, "Quad", "In", {
                            Width0 = 0,
                            Width1 = 0
                        });
                    end;
                end;

                task.spawn(function() -- Line: 145
                    -- upvalues: ParticleHandler (ref), u16 (ref)
                    ParticleHandler.EnableAllParticles(u16, false);
                    ParticleHandler.ScaleLifetime(u16, 2);
                end);
                task.delay(1, function() -- Line: 150
                    -- upvalues: u15 (ref), u16 (ref)
                    u15:Destroy();
                    u16:Destroy();
                end);
            end;

            v12.Trove:Add(Destroy);
            v14[i] = {
                Destroy = Destroy
            };
            EffectsHandler.CallEffect("Play Sound At", {
                Object = CombatService.FetchSound(p8, "Triangulation Added"),
                Origin = i:GetPivot(),
                PlaybackSpeed = Rng(1.1, 1.2)
            });
        end;
    end;

    v12.Targets = v14;
    table.clear(v13);

    if not v12.Looping then
        v12.Looping = true;
        CombatService.SoftPlaySound(p8, "Triangulation Ambience", 0.35);

        while not table.isfrozen(v12) do
            task.wait(0.5);
        end;

        debugprint("Ended");
        CombatService.SoftStopSound(p8, "Triangulation Ambience", 0.35);
    end;
end;