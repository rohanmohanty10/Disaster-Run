  

 

require(game.ReplicatedStorage.ReplicatedRoot.Core);
local u1 = {
    Entries = {}
};
local u2 = {
    MAX_ENTRIES = 60,
    SEVERITY_LEVELS = {
        Low = 1,
        Medium = 2,
        High = 3,
        Severe = 4,
        Critical = 5
    },
    SEVERITY_THRESHOLD = game:GetService("RunService"):IsStudio() and 1 or 4
};

function u1.Log(p3) -- Line: 40
    -- upvalues: u2 (copy), u1 (copy)
    local v4 = p3 or {};
    local Source = v4.Source;
    local Message = v4.Message;
    local v5 = v4.Type or "Print";
    local v6 = v4.Severity or "Low";
    local v7 = u2.SEVERITY_LEVELS[v6] or u2.SEVERITY_LEVELS.Low;
    local v8;

    if typeof(Message) == "table" then
        local v9 = {};

        for i, v in pairs(Message) do
            v9[i] = tostring(v);
        end;

        v8 = table.concat(v9, ", ");
    else
        v8 = tostring(Message);
    end;

    local Entries = u1.Entries;
    local v10 = {
        Source = Source,
        Message = Message,
        Type = v5,
        Severity = v6,
        Text = v8,
        Time = os.clock()
    };
    table.insert(Entries, 1, v10);

    if #u1.Entries > u2.MAX_ENTRIES then
        for i = u2.MAX_ENTRIES + 1, #u1.Entries do
            u1.Entries[i] = nil;
        end;
    end;

    local v11 = `{`[{string.sub(v6, 1, 1)}]{Source == nil and "" or (`[{tostring(Source)}]` or "")}:`} {v8}`;

    if u2.SEVERITY_THRESHOLD <= v7 then
        if v5 == "Print" then
            print(v11);

            return;
        end;

        if v5 == "Warn" then
            warn(v11);
        end;
    elseif v5 == "Error" then
        error(v11);
    end;
end;

return u1;