  

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local logger = require(script.mod.logger);
local utility = require(script.mod.utility);
local script_beam = require(script.beam);
local script_spin = require(script.spin);
local script_mesh = require(script.mesh);
local script_bezier = require(script.bezier);
local script_screen = require(script.screen);
local script_particle = require(script.particle);
local script_camera_shake = require(script.camera_shake);
local script_tween_property = require(script.tween_property);
local script_shockwave_ring = require(script.shockwave_ring);
local script_shockwave_line = require(script.shockwave_line);
local script_shockwave_debris = require(script.shockwave_debris);
local Promise = require(script.obj.Promise);
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
    -- upvalues: u3 (copy), u2 (copy), utility (copy), logger (copy), RunService (copy), u1 (copy), ObjectCache (copy), script_camera_shake (copy), script_bezier (copy), script_shockwave_ring (copy), script_shockwave_line (copy), script_shockwave_debris (copy), CollectionService (copy), script_mesh (copy), assembleMeshVFX (copy)
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
    script_camera_shake.init();
    script_bezier.init(u13);
    script_shockwave_ring.init(u13);
    script_shockwave_line.init(u13);
    script_shockwave_debris.init(u13);
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
        -- upvalues: utility (ref), u15 (copy), RunService (ref), CollectionService (ref), u16 (copy)
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

            if RunService:IsStudio() then
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
            -- upvalues: utility (ref), u23 (copy), u17 (copy), Start (copy), u15 (ref), RunService (ref), CollectionService (ref)
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

                if RunService:IsStudio() then
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

        if RunService:IsStudio() then
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
        -- upvalues: utility (ref), u34 (copy), addEnabledEffect (copy), u3 (ref), script_mesh (ref), assembleMeshVFX (ref), script_bezier (ref), RunService (ref)
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
            -- upvalues: utility (ref), u37 (copy), u3 (ref), u38 (copy), script_mesh (ref), assembleMeshVFX (ref), u39 (copy), script_bezier (ref), RunService (ref), u41 (copy)
            if not utility.getAttribute(u37, "Enabled", true) then
                utility.cleanupScope(u41);

                return;
            end;

            local u45 = 0;

            local function vfxFunc() -- Line: 472
                -- upvalues: utility (ref), u37 (ref), u45 (ref), u3 (ref), u38 (ref), script_mesh (ref), assembleMeshVFX (ref), u39 (ref), script_bezier (ref)
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

                local function cleanup() -- Line: 487
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
                        utility.try(`failed to emit mesh '{u37:GetFullName()}' with error: %s`, script_mesh.emit, u37, assembleMeshVFX(Start, u47), u47, 1, true);
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
                    utility.try(`failed to emit bezier '{u37:GetFullName()}' with error: %s`, script_bezier.emit, u37, v49, u47, true);
                end;

                local table_find_ret = table.find(u3.scope, cleanup);

                if table_find_ret then
                    table.remove(u3.scope, table_find_ret);
                end;

                utility.cleanupScope(u47);
            end;

            local v50;

            if RunService:IsClient() then
                v50 = RunService.RenderStepped:Connect(function() -- Line: 551
                    -- upvalues: vfxFunc (copy)
                    vfxFunc();
                end);
            else
                v50 = RunService.Heartbeat:Connect(function() -- Line: 556
                    -- upvalues: vfxFunc (copy)
                    vfxFunc();
                end);
            end;

            table.insert(u41, v50);
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
    table.insert(u3.scope, function() -- Line: 580
        -- upvalues: u34 (copy), utility (ref)
        for _, v in u34 do
            utility.cleanupScope(v);
        end;
    end);
end;

function u3.deinit() -- Line: 588
    -- upvalues: u3 (copy), RunService (copy), u1 (copy), utility (copy), script_bezier (copy), script_camera_shake (copy), script_shockwave_ring (copy), script_shockwave_line (copy), script_shockwave_debris (copy)
    if not u3.setup then
        return;
    end;

    u3.setup = false;
    shared.vfx = nil;

    if RunService:IsServer() and not u1 then
        return;
    end;

    utility.cleanupScope(u3.scope);
    script_bezier.deinit();
    script_camera_shake.deinit();
    script_shockwave_ring.deinit();
    script_shockwave_line.deinit();
    script_shockwave_debris.deinit();
end;

