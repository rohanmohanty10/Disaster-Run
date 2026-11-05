  

 

local CollectionService = game:GetService("CollectionService");
local u1 = require("../obj/ObjectCache");
require("../types");
local u2 = require("../mod/utility");
local u3 = require("../mod/common/flipbook");

return {
    init = function(p4) -- Line: 11, Name: init
        -- upvalues: u2 (copy), u1 (copy), u3 (copy), CollectionService (copy)
        local Decal = Instance.new("Decal");
        local Part = Instance.new("Part");
        Part.Name = "DO_NOT_REMOVE_ForgeTextureCache";
        Part.Transparency = 1;
        Part.Size = Vector3.new(0, 0, 0);
        Part.Archivable = false;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.Locked = true;
        Part.Parent = workspace.Terrain;
        u2.protectParent(p4, Part);
        local u6 = u1.new(Decal, Part, {
            size = 360,

            on_free = function(p5) -- Line: 29, Name: on_free
                p5.value.Texture = "";
            end
        });
        local u7 = {};

        local function createLoader(p8, u9, p10) -- Line: 36
            -- upvalues: u2 (ref), u6 (copy), u7 (copy)
            local v11 = {};
            local u12 = {};
            table.insert(v11, u12);

            local function refresh() -- Line: 46
                -- upvalues: u2 (ref), u12 (copy), u6 (ref), u9 (copy)
                u2.cleanupScope(u12);
                u9(function(u13) -- Line: 49, Name: add
                    -- upvalues: u6 (ref), u12 (ref)
                    if u13 == "" then
                        return;
                    end;

                    u6:get(u13).Texture = u13;
                    table.insert(u12, function() -- Line: 57
                        -- upvalues: u6 (ref), u13 (copy)
                        u6:free(u13);
                    end);
                end);
            end;

            u2.cleanupScope(u12);
            u9(function(u14) -- Line: 49, Name: add
                -- upvalues: u6 (ref), u12 (copy)
                if u14 == "" then
                    return;
                end;

                u6:get(u14).Texture = u14;
                table.insert(u12, function() -- Line: 57
                    -- upvalues: u6 (ref), u14 (copy)
                    u6:free(u14);
                end);
            end);

            if u2.PLUGIN_CONTEXT and p10 then
                for _, v in p10((u2.reboundfn(1, refresh))) do
                    table.insert(v11, v);
                end;
            end;

            u7[p8] = v11;
        end;

        local function loadTextures(u15) -- Line: 78
            -- upvalues: u2 (ref), createLoader (copy), u3 (ref)
            if u15:IsDescendantOf(workspace.Terrain) then
                return;
            end;

            if not u2.isMeshVFX(u15) then
                if u15:IsA("Beam") then
                    createLoader(u15, function(p16) -- Line: 111
                        -- upvalues: u15 (copy), u3 (ref)
                        p16(u15.Texture);
                        local v17 = u3.getFlipbookData(u15);

                        if v17 then
                            local v18 = u3.getTexturePrefix(u15);

                            for _, v in v17 do
                                p16((`{v18}{v}`));
                            end;
                        end;
                    end, function(p19) -- Line: 123
                        -- upvalues: u15 (copy)
                        return { u15:GetPropertyChangedSignal("Texture"):Connect(p19), u15.AttributeChanged:Connect(p19) };
                    end);

                    return;
                end;

                createLoader(u15, function(u20) -- Line: 130
                    -- upvalues: u15 (copy)
                    local function check(p21) -- Line: 131
                        -- upvalues: u20 (copy)
                        if p21:IsA("ParticleEmitter") then
                            u20(p21.Texture);
                        end;
                    end;

                    local v22 = u15;

                    if v22:IsA("ParticleEmitter") then
                        u20(v22.Texture);
                    end;

                    for _, descendant in u15:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            u20(descendant.Texture);
                        end;
                    end;
                end, function(p23) -- Line: 142
                    -- upvalues: u15 (copy)
                    return { u15.DescendantAdded:Connect(p23), u15.DescendantRemoving:Connect(p23) };
                end);

                return;
            end;

            local Start = u15:FindFirstChild("Start");

            if not (Start and Start:IsA("BasePart")) then
                return;
            end;

            createLoader(u15, function(p24) -- Line: 90
                -- upvalues: u2 (ref), u15 (copy), Start (copy), u3 (ref)
                local v25, v26 = u2.getMeshDecals(u15, Start);

                for _, v in v25 do
                    if typeof(v) ~= "string" then
                        local v = v.Texture or v;
                    end;

                    p24(v);
                end;

                for _, v in v26 do
                    local v27 = u3.getTexturePrefix(u15);

                    for _, v2 in v do
                        p24((`{v27}{v2}`));
                    end;
                end;
            end, function(p28) -- Line: 104
                -- upvalues: Start (copy)
                return { Start.DescendantAdded:Connect(p28), Start.DescendantRemoving:Connect(p28) };
            end);
        end;

        for _, v in CollectionService:GetTagged(u2.TEXTURE_LOAD_TAG) do
            loadTextures(v);
        end;

        CollectionService:GetInstanceAddedSignal(u2.TEXTURE_LOAD_TAG):Connect(loadTextures);
        CollectionService:GetInstanceRemovedSignal(u2.TEXTURE_LOAD_TAG):Connect(function(p29) -- Line: 156
            -- upvalues: u7 (copy), u2 (ref)
            local v30 = u7[p29];

            if v30 then
                u2.cleanupScope(v30);
                u7[p29] = nil;
            end;
        end);
        table.insert(p4, function() -- Line: 165
            -- upvalues: u6 (copy), u7 (copy), u2 (ref)
            u6:destroy();

            for _, v in u7 do
                u2.cleanupScope(v);
            end;
        end);
    end
};