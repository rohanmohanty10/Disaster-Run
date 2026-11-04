  

game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Squash = require(ReplicatedStorage.Packages.Squash);
local T = Squash.T;
local _ = Squash.uint;
local u1 = Squash.vlq();
local v2 = Squash.boolean();
local u3 = Squash.string();
local v4 = Squash.number(4);
local _ = Squash.Vector2;
local array = Squash.array;
local map = Squash.map;
local opt = Squash.opt;
local record = Squash.record;
local u5 = { "boolean", "number" };

local function any() -- Line: 23
    -- upvalues: u3 (copy), any (ref), u1 (copy), Squash (copy), u5 (copy)
    return {
        ser = function(p6, p7) -- Line: 25, Name: ser
            -- upvalues: u3 (ref), any (ref), u1 (ref), Squash (ref), u5 (ref)
            local v8 = typeof(p7);

            if v8 == "nil" then
                u3.ser(p6, "nil");

                return;
            end;

            if v8 == "table" then
                local v9 = 0;

                for i, v in p7 do
                    v9 = v9 + 1;
                    any().ser(p6, i);
                    any().ser(p6, v);
                end;

                u1.ser(p6, v9);
                u3.ser(p6, "table");

                return;
            end;

            local v10 = Squash[v8];

            if not v10 then
                error((`not found for {v8}`));
            end;

            if typeof(v10) == "function" or v8 == "string" then
                local v11;

                if v8 == "string" then
                    v11 = nil;
                else
                    v11 = table.find(u5, v8) and 8 or Squash.number(8);
                end;

                v10 = v10(v11);
            end;

            v10.ser(p6, p7);
            u3.ser(p6, v8);
        end,

        des = function(p12) -- Line: 55, Name: des
            -- upvalues: u3 (ref), u1 (ref), any (ref), Squash (ref), u5 (ref)
            local v13 = u3.des(p12);

            if v13 == "nil" then
                return nil;
            end;

            if v13 == "table" then
                local v14 = {};

                for i = 1, u1.des(p12) do
                    local v15 = any().des(p12);
                    v14[any().des(p12)] = v15;
                    local _ = i;
                end;

                return v14;
            end;

            local v16 = Squash[v13];

            if not v16 then
                error((`not found for {v13}`));
            end;

            if typeof(v16) == "function" or v13 == "string" then
                local v17;

                if v13 == "string" then
                    v17 = nil;
                else
                    v17 = table.find(u5, v13) and 8 or Squash.number(8);
                end;

                v16 = v16(v17);
            end;

            return v16.des(p12);
        end
    };
end;

return record({
    Information = T(record({
        Looped = T(v2),
        Length = T(u1),
        FPS = T(opt(u1))
    })),
    Compiled = T(array(record({
        Path = record({
            InstanceNames = T(array(u3)),
            InstanceTypes = T(array(u3)),
            ItemType = T(u3)
        }),
        Props = T(opt(map(u3, record({
            Default = T(any()),
            Static = T(opt(v2)),
            Sequence = T(array(record({
                Ease = T(opt(record({
                    Params = record({
                        Direction = T(opt(u3)),
                        Overshoot = T(opt(v4)),
                        Amplitude = T(opt(v4)),
                        Period = T(opt(v4))
                    }),
                    Type = T(u3)
                }))),
                Time = T(u1),
                Value = T(any())
            })))
        }))))
    })))
});