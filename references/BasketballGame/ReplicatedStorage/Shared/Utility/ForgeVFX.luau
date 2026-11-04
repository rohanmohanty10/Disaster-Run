 
 

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local logger = require(script.mod.logger);
local utility = require(script.mod.utility);
local beam = require(script.effects.beam);
local spin = require(script.effects.spin);
local mesh = require(script.effects.mesh);
local bezier = require(script.effects.bezier);
local screen = require(script.effects.screen);
local particle = require(script.effects.particle);
local camera_shake = require(script.effects.camera_shake);
local tween_property = require(script.effects.tween_property);
local shockwave_ring = require(script.effects.shockwave_ring);
local shockwave_line = require(script.effects.shockwave_line);
local shockwave_debris = require(script.effects.shockwave_debris);
local Promise = require(script.pkg.Promise);
local ObjectCache = require(script.obj.ObjectCache);
local u1 = script:FindFirstAncestorOfClass("Plugin");
local u2 = RunService:IsServer() or u1;
local u3 = {
    scope = {},
    setup = false
};

local function assembleMeshVFX(p4: userdata, p5: table) -- Line: 116
    -- upvalues: u3 (copy), logger (copy), utility (copy)
    if not u3.setup then
        logger.error("API not initialized");
    end;

    local RanomId = utility.getRanomId();

    if not p4:IsA("Part") then
        local v6 = p4:Clone();
        v6.Archivable = false;
        v6.Locked = true;
        v6.Parent = workspace.Terrain;
        table.insert(p5, v6);

        return v6;
    end;

    local v7 = u3.caches.shared_part:get(RanomId);
    v7.CFrame = p4.CFrame;
    local v8 = v7._getReal();
    utility.copyProperties(p4, v8, utility.COPY_PART_PROPERTIES);
    utility.copyProperties(p4, v8, utility.COPY_EXTENDED_PART_PROPERTIES);
    local v9 = p4:Clone();

    for _, child in v9:GetChildren() do
        child.Parent = v8;
    end;

    v9:Destroy();
    table.insert(p5, function() -- Line: 140
        -- upvalues: u3 (ref), RanomId (copy)
        u3.caches.shared_part:free(RanomId);
    end);

    return v7;
end;

