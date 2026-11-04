 

 

local CollectionService = game:GetService("CollectionService");
local u1 = require("../obj/ObjectCache");
require("../types");
local u2 = require("../mod/utility");

return {
    init = function(p3) -- Line: 10, Name: init
        -- upvalues: u2 (copy), u1 (copy), CollectionService (copy)
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
        u2.protectParent(p3, Part);
        local u5 = u1.new(Decal, Part, {
            size = 360,

            on_free = function(p4) -- Line: 28, Name: on_free
                p4.value.Texture = "";
            end
        });
        local u6 = {};

        local function loadTextures(u7: userdata) -- Line: 35
            -- upvalues: u2 (ref), u5 (copy), CollectionService (ref), u6 (copy)
            if u7:IsDescendantOf(workspace.Terrain) then
                return;
            end;

            if not u2.isMeshVFX(u7) then
                local v8 = {};
                local u9 = {};
                table.insert(v8, u9);

                local function refresh() -- Line: 110
                    -- upvalues: u2 (ref), u9 (copy), u5 (ref), u7 (copy)
                    u2.cleanupScope(u9);

                    local function check(p10: userdata) -- Line: 113
                        -- upvalues: u5 (ref), u9 (ref)
                        if not p10:IsA("ParticleEmitter") then
                            return;
                        end;

                        local Texture = p10.Texture;

                        if Texture == "" then
                            return;
                        end;

                        u5:get(Texture).Texture = Texture;
                        table.insert(u9, function() -- Line: 127
                            -- upvalues: u5 (ref), Texture (copy)
                            u5:free(Texture);
                        end);
                    end;

                    check(u7);

                    for _, descendant in u7:GetDescendants() do
                        check(descendant);
                    end;
                end;

                refresh();

                if u2.PLUGIN_CONTEXT then
                    local v11 = u2.reboundfn(1, refresh);
                    table.insert(v8, u7.DescendantAdded:Connect(v11));
                    table.insert(v8, u7.DescendantRemoving:Connect(v11));
                end;

                u6[u7] = v8;

                return;
            end;

            local Start = u7:FindFirstChild("Start");

            if not (Start and Start:IsA("BasePart")) then
                return;
            end;

            local v12 = {};
            local u13 = {};
            table.insert(v12, u13);

            local function v20() -- Line: 52
                -- upvalues: u2 (ref), u13 (copy), u7 (copy), Start (copy), u5 (ref), CollectionService (ref)
                u2.cleanupScope(u13);
                local MeshDecals, v14 = u2.getMeshDecals(u7, Start);

                local function add(u15) -- Line: 57
                    -- upvalues: u5 (ref), u13 (ref)
                    if typeof(u15) == "Instance" then
                        u15 = u15.Texture or u15;
                    end;

                    if u15 == "" then
                        return;
                    end;

                    u5:get(u15).Texture = u15;
                    table.insert(u13, function() -- Line: 67
                        -- upvalues: u5 (ref), u15 (copy)
                        u5:free(u15);
                    end);
                end;

                for _, v in MeshDecals do
                    local u16;

                    if typeof(v) == "Instance" then
                        u16 = v.Texture or v;
                    else
                        u16 = v;
                    end;

                    if u16 ~= "" then
                        u5:get(u16).Texture = u16;
                        table.insert(u13, function() -- Line: 67
                            -- upvalues: u5 (ref), u16 (copy)
                            u5:free(u16);
                        end);
                    end;
                end;

                for i, v in v14 do
                    local v17 = false;
                    local v18;

                    if u2.PLUGIN_CONTEXT then
                        v18 = v;

                        for _, v2 in CollectionService:GetTags(i) do
                            if v2:match("^_local_flipbook_") then
                                v17 = true;
                                break;
                            end;
                        end;
                    else
                        v18 = v;
                    end;

                    for _, v2 in v18 do
                        local u19 = `{v17 and "rbxtemp://" or "rbxassetid://"}{v2}`;

                        if typeof(u19) == "Instance" then
                            u19 = u19.Texture or u19;
                        end;

                        if u19 ~= "" then
                            u5:get(u19).Texture = u19;
                            table.insert(u13, function() -- Line: 67
                                -- upvalues: u5 (ref), u19 (copy)
                                u5:free(u19);
                            end);
                        end;
                    end;
                end;
            end;

            v20();

            if u2.PLUGIN_CONTEXT then
                local v21 = u2.reboundfn(1, v20);
                table.insert(v12, Start.DescendantAdded:Connect(v21));
                table.insert(v12, Start.DescendantRemoving:Connect(v21));
            end;

            u6[u7] = v12;
        end;

        for _, v in CollectionService:GetTagged(u2.TEXTURE_LOAD_TAG) do
            loadTextures(v);
        end;

        CollectionService:GetInstanceAddedSignal(u2.TEXTURE_LOAD_TAG):Connect(loadTextures);
        CollectionService:GetInstanceRemovedSignal(u2.TEXTURE_LOAD_TAG):Connect(function(p22) -- Line: 157
            -- upvalues: u6 (copy), u2 (ref)
            local v23 = u6[p22];

            if v23 then
                u2.cleanupScope(v23);
                u6[p22] = nil;
            end;
        end);
        table.insert(p3, function() -- Line: 166
            -- upvalues: u5 (copy), u6 (copy), u2 (ref)
            u5:destroy();

            for _, v in u6 do
                u2.cleanupScope(v);
            end;
        end);
    end
};