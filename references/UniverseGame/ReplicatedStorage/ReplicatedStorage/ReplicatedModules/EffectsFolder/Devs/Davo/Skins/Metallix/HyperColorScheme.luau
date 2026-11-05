  

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = {
    Color3.fromRGB(248, 35, 0),
    Color3.fromRGB(20, 196, 249),
    Color3.fromRGB(3, 0, 248),
    Color3.fromRGB(0, 211, 34),
    Color3.fromRGB(248, 233, 0),
    Color3.fromRGB(185, 185, 185),
    Color3.fromRGB(248, 0, 236)
};

local function IsAllowed(p2) -- Line: 19
    return (p2:IsA("BasePart") and (p2.Transparency < 0.99 or p2:GetAttribute("BypassTransparency")) or (p2:IsA("ParticleEmitter") or (p2:IsA("Trail") or (p2:IsA("Beam") or (p2:IsA("Texture") or (p2:IsA("Decal") or (p2:IsA("PointLight") or (p2:IsA("SurfaceLight") or (p2:IsA("SpotLight") or p2:IsA("SpecialMesh")))))))))) and true or false;
end;

local function GetTweenGroupForColor(p3, p4, p5) -- Line: 26
    -- upvalues: IsAllowed (copy), TweenService (copy)
    local v6 = {};

    for _, v in p3 do
        if IsAllowed(v) ~= false and not (v:IsA("ParticleEmitter") or (v:IsA("Trail") or v:IsA("Beam"))) then
            if not v:IsA("SpecialMesh") then
                local v7 = p5 or TweenInfo.new(0.425, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
                table.insert(v6, TweenService:Create(v, v7, {
                    Color = p4
                }));
            end;
        end;
    end;

    return v6;
end;

return function(u8) -- Line: 43
    -- upvalues: IsAllowed (copy), u1 (copy), GetTweenGroupForColor (copy), Trove (copy), RunService (copy)
    if not u8.Character or (u8.Character:GetAttribute("_HyperActive") or u8.Character:GetAttribute("ChromaUnusual")) then
        return;
    end;

    u8.Character:SetAttribute("_HyperActive", true);
    local u9 = nil;
    local u10 = {};
    local u11 = {};
    local u12 = {};
    local u13 = {};
    local u14 = {};
    local u15 = false;
    local u16 = nil;

    for _, v in u8.Objects do
        if IsAllowed(v) == false then
            local v17 = table.find(u8.Objects, v);
            table.remove(u8.Objects, v17);
        else
            if v:IsA("BasePart") and not u9 then
                u9 = v;
            end;

            if v:IsA("ParticleEmitter") or (v:IsA("Trail") or v:IsA("Beam")) then
                table.insert(u10, v);
            elseif v:IsA("SpecialMesh") then
                table.insert(u12, v);
            end;

            u11[v] = v:IsA("SpecialMesh") and v.VertexColor or v.Color;
        end;
    end;

    for _, v in u1 do
        local v18, _, _ = v:ToHSV();
        local v19 = GetTweenGroupForColor(u8.Objects, Color3.fromHSV(v18, 0.65, 0.9));
        table.insert(u13, v19);
    end;

    local u20 = GetTweenGroupForColor(u8.Objects, Color3.new(1, 1, 1), TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut));
    local v21 = 1;

    for i = 1, #u1 * 2 do
        if i % 2 == 0 then
            u14[i] = u20;
        else
            u14[i] = u13[v21];
            v21 = v21 + 1;
        end;
    end;

    local function Clear() -- Line: 89
        -- upvalues: u15 (ref), u8 (copy), u16 (ref), u14 (copy), u11 (copy), u10 (copy), u20 (ref), u13 (copy)
        u15 = true;

        if u8.Character then
            u8.Character:SetAttribute("_HyperActive", nil);
        end;

        task.cancel(u16);

        for _, v in u14 do
            for _, v2 in v do
                v2:Cancel();
            end;
        end;

        for i, v in u11 do
            if i then
                if i:IsA("SpecialMesh") then
                    i.VertexColor = v;
                else
                    i.Color = v;
                end;
            end;
        end;

        table.clear(u14);
        table.clear(u10);
        table.clear(u20);
        table.clear(u13);
        table.clear(u11);
    end;

    local u22 = Trove.new();
    u22:AttachToInstance(u8.Character);
    u22:Connect(u8.Character:GetAttributeChangedSignal(u8.Hook), function() -- Line: 120
        -- upvalues: u22 (copy)
        u22:Destroy();
    end);

    if (#u10 > 0 or #u12 > 0) and u9 then
        u22:Connect(RunService.PreAnimation, function() -- Line: 124
            -- upvalues: u15 (ref), u10 (copy), u9 (ref), u8 (copy), u12 (copy)
            if u15 then
                return;
            end;

            for _, v in u10 do
                v.Color = ColorSequence.new(u9.Color);
            end;

            local v23 = Vector3.new(u9.Color.R, u9.Color.G, u9.Color.B) * (u8.VertexMultiplier or 1);

            for _, v in u12 do
                v.VertexColor = v23;
            end;
        end);
    end;

    u22:Add(Clear);
    u16 = task.spawn(function() -- Line: 137
        -- upvalues: u14 (copy)
        local v24 = 1;

        while true do
            for _, v in u14[v24] do
                v:Play();
            end;

            u14[v24][1].Completed:Wait();
            local v25 = v24 + 1;
            v24 = #u14 < v25 and 1 or v25;
        end;
    end);
end;