function u3.init(p10: table?) -- Line: 157
    -- upvalues: u3 (copy), u2 (copy), utility (copy), logger (copy), RunService (copy), u1 (copy), ObjectCache (copy), camera_shake (copy), bezier (copy), shockwave_ring (copy), shockwave_line (copy), shockwave_debris (copy), CollectionService (copy), mesh (copy), assembleMeshVFX (copy)
    if u3.setup then
        return;
    end;

    if u2 then
        task.spawn(function() -- Line: 163
            -- upvalues: utility (ref), logger (ref)
            local v11 = 0;

            while true do
                v11 = v11 + 1;
                local success, result = pcall(utility.setCollisionGroups, utility.COLLISION_GROUPS);

                if not success then
                    task.wait(v11);
                end;

                if success or v11 >= 5 then
                    if not success then
                        logger.warn((`couldn't register necessary collision groups after {v11} tries with the last error being: {result}`));
                    end;

                    return;
                end;
            end;
        end);
    end;

    u3.setup = true;

    if RunService:IsServer() and not u1 then
        return;
    end;

    shared.vfx = u3;
    local Part = Instance.new("Part");
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Locked = true;
    local Folder = Instance.new("Folder");
    Folder.Name = "DO_NOT_REMOVE_ForgeSharedPartCache";
    Folder.Archivable = false;
    Folder.Parent = workspace.Terrain;
    utility.protectParent(u3.scope, Folder);
    local u13 = ObjectCache.new(Part, Folder, {
        size = 150,

        on_free = function(p12) -- Line: 217, Name: on_free
            local value = p12.value;
            value.Transparency = 1;
            value.Anchored = true;
            value.CanQuery = false;
            value.CanCollide = false;
            value.CollisionGroup = "ForgeMouseIgnore";
            value.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            value.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
            value:ClearAllChildren();
        end
    });
    u3.caches = {
        shared_part = u13
    };
    table.insert(u3.scope, function() -- Line: 243
        -- upvalues: u13 (ref)
        u13:destroy();
    end);
    camera_shake.init();
    bezier.init(u13);
    shockwave_ring.init(u13);
    shockwave_line.init(u13);
    shockwave_debris.init(u13);
    local Decal = Instance.new("Decal");
    local Part2 = Instance.new("Part");
    Part2.Name = "DO_NOT_REMOVE_ForgeTextureCache";
    Part2.Transparency = 1;
    Part2.Size = Vector3.new(0, 0, 0);
    Part2.Archivable = false;
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.CanQuery = false;
    Part2.Locked = true;
    Part2.Parent = workspace.Terrain;
    utility.protectParent(u3.scope, Part2);
    local u15 = ObjectCache.new(Decal, Part2, {
        size = 360,

        on_free = function(p14) -- Line: 272, Name: on_free
            p14.value.Texture = "";
        end
    });
    local u16 = {};

    local function loadTextures(u17: userdata) -- Line: 279
        -- upvalues: utility (ref), u15 (copy), u1 (ref), CollectionService (ref), u16 (copy)
        if u17:IsDescendantOf(workspace.Terrain) then
            return;
        end;

        if not utility.isMeshVFX(u17) then
            local v18 = {};
            local u19 = {};
            table.insert(v18, u19);

            local function refresh() -- Line: 354
                -- upvalues: utility (ref), u19 (copy), u15 (ref), u17 (copy)
                utility.cleanupScope(u19);

                local function check(p20: userdata) -- Line: 357
                    -- upvalues: u15 (ref), u19 (ref)
                    if not p20:IsA("ParticleEmitter") then
                        return;
                    end;

                    local Texture = p20.Texture;

                    if Texture == "" then
                        return;
                    end;

                    u15:get(Texture).Texture = Texture;
                    table.insert(u19, function() -- Line: 371
                        -- upvalues: u15 (ref), Texture (copy)
                        u15:free(Texture);
                    end);
                end;

                check(u17);

                for _, descendant in u17:GetDescendants() do
                    check(descendant);
                end;
            end;

            refresh();

            if u1 then
                local v21 = utility.reboundfn(1, refresh);
                table.insert(v18, u17.DescendantAdded:Connect(v21));
                table.insert(v18, u17.DescendantRemoving:Connect(v21));
            end;

            u16[u17] = v18;

            return;
        end;

        local Start = u17:FindFirstChild("Start");

        if not (Start and Start:IsA("BasePart")) then
            return;
        end;

        local v22 = {};
        local u23 = {};
        table.insert(v22, u23);

        local function v30() -- Line: 296
            -- upvalues: utility (ref), u23 (copy), u17 (copy), Start (copy), u15 (ref), u1 (ref), CollectionService (ref)
            utility.cleanupScope(u23);
            local MeshDecals, v24 = utility.getMeshDecals(u17, Start);

            local function add(u25) -- Line: 301
                -- upvalues: u15 (ref), u23 (ref)
                if typeof(u25) == "Instance" then
                    u25 = u25.Texture or u25;
                end;

                if u25 == "" then
                    return;
                end;

                u15:get(u25).Texture = u25;
                table.insert(u23, function() -- Line: 311
                    -- upvalues: u15 (ref), u25 (copy)
                    u15:free(u25);
                end);
            end;

            for _, v in MeshDecals do
                local u26;

                if typeof(v) == "Instance" then
                    u26 = v.Texture or v;
                else
                    u26 = v;
                end;

                if u26 ~= "" then
                    u15:get(u26).Texture = u26;
                    table.insert(u23, function() -- Line: 311
                        -- upvalues: u15 (ref), u26 (copy)
                        u15:free(u26);
                    end);
                end;
            end;

            for i, v in v24 do
                local v27 = false;
                local v28;

                if u1 then
                    v28 = v;

                    for _, v2 in CollectionService:GetTags(i) do
                        if v2:match("^_local_flipbook_") then
                            v27 = true;
                            break;
                        end;
                    end;
                else
                    v28 = v;
                end;

                for _, v2 in v28 do
                    local u29 = `{v27 and "rbxtemp://" or "rbxassetid://"}{v2}`;

                    if typeof(u29) == "Instance" then
                        u29 = u29.Texture or u29;
                    end;

                    if u29 ~= "" then
                        u15:get(u29).Texture = u29;
                        table.insert(u23, function() -- Line: 311
                            -- upvalues: u15 (ref), u29 (copy)
                            u15:free(u29);
                        end);
                    end;
                end;
            end;
        end;

        v30();

        if u1 then
            local v31 = utility.reboundfn(1, v30);
            table.insert(v22, Start.DescendantAdded:Connect(v31));
            table.insert(v22, Start.DescendantRemoving:Connect(v31));
        end;

        u16[u17] = v22;
    end;

    for _, v in CollectionService:GetTagged(utility.TEXTURE_LOAD_TAG) do
        loadTextures(v);
    end;

    CollectionService:GetInstanceAddedSignal(utility.TEXTURE_LOAD_TAG):Connect(loadTextures);
    CollectionService:GetInstanceRemovedSignal(utility.TEXTURE_LOAD_TAG):Connect(function(p32) -- Line: 401
        -- upvalues: u16 (copy), utility (ref)
        local v33 = u16[p32];

        if v33 then
            utility.cleanupScope(v33);
            u16[p32] = nil;
        end;
    end);
    table.insert(u3.scope, function() -- Line: 410
        -- upvalues: u15 (copy), u16 (copy), utility (ref)
        u15:destroy();

        for _, v in u16 do
            utility.cleanupScope(v);
        end;
    end);
    local u34 = {};

    local function removeEnabledEffect(p35: userdata) -- Line: 422
        -- upvalues: u34 (copy), utility (ref)
        local v36 = u34[p35];

        if v36 then
            utility.cleanupScope(v36);
        end;

        u34[p35] = nil;
    end;

    local function addEnabledEffect(u37: userdata) -- Line: 432
        -- upvalues: utility (ref), u34 (copy), addEnabledEffect (copy), RunService (ref), u3 (ref), mesh (ref), assembleMeshVFX (ref), bezier (ref)
        local u38 = utility.isMeshVFX(u37);
        local u39 = u37:HasTag(utility.BEZIER_TAG);

        if not (u38 or u39) then
            return;
        end;

        local v40 = {};
        local u41 = {};
        table.insert(v40, u41);
        u34[u37] = v40;
        table.insert(v40, u37.AncestryChanged:Connect(function() -- Line: 449
            -- upvalues: u37 (copy), u34 (ref), addEnabledEffect (ref), utility (ref)
            if u37:IsDescendantOf(workspace) or u37.Parent and u37.Parent:HasTag("AllowEmitting") then
                if not u34[u37] then
                    addEnabledEffect(u37);
                end;
            else
                local v42 = u37;
                local v43 = u34[v42];

                if v43 then
                    utility.cleanupScope(v43);
                end;

                u34[v42] = nil;
            end;
        end));

        if not u37:IsDescendantOf(workspace) then
            local v44;

            if u37.Parent then
                v44 = not u37.Parent:HasTag("AllowEmitting");
            else
                v44 = false;
            end;

            if v44 then
                return;
            end;
        end;

        local function onEnabled() -- Line: 466
            -- upvalues: utility (ref), u37 (copy), u41 (copy), RunService (ref), u3 (ref), u38 (copy), mesh (ref), assembleMeshVFX (ref), u39 (copy), bezier (ref)
            if not utility.getAttribute(u37, "Enabled", true) then
                utility.cleanupScope(u41);

                return;
            end;

            local u45 = 0;
            table.insert(u41, RunService.RenderStepped:Connect(function() -- Line: 474
                -- upvalues: utility (ref), u37 (ref), u45 (ref), u3 (ref), u38 (ref), mesh (ref), assembleMeshVFX (ref), u39 (ref), bezier (ref)
                local Attribute = utility.getAttribute(u37, "Rate", 5);
                local v46 = u37:GetAttribute("SpeedOverride") or 1;

                if v46 == 0 then
                    return;
                end;

                if os.clock() - u45 <= 1 / Attribute / v46 then
                    return;
                end;

                local u47 = {
                    depth = 0
                };

                local function cleanup() -- Line: 489
                    -- upvalues: utility (ref), u47 (copy)
                    utility.cleanupScope(u47);
                end;

                table.insert(u3.scope, cleanup);

                if u38 then
                    local Start = u37:FindFirstChild("Start");

                    if not Start then
                        u37:RemoveTag(utility.ENABLED_VFX_TAG);

                        return;
                    end;

                    u45 = os.clock();

                    for i = 1, utility.getAttribute(u37, "EmitCount", 1) do
                        utility.try(`failed to emit mesh '{u37:GetFullName()}' with error: %s`, mesh.emit, u37, assembleMeshVFX(Start, u47), u47, 1, true);
                        local _ = i;
                    end;
                elseif u39 then
                    local v48 = u37:FindFirstChildOfClass("Part");

                    if not v48 then
                        return;
                    end;

                    u45 = os.clock();
                    local v49 = v48:Clone();
                    v49.Locked = true;
                    table.insert(u47, v49);
                    utility.try(`failed to emit bezier '{u37:GetFullName()}' with error: %s`, bezier.emit, u37, v49, u47, true);
                end;

                local table_find_ret = table.find(u3.scope, cleanup);

                if table_find_ret then
                    table.remove(u3.scope, table_find_ret);
                end;

                utility.cleanupScope(u47);
            end));
        end;

        local AttributeChangedSignal = u37:GetAttributeChangedSignal("Enabled");
        table.insert(v40, AttributeChangedSignal:Connect(onEnabled));
        onEnabled();
    end;

    for _, v in CollectionService:GetTagged(utility.ENABLED_VFX_TAG) do
        addEnabledEffect(v);
    end;

    CollectionService:GetInstanceAddedSignal(utility.ENABLED_VFX_TAG):Connect(addEnabledEffect);
    CollectionService:GetInstanceRemovedSignal(utility.ENABLED_VFX_TAG):Connect(removeEnabledEffect);
    table.insert(u3.scope, function() -- Line: 566
        -- upvalues: u34 (copy), utility (ref)
        for _, v in u34 do
            utility.cleanupScope(v);
        end;
    end);