function u3.emit(p51, ...) -- Line: 610
    -- upvalues: u3 (copy), logger (copy), Promise (copy), utility (copy), script_particle (copy), script_beam (copy), script_bezier (copy), script_mesh (copy), assembleMeshVFX (copy), script_spin (copy), script_camera_shake (copy), script_tween_property (copy), script_shockwave_ring (copy), script_shockwave_debris (copy), script_shockwave_line (copy), script_screen (copy)
    if not u3.setup then
        logger.error("not initialized");
    end;

    local u52 = {};
    local u53 = {};
    local u54 = 1;

    local function emit(u55: userdata, u56: number) -- Line: 620
        -- upvalues: Promise (ref), utility (ref), u53 (copy), u52 (copy), script_particle (ref), u54 (ref), script_beam (ref), script_bezier (ref), script_mesh (ref), assembleMeshVFX (ref), script_spin (ref), script_camera_shake (ref), script_tween_property (ref), script_shockwave_ring (ref), script_shockwave_debris (ref), script_shockwave_line (ref)
        return Promise.new(function(p57) -- Line: 621
            -- upvalues: u56 (copy), u55 (copy), utility (ref), u53 (ref), u52 (ref), script_particle (ref), u54 (ref), script_beam (ref), script_bezier (ref), Promise (ref), script_mesh (ref), assembleMeshVFX (ref), script_spin (ref), script_camera_shake (ref), script_tween_property (ref), script_shockwave_ring (ref), script_shockwave_debris (ref), script_shockwave_line (ref)
            (function() -- Line: 622, Name: run
                -- upvalues: u56 (ref), u55 (ref), utility (ref), u53 (ref), u52 (ref), script_particle (ref), u54 (ref), script_beam (ref), script_bezier (ref), Promise (ref), script_mesh (ref), assembleMeshVFX (ref), script_spin (ref), script_camera_shake (ref), script_tween_property (ref), script_shockwave_ring (ref), script_shockwave_debris (ref), script_shockwave_line (ref)
                local u58 = {
                    depth = u56
                };

                if u55:IsA("ParticleEmitter") then
                    if u55:IsDescendantOf(workspace) then
                        utility.try(`failed to emit particle '{u55:GetFullName()}' with error: %s`, script_particle.emit, u55, u55, u58, u54);
                        utility.cleanupScope(u58);
                    else
                        local v59, v60 = utility.cloneParticleAncestry(u55, u53);

                        if not v59 then
                            return;
                        end;

                        table.insert(u58, v60);
                        local v61 = u55:Clone();
                        v61.Archivable = false;
                        v61.Parent = v59;

                        if not u52[v60] then
                            v60.Parent = workspace.Terrain;
                        end;

                        if u52[v60] then
                            local v62 = u52;
                            v62[v60] = v62[v60] + 1;
                        else
                            u52[v60] = 1;
                        end;

                        utility.try(`failed to emit particle '{u55:GetFullName()}' with error: %s`, script_particle.emit, u55, v61, u58, u54);
                        local v63 = u52;
                        v63[v60] = v63[v60] - 1;

                        if u52[v60] <= 0 then
                            utility.cleanupScope(u58);
                        end;
                    end;
                elseif u55:IsA("Beam") then
                    local v64 = u55:Clone();
                    v64.Archivable = false;
                    v64.Parent = workspace.Terrain;
                    table.insert(u58, v64);
                    utility.try(`failed to emit beam '{u55:GetFullName()}' with error: %s`, script_beam.emit, u55, v64, u58, u54);
                    utility.cleanupScope(u58);
                elseif u55:IsA("Trail") then
                    u55.Enabled = true;
                elseif u55:HasTag(utility.BEZIER_TAG) then
                    local v65 = u55:FindFirstChildOfClass("Part");

                    if not v65 then
                        return;
                    end;

                    if u55:GetAttribute("Enabled") then
                        u55:SetAttribute("Enabled", false);
                    end;

                    local v66 = v65:Clone();
                    v66.Locked = true;
                    table.insert(u58, v66);
                    utility.try(`failed to emit bezier '{u55:GetFullName()}' with error: %s`, script_bezier.emit, u55, v66, u58);
                    utility.cleanupScope(u58);
                elseif utility.isMeshVFX(u55) then
                    local Start = u55:FindFirstChild("Start");

                    if not Start then
                        return;
                    end;

                    if u55:GetAttribute("Enabled") then
                        u55:SetAttribute("Enabled", false);
                    end;

                    local v67 = {};

                    for i = 1, utility.getAttribute(u55, "EmitCount", 1) do
                        table.insert(v67, Promise.new(function(p68) -- Line: 728
                            -- upvalues: utility (ref), u55 (ref), script_mesh (ref), assembleMeshVFX (ref), Start (copy), u58 (copy), u54 (ref)
                            utility.try(`failed to emit mesh '{u55:GetFullName()}' with error: %s`, script_mesh.emit, u55, assembleMeshVFX(Start, u58), u58, u54);
                            p68();
                        end));
                        local _ = i;
                    end;

                    Promise.all(v67):await();
                    utility.cleanupScope(u58);
                elseif u55:IsA("Model") then
                    if utility.lock(u55) then
                        return;
                    end;

                    utility.try(`failed to emit spinning model '{u55:GetFullName()}' with error: %s`, script_spin.emit, u55, u58);
                    utility.cleanupScope(u58);
                    utility.unlock(u55);
                elseif u55:IsA("RayValue") then
                    if u55:HasTag(utility.SCREENSHAKE_TAG) then
                        utility.try(`failed to emit camera shake '{u55:GetFullName()}' with error: %s`, script_camera_shake.emit, u55, u58);
                        utility.cleanupScope(u58);
                    else
                        if not u55.Parent or utility.lock(u55) then
                            return;
                        end;

                        utility.try(`failed to emit tween property '{u55:GetFullName()}' with error: %s`, script_tween_property.emit, u55.Parent, u55, u58);
                        utility.unlock(u55);
                        utility.cleanupScope(u58);
                    end;
                end;

                local v69 = u55:IsA("Part") and utility.findFirstClassWithTag(u55, "Attachment", utility.SHOCKWAVE_TAG);

                if v69 then
                    local Name = u55.Parent.Name;

                    if Name == "Rings" then
                        utility.try(`failed to emit shockwave ring '{u55:GetFullName()}' with error: %s`, script_shockwave_ring.emit, v69, u55, u58);
                        utility.cleanupScope(u58);

                        return;
                    end;

                    if Name == "Debris" then
                        utility.try(`failed to emit shockwave debris '{u55:GetFullName()}' with error: %s`, script_shockwave_debris.emit, v69, u55, u58);
                        utility.cleanupScope(u58);

                        return;
                    end;

                    if Name == "Lines" then
                        utility.try(`failed to emit shockwave line '{u55:GetFullName()}' with error: %s`, script_shockwave_line.emit, v69, u55, u58);
                        utility.cleanupScope(u58);
                    end;
                end;
            end)();
            p57();
        end);
    end;

    local v70 = { ... };

    if typeof(p51) == "number" then
        u54 = p51;
    else
        table.insert(v70, p51);
    end;

    local u71 = {};

    local function emitAll(p72: number, p73: table, p74: table) -- Line: 841
        -- upvalues: utility (ref), script_screen (ref), emitAll (copy), u71 (copy), Promise (ref), emit (copy)
        for _, v in p73 do
            if v:IsA("BasePart") and (v:GetAttribute("Enabled") and not utility.findFirstClassWithTag(v, "Attachment", utility.SHOCKWAVE_TAG)) then
                if not utility.lock(v) then
                    local v75 = v:FindFirstAncestorOfClass("Model");
                    local u76, u77, v78, v79, v80;

                    if v75 then
                        local Attribute = utility.getAttribute(v75, "SpinRotation", Vector3.new(0, 0, 0), true);
                        local Attribute2 = utility.getAttribute(v75, "Scale_Start", 1, true);
                        local Attribute3 = utility.getAttribute(v75, "Scale_End", 1, true);

                        if Attribute == Vector3.new(0, 0, 0) and (Attribute2 == 1 and Attribute3 == 1) then
                            u76 = coroutine.running();
                            u77 = {
                                depth = p72
                            };

                            if utility.try(`failed to emit screen effect '{v:GetFullName()}' with error: %s`, script_screen.emit, v, u77) then
                                if #v:GetDescendants() == 0 then
                                    utility.cleanupScope(u77);

                                    return;
                                end;

                                v78 = {};
                                emitAll(p72 + 1, v:GetChildren(), v78);
                                v79 = u71;
                                v80 = Promise.all(v78);
                                table.insert(v79, v80:finally(function() -- Line: 886
                                    -- upvalues: utility (ref), v (copy), u76 (copy), u77 (copy)
                                    utility.unlock(v, u76);
                                    utility.cleanupScope(u77);
                                end));
                            end;
                        end;
                    else
                        u76 = coroutine.running();
                        u77 = {
                            depth = p72
                        };

                        if utility.try(`failed to emit screen effect '{v:GetFullName()}' with error: %s`, script_screen.emit, v, u77) then
                            if #v:GetDescendants() == 0 then
                                utility.cleanupScope(u77);

                                return;
                            end;

                            v78 = {};
                            emitAll(p72 + 1, v:GetChildren(), v78);
                            v79 = u71;
                            v80 = Promise.all(v78);
                            table.insert(v79, v80:finally(function() -- Line: 886
                                -- upvalues: utility (ref), v (copy), u76 (copy), u77 (copy)
                                utility.unlock(v, u76);
                                utility.cleanupScope(u77);
                            end));
                        end;
                    end;
                end;
            else
                table.insert(p74, emit(v, p72));

                if not (v:HasTag(utility.BEZIER_TAG) or (utility.isMeshVFX(v) or v:IsA("BasePart") and utility.findFirstClassWithTag(v, "Attachment", utility.SHOCKWAVE_TAG))) then
                    emitAll(p72 + 1, v:GetChildren(), p74);
                end;
            end;
        end;
    end;

    emitAll(0, v70, u71);

    return {
        Finished = Promise.all(u71)
    };
end;

return u3;