 
 

local Pool = require(script.Parent.Pool);

return {
    walk = function(u1, p2, u3, u4, u5, u6) -- Line: 17, Name: walk
        -- upvalues: Pool (copy)
        local u7 = Pool._cloneMaps and Pool._cloneMaps[u3];

        local function visit(p8) -- Line: 19
            -- upvalues: u6 (copy), u5 (copy), u4 (copy), u7 (copy), u1 (copy), u3 (copy), visit (copy)
            if not p8:GetAttribute("Transformed") then
                for _, child in p8:GetChildren() do
                    visit(child);
                end;

                return;
            end;

            if u6 then
                u6(p8);
            end;

            local v9 = {};

            if u5 then
                v9.ChainCtx = u5.ChainCtx;
                v9.EmitIndex = u5.EmitIndex;
                v9.EmitCount = u5.EmitCount;
            end;

            v9._parentAlive = u4;
            v9._parentCloneMap = u7;
            u1:EnableEmit(p8, u3, v9);
        end;

        visit(p2);
    end
};