end;

function u3.deinit() -- Line: 574
    -- upvalues: u3 (copy), RunService (copy), u1 (copy), utility (copy), bezier (copy), camera_shake (copy), shockwave_ring (copy), shockwave_line (copy), shockwave_debris (copy)
    if not u3.setup then
        return;
    end;

    u3.setup = false;
    shared.vfx = nil;

    if RunService:IsServer() and not u1 then
        return;
    end;

    utility.cleanupScope(u3.scope);
    bezier.deinit();
    camera_shake.deinit();
    shockwave_ring.deinit();
    shockwave_line.deinit();
    shockwave_debris.deinit();
end;

function u3.emit(p50, ...) -- Line: 596
    -- upvalues: u3 (copy), logger (copy), Promise (copy), utility (copy), particle (copy), beam (copy), bezier (copy), mesh (copy), assembleMeshVFX (copy), spin (copy), camera_shake (copy), tween_property (copy), shockwave_ring (copy), shockwave_debris (copy), shockwave_line (copy), screen (copy)
    if not u3.setup then
        logger.error("not initialized");
    end;

    local u51 = {};
    local u52 = {};
    local u53 = 1;

    local function emit(u54: userdata, u55: number) -- Line: 606
        -- upvalues: Promise (ref), utility (ref), u52 (copy), u51 (copy), particle (ref), u53 (ref), beam (ref), bezier (ref), mesh (ref), assembleMeshVFX (ref), spin (ref), camera_shake (ref), tween_property (ref), shockwave_ring (ref), shockwave_debris (ref), shockwave_line (ref)
        return Promise.new(function(p56) -- Line: 607
            -- upvalues: u55 (copy), u54 (copy), utility (ref), u52 (ref), u51 (ref), particle (ref), u53 (ref), beam (ref), bezier (ref), Promise (ref), mesh (ref), assembleMeshVFX (ref), spin (ref), camera_shake (ref), tween_property (ref), shockwave_ring (ref), shockwave_debris (ref), shockwave_line (ref)
            (function() -- Line: 608, Name: run
                -- upvalues: u55 (ref), u54 (ref), utility (ref), u52 (ref), u51 (ref), particle (ref), u53 (ref), beam (ref), bezier (ref), Promise (ref), mesh (ref), assembleMeshVFX (ref), spin (ref), camera_shake (ref), tween_property (ref), shockwave_ring (ref), shockwave_debris (ref), shockwave_line (ref)
                local u57 = {
                    depth = u55
                };

                if u54:IsA("ParticleEmitter") then
                    if u54:IsDescendantOf(workspace) then
                        utility.try(`failed to emit particle '{u54:GetFullName()}' with error: %s`, particle.emit, u54, u54, u57, u53);
                        utility.cleanupScope(u57);
                    else
                        local v58, v59 = utility.cloneParticleAncestry(u54, u52);

                        if not v58 then
                            return;
                        end;

                        table.insert(u57, v59);
                        local v60 = u54:Clone();
                        v60.Archivable = false;
                        v60.Parent = v58;

                        if not u51[v59] then
                            v59.Parent = workspace.Terrain;
                        end;

                        if u51[v59] then
                            local v61 = u51;
                            v61[v59] = v61[v59] + 1;
                        else
                            u51[v59] = 1;
                        end;

                        utility.try(`failed to emit particle '{u54:GetFullName()}' with error: %s`, particle.emit, u54, v60, u57, u53);
                        local v62 = u51;
                        v62[v59] = v62[v59] - 1;

                        if u51[v59] <= 0 then
                            utility.cleanupScope(u57);
                        end;
                    end;
                elseif u54:IsA("Beam") then
                    local v63 = u54:Clone();
                    v63.Archivable = false;
                    v63.Parent = workspace.Terrain;
                    table.insert(u57, v63);
                    utility.try(`failed to emit beam '{u54:GetFullName()}' with error: %s`, beam.emit, u54, v63, u57, u53);
                    utility.cleanupScope(u57);
                elseif u54:IsA("Trail") then
                    u54.Enabled = true;
                elseif u54:HasTag(utility.BEZIER_TAG) then
                    local v64 = u54:FindFirstChildOfClass("Part");

                    if not v64 then
                        return;
                    end;

                    if u54:GetAttribute("Enabled") then
                        u54:SetAttribute("Enabled", false);
                    end;

                    local v65 = v64:Clone();
                    v65.Locked = true;
                    table.insert(u57, v65);
                    utility.try(`failed to emit bezier '{u54:GetFullName()}' with error: %s`, bezier.emit, u54, v65, u57);
                    utility.cleanupScope(u57);
                elseif utility.isMeshVFX(u54) then
                    local Start = u54:FindFirstChild("Start");

                    if not Start then
                        return;
                    end;

                    if u54:GetAttribute("Enabled") then
                        u54:SetAttribute("Enabled", false);
                    end;

                    local v66 = {};

                    for i = 1, utility.getAttribute(u54, "EmitCount", 1) do
                        table.insert(v66, Promise.new(function(p67) -- Line: 714
                            -- upvalues: utility (ref), u54 (ref), mesh (ref), assembleMeshVFX (ref), Start (copy), u57 (copy), u53 (ref)
                            utility.try(`failed to emit mesh '{u54:GetFullName()}' with error: %s`, mesh.emit, u54, assembleMeshVFX(Start, u57), u57, u53);
                            p67();
                        end));
                        local _ = i;
                    end;

                    Promise.all(v66):await();
                    utility.cleanupScope(u57);
                elseif u54:IsA("Model") then
                    if utility.lock(u54) then
                        return;
                    end;

                    utility.try(`failed to emit spinning model '{u54:GetFullName()}' with error: %s`, spin.emit, u54, u57);
                    utility.cleanupScope(u57);
                    utility.unlock(u54);
                elseif u54:IsA("RayValue") then
                    if u54:HasTag(utility.SCREENSHAKE_TAG) then
                        utility.try(`failed to emit camera shake '{u54:GetFullName()}' with error: %s`, camera_shake.emit, u54, u57);
                        utility.cleanupScope(u57);
                    else
                        if not u54.Parent or utility.lock(u54) then
                            return;
                        end;

                        utility.try(`failed to emit tween property '{u54:GetFullName()}' with error: %s`, tween_property.emit, u54.Parent, u54, u57);
                        utility.unlock(u54);
                        utility.cleanupScope(u57);
                    end;
                end;

                local v68 = u54:IsA("Part") and utility.findFirstClassWithTag(u54, "Attachment", utility.SHOCKWAVE_TAG);

                if v68 then
                    local Name = u54.Parent.Name;

                    if Name == "Rings" then
                        utility.try(`failed to emit shockwave ring '{u54:GetFullName()}' with error: %s`, shockwave_ring.emit, v68, u54, u57);
                        utility.cleanupScope(u57);

                        return;
                    end;

                    if Name == "Debris" then
                        utility.try(`failed to emit shockwave debris '{u54:GetFullName()}' with error: %s`, shockwave_debris.emit, v68, u54, u57);
                        utility.cleanupScope(u57);

                        return;
                    end;

                    if Name == "Lines" then
                        utility.try(`failed to emit shockwave line '{u54:GetFullName()}' with error: %s`, shockwave_line.emit, v68, u54, u57);
                        utility.cleanupScope(u57);
                    end;
                end;
            end)();
            p56();
        end);
    end;

    local v69 = { ... };

    if typeof(p50) == "number" then
        u53 = p50;
    else
        table.insert(v69, p50);
    end;

    local u70 = {};

    local function emitAll(p71: number, p72: table, p73: table) -- Line: 827
        -- upvalues: utility (ref), screen (ref), emitAll (copy), u70 (copy), Promise (ref), emit (copy)
        for _, v in p72 do
            if v:IsA("BasePart") and (v:GetAttribute("Enabled") and not utility.findFirstClassWithTag(v, "Attachment", utility.SHOCKWAVE_TAG)) then
                if not utility.lock(v) then
                    local v74 = v:FindFirstAncestorOfClass("Model");

                    if not (v74 and (v74:GetAttribute("SpinRotation") ~= Vector3.new(0, 0, 0) or (v74:GetAttribute("Scale_Start") ~= 1 or v74:GetAttribute("Scale_End") ~= 1))) then
                        local coroutine_running_ret = coroutine.running();
                        local u75 = {
                            depth = p71
                        };

                        if utility.try(`failed to emit screen effect '{v:GetFullName()}' with error: %s`, screen.emit, v, u75) then
                            if #v:GetDescendants() == 0 then
                                utility.cleanupScope(u75);

                                return;
                            end;

                            local v76 = {};
                            emitAll(p71 + 1, v:GetChildren(), v76);
                            local v77 = Promise.all(v76);
                            table.insert(u70, v77:finally(function() -- Line: 873
                                -- upvalues: utility (ref), v (copy), coroutine_running_ret (copy), u75 (copy)
                                utility.unlock(v, coroutine_running_ret);
                                utility.cleanupScope(u75);
                            end));
                        end;
                    end;
                end;
            else
                table.insert(p73, emit(v, p71));

                if not (v:HasTag(utility.BEZIER_TAG) or (utility.isMeshVFX(v) or v:IsA("BasePart") and utility.findFirstClassWithTag(v, "Attachment", utility.SHOCKWAVE_TAG))) then
                    emitAll(p71 + 1, v:GetChildren(), p73);
                end;
            end;
        end;
    end;

    emitAll(0, v69, u70);

    return {
        Finished = Promise.all(u70)
    };
end;

return u3;