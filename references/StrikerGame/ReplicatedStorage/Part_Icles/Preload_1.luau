 
 

local ContentProvider = game:GetService("ContentProvider");
local v1 = {};
local u2 = {};

local function carriersFor(p3, p4) -- Line: 27
    -- upvalues: u2 (copy)
    local v5 = {};
    local v6 = {};

    for _, v in ipairs(p3) do
        if typeof(v) == "Instance" then
            table.insert(v5, v);
        elseif type(v) == "string" and (v ~= "" and not (p4 and u2[v])) then
            if p4 then
                u2[v] = true;
            end;

            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Image = v;
            table.insert(v5, ImageLabel);
            table.insert(v6, ImageLabel);
        end;
    end;

    return v5, v6;
end;

local function load(p7, p8) -- Line: 46
    -- upvalues: ContentProvider (copy)
    if #p7 > 0 then
        pcall(ContentProvider.PreloadAsync, ContentProvider, p7);
    end;

    for _, v in ipairs(p8) do
        v:Destroy();
    end;
end;

function v1.ask(p9) -- Line: 55
    -- upvalues: carriersFor (copy), load (copy)
    local v10, v11 = carriersFor(p9, true);

    if #v10 == 0 then
        return;
    end;

    task.spawn(load, v10, v11);
end;

function v1.wait(p12) -- Line: 63
    -- upvalues: carriersFor (copy), load (copy)
    local v13, v14 = carriersFor(p12, false);
    load(v13, v14);
end;

return v1;