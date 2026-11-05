  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
local TagService = require(ReplicatedRoot.Services.TagService);

return {
    CreateTagSet = function(p1, p2) -- Line: 25, Name: CreateTagSet
        -- upvalues: TagService (copy)
        local u3 = TagService.GetContainer(p1);
        local u4 = {
            Tags = {}
        };

        function u4.Patch(p5, p6) -- Line: 33
            -- upvalues: u4 (copy), TagService (ref), u3 (copy)
            for i, v in pairs(p6) do
                local v7 = u4.Tags[i];

                if v7 == nil then
                    local v8 = TagService.CreateTag(u3, i, v);
                    u4.Tags[i] = v8;
                else
                    v7.Value = v;
                end;
            end;
        end;

        function u4.Clear(p9, p10) -- Line: 45
            -- upvalues: u4 (copy)
            for i, _ in pairs(p10) do
                local v11 = u4.Tags[i];

                if v11 ~= nil then
                    v11:Destroy();
                end;
            end;
        end;

        function u4.Wipe(p12) -- Line: 54
            -- upvalues: u4 (copy)
            for i, v in pairs(u4.Tags) do
                v:Destroy();
                u4.Tags[i] = nil;
            end;
        end;

        function u4.Destroy(p13) -- Line: 61
            -- upvalues: u4 (copy)
            u4:Wipe();
        end;

        u4:Patch(p2 or {});

        return u4;
    end
};