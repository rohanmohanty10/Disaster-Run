  

 

local u1 = {
    0.15,
    Enum.EasingStyle.Elastic,
    Enum.EasingDirection.InOut,
    -1,
    true
};
local u2 = {
    FillTransparency = 1,
    OutlineTransparency = 0.75
};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u3 = require(PathShortcuts.ReplicatedModules.Independent.StoreHandler).GetStore("HighlightCache");

return function(p4, p5) -- Line: 12
    -- upvalues: u3 (copy), u1 (copy), u2 (copy), TweenService (copy)
    local v6;

    if p4 then
        v6 = `{p4}`;
    else
        v6 = error("No UUID provided");
    end;

    local v7 = p5 or error("No porperties");

    if v7.Adornee == nil then
        error("No adornee provided");
    end;

    if u3[v6] then
        error((`UUID : {v6} is already being used`));
    end;

    local Highlight = Instance.new("Highlight");

    for i, v in v7 do
        if i ~= "TweenData" then
            Highlight[i] = v;
        end;
    end;

    Highlight.Parent = v7.Parent or v7.Adornee;
    u3[v6] = Highlight;

    if v7.TweenData == nil then
        v7.TweenData = {};
    end;

    local v8 = v7.TweenData.Properties or u2;
    TweenService:Create(Highlight, TweenInfo.new(unpack(v7.TweenData.Info or u1)), v8):Play();
end;