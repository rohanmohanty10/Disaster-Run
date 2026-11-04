 
 

local u1 = {
    AFTER = { "Stay", "Fade", "Return" },
    BREAK = { "None", "Blocks", "Shards" },
    SHARD_PATTERNS = { "Even", "Around hit", "Cracks" },
    SCATTER_TURN = { "Upright", "Any way" },
    SCATTER_SHAPES = { "Box", "Circle", "Region shape" },
    PARTICLE_KEYS = { "Hold", "HoldSpread", "Group", "MaxPieces", "Break", "Pieces", "ShardPattern", "Gravity", "Bounciness", "Friction", "TumbleSpeed", "MaxAirTime", "After", "AfterDelay", "AfterTime" },
    PARTICLE_PATTERNS = { "Even", "Around hit" },
    ReactorProperties = {
        Hold = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        HoldSpread = {
            type = "number",
            default = 0.3,
            nonNegative = true
        },
        Break = {
            type = "string",
            default = "None"
        },
        Pieces = {
            type = "number",
            default = 50,
            nonNegative = true
        },
        ShardPattern = {
            type = "string",
            default = "Even"
        },
        Collapse = {
            type = "boolean",
            default = true
        },
        Group = {
            type = "string",
            default = ""
        },
        Gravity = {
            type = "NumberRange",
            default = NumberRange.new(196.2)
        },
        Bounciness = {
            type = "NumberRange",
            nonNegative = true,
            default = NumberRange.new(0.3, 0.5)
        },
        Friction = {
            type = "NumberRange",
            nonNegative = true,
            default = NumberRange.new(0.5, 0.7)
        },
        TumbleSpeed = {
            type = "NumberRange",
            default = NumberRange.new(90, 360)
        },
        MaxAirTime = {
            type = "number",
            default = 15,
            nonNegative = true
        },
        After = {
            type = "string",
            default = "Stay"
        },
        AfterDelay = {
            type = "number",
            default = 2,
            nonNegative = true
        },
        AfterTime = {
            type = "number",
            default = 1.5,
            nonNegative = true
        },
        ScatterCount = {
            type = "number",
            default = 40,
            nonNegative = true
        },
        ScatterSpacing = {
            type = "number",
            default = 1,
            nonNegative = true
        },
        ScatterTurn = {
            type = "string",
            default = "Upright"
        },
        ScatterSize = {
            type = "NumberRange",
            nonNegative = true,
            default = NumberRange.new(0.8, 1.2)
        },
        ScatterSeed = {
            type = "number",
            default = 1
        },
        ScatterShape = {
            type = "string",
            default = "Box"
        },
        ScatterHollow = {
            type = "number",
            default = 0,
            nonNegative = true
        },
        MaxPieces = {
            type = "number",
            default = 800,
            nonNegative = true
        }
    }
};
u1.Types = {
    Reactor = {
        pDataType = "Reactor",
        uiSection = "Reactors",

        classCheck = function(p2) -- Line: 103, Name: classCheck
            local v3 = p2:IsA("Model") or p2:IsA("BasePart");

            if v3 then
                if p2:GetAttribute("IsReactor") == true then
                    v3 = p2:FindFirstChild("PartIcleProperties") ~= nil;
                else
                    v3 = false;
                end;
            end;

            return v3;
        end,

        properties = u1.ReactorProperties,
        resize = {
            scaleNumbers = { "Hold", "ScatterSpacing" },
            scaleRanges = { "Gravity" }
        },
        retime = {
            multiplyRanges = { "TumbleSpeed" },
            squareRanges = { "Gravity" },
            divideNumbers = { "AfterDelay", "AfterTime", "MaxAirTime" }
        },
        clipboard = { {
                name = "Response",
                props = { "Hold", "HoldSpread", "Group", "MaxPieces" }
            }, {
                name = "Break",
                props = { "Break", "Pieces", "ShardPattern", "Collapse" }
            }, {
                name = "Motion",
                props = { "Gravity", "Bounciness", "Friction", "TumbleSpeed", "MaxAirTime" }
            }, {
                name = "After",
                props = { "After", "AfterDelay", "AfterTime" }
            }, {
                name = "Scatter",
                props = { "ScatterShape", "ScatterHollow", "ScatterCount", "ScatterSpacing", "ScatterTurn", "ScatterSize", "ScatterSeed" }
            } }
    }
};

function u1.giveTo(p4) -- Line: 135
    -- upvalues: u1 (copy)
    p4.properties.Reacts = {
        type = "boolean",
        default = false,
        optional = true
    };
    local v5 = {};
    local v6 = {
        name = "Reactor",
        borrowed = true,
        props = { "Reacts" }
    };

    for _, v in ipairs(u1.PARTICLE_KEYS) do
        local table_clone_ret = table.clone(u1.ReactorProperties[v]);
        table_clone_ret.optional = true;
        p4.properties[v] = table_clone_ret;
        v5[v] = true;
        table.insert(v6.props, v);
    end;

    local Reactor = u1.Types.Reactor;

    for _, v in ipairs({ "resize", "retime" }) do
        p4[v] = p4[v] or {};
        local v7 = v;

        for i, v2 in pairs(Reactor[v]) do
            local v8 = i;

            for _, v3 in ipairs(v2) do
                if v5[v3] then
                    p4[v7][v8] = p4[v7][v8] or {};
                    table.insert(p4[v7][v8], v3);
                end;
            end;
        end;
    end;

    p4.clipboard = p4.clipboard or {};
    table.insert(p4.clipboard, v6);
end;

return u1;