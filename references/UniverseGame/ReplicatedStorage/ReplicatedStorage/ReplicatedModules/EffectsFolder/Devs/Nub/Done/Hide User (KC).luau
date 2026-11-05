  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

local function CustomWait(p1) -- Line: 5
    -- upvalues: RunService (copy)
    local v2 = 0;

    repeat
        v2 = v2 + RunService.RenderStepped:Wait();
    until (p1 or 0) <= v2;

    return v2;
end;

local function IsValidPart(p3, p4) -- Line: 14
    return p3:IsA("BasePart") and not table.find(p4, p3.Name) or (p3:IsA("Decal") or p3:IsA("Texture"));
end;

local function HandleVisualElement(p5, p6) -- Line: 20
    if (not p5:IsA("BasePart") or table.find({ "HumanoidRootPart" }, p5.Name)) and not (p5:IsA("Decal") or p5:IsA("Texture")) then
        if p5.ClassName == "ParticleEmitter" or p5.ClassName == "Beam" then
            if not p6[p5] then
                p6[p5] = {
                    Object = p5,
                    Parent = p5.Parent
                };
            end;

            p5.Parent = nil;
        end;

        return;
    end;

    if not p6[p5] then
        p6[p5] = {
            Object = p5,
            Parent = p5.Parent,
            Properties = {
                Transparency = p5.Transparency
            }
        };
    end;

    p5.Parent = nil;
end;

local function RestoreVisualElement(u7) -- Line: 43
    local Object = u7.Object;

    if Object then
        pcall(function() -- Line: 46
            -- upvalues: Object (copy), u7 (copy)
            Object.Parent = u7.Parent;
        end);

        if u7.Properties then
            for i, v in u7.Properties do
                pcall(function() -- Line: 52
                    -- upvalues: Object (copy), i (copy), v (copy)
                    Object[i] = v;
                end);
            end;
        end;
    end;
end;

return function(p8, p9) -- Line: 61
    -- upvalues: LocalPlayer (copy), HandleVisualElement (copy), RunService (copy), CollectionService (copy), RestoreVisualElement (copy)
    if LocalPlayer.Character == p8 then
        return;
    end;

    local v10 = {};

    for _, descendant in p8:GetDescendants() do
        HandleVisualElement(descendant, v10);
    end;

    local v11 = 0;

    while true do
        for _, descendant in p8:GetDescendants() do
            if not v10[descendant] then
                HandleVisualElement(descendant, v10);
            end;
        end;

        local v12 = 0;

        repeat
            v12 = v12 + RunService.RenderStepped:Wait();
        until (nil or 0) <= v12;

        v11 = v11 + v12;

        if not CollectionService:HasTag(p8, "TimeErase") or p9 < v11 then
            for _, v in v10 do
                if v.Object.Name ~= "EpitaphCounter" then
                    RestoreVisualElement(v);
                end;
            end;

            return;
        end;
    end;
end;