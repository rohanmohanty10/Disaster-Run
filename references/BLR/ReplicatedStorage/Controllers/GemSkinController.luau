  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local GemSkinConfig = require(ReplicatedStorage.Shared.Configs.GemSkinConfig);
local LocalizationServiceHelper = require(ReplicatedStorage.UserGenerated.Roblox.LocalizationServiceHelper);
local LocalPlayer = Players.LocalPlayer;
local v1 = Knit.CreateController({
    Name = "GemSkinController"
});
local u2 = {};
local u3 = {};
local u4 = false;
local u5 = 0;
local u6 = nil;
local u7 = nil;

local function swapImage(p8: string) -- Line: 35
    -- upvalues: GemSkinConfig (copy)
    local string_match_ret = string.match(p8, "(%d+)%s*$");

    if string_match_ret then
        string_match_ret = GemSkinConfig.ImageSwaps[string_match_ret];
    end;

    if string_match_ret then
        return GemSkinConfig.Images[string_match_ret];
    end;

    return p8;
end;

local function rewriteText(p9: string) -- Line: 44
    -- upvalues: GemSkinConfig (copy)
    local string_gsub_ret = string.gsub(p9, GemSkinConfig.Symbol .. "%s*(%d[%d,%.]*[kKmMbB]?%+?%s*%-%s*%d[%d,%.]*[kKmMbB]?%+?)", "%1 " .. GemSkinConfig.SymbolWord);
    local string_gsub_ret2 = string.gsub(string_gsub_ret, GemSkinConfig.Symbol .. "%s*(%d[%d,%.]*[kKmMbB]?%+?)", "%1 " .. GemSkinConfig.SymbolWord);
    local string_gsub_ret3 = string.gsub(string_gsub_ret2, GemSkinConfig.Symbol, GemSkinConfig.SymbolWord);

    for _, v in GemSkinConfig.WordRules do
        string_gsub_ret3 = string.gsub(string_gsub_ret3, "%f[%a]" .. v[1] .. "%f[%A]", v[2]);
    end;

    return string.gsub(string_gsub_ret3, "(.?)%$%s?(%d)", function(p10: string, p11: string) -- Line: 53
        if p10 == "R" then
            return nil;
        end;

        return p10 .. p11;
    end);
end;

local function swapProduct(p12) -- Line: 62
    -- upvalues: GemSkinConfig (copy)
    local v13 = GemSkinConfig.ProductSwaps[tonumber(p12) or 0];

    if not v13 then
        return p12;
    end;

    if type(p12) == "string" then
        return tostring(v13);
    end;

    return v13;
end;

local function baseProperties(p14: userdata) -- Line: 70
    if p14:IsA("ImageLabel") or p14:IsA("ImageButton") then
        return { "Image" };
    end;

    if p14:IsA("TextLabel") or p14:IsA("TextButton") then
        return { "Text" };
    end;

    if p14:IsA("TextBox") then
        return not p14.TextEditable and { "Text" } or nil;
    end;

    return p14:IsA("ProximityPrompt") and { "ActionText", "ObjectText" } or nil;
end;

local function propertiesFor(p15: userdata) -- Line: 89
    -- upvalues: baseProperties (copy)
    local v16 = baseProperties(p15);

    if p15:GetAttribute("ID") ~= nil then
        v16 = v16 or {};
        table.insert(v16, "@ID");
    end;

    return v16;
end;

local function readValue(p17: userdata, p18: string) -- Line: 98
    if p18 == "@ID" then
        return p17:GetAttribute("ID");
    end;

    return p17[p18];
end;

local function writeValue(p19: userdata, p20: string, p21: any) -- Line: 105
    if p20 == "@ID" then
        p19:SetAttribute("ID", p21);

        return;
    end;

    p19[p20] = p21;
end;

local function transform(p22: string, p23: any) -- Line: 113
    -- upvalues: GemSkinConfig (copy), rewriteText (copy)
    if p22 == "@ID" then
        local v24 = GemSkinConfig.ProductSwaps[tonumber(p23) or 0];

        if not v24 then
            return p23;
        end;

        if type(p23) == "string" then
            return tostring(v24);
        end;

        return v24;
    end;

    if p22 ~= "Image" then
        return rewriteText(p23);
    end;

    local string_match_ret = string.match(p23, "(%d+)%s*$");

    if string_match_ret then
        string_match_ret = GemSkinConfig.ImageSwaps[string_match_ret];
    end;

    if string_match_ret then
        return GemSkinConfig.Images[string_match_ret];
    end;

    return p23;
end;

local function isEligible(p25: userdata) -- Line: 123
    -- upvalues: u7 (ref)
    if u7 and p25:IsDescendantOf(u7) then
        return true;
    end;

    if p25:IsDescendantOf(workspace) then
        return p25:IsA("ProximityPrompt") and true or (p25:FindFirstAncestorWhichIsA("BillboardGui") ~= nil and true or p25:FindFirstAncestorWhichIsA("SurfaceGui") ~= nil);
    end;

    return false;
end;

local function applyProperty(p26: userdata, p27: table, p28: string) -- Line: 136
    -- upvalues: GemSkinConfig (copy), rewriteText (copy)
    local v29;

    if p28 == "@ID" then
        v29 = p26:GetAttribute("ID");
    else
        v29 = p26[p28];
    end;

    local v30 = p27.properties[p28];

    if v30 and v29 == v30.applied then
        return;
    end;

    local v31;

    if p28 == "@ID" then
        v31 = GemSkinConfig.ProductSwaps[tonumber(v29) or 0];

        if v31 then
            if type(v29) == "string" then
                v31 = tostring(v31);
            end;
        else
            v31 = v29;
        end;
    elseif p28 == "Image" then
        local string_match_ret = string.match(v29, "(%d+)%s*$");

        if string_match_ret then
            string_match_ret = GemSkinConfig.ImageSwaps[string_match_ret];
        end;

        if string_match_ret then
            v31 = GemSkinConfig.Images[string_match_ret];
        else
            v31 = v29;
        end;
    else
        v31 = rewriteText(v29);
    end;

    if v31 == v29 then
        p27.properties[p28] = nil;

        return;
    end;

    p27.properties[p28] = {
        original = v29,
        applied = v31
    };

    if p28 == "@ID" then
        p26:SetAttribute("ID", v31);

        return;
    end;

    p26[p28] = v31;
end;

local function release(p32: userdata, p33: boolean) -- Line: 151
    -- upvalues: u2 (copy)
    local v34 = u2[p32];

    if not v34 then
        return;
    end;

    u2[p32] = nil;

    for _, v in v34.connections do
        v:Disconnect();
    end;

    if not p33 then
        return;
    end;

    for i, v in v34.properties do
        local v35;

        if i == "@ID" then
            v35 = p32:GetAttribute("ID");
        else
            v35 = p32[i];
        end;

        if v35 == v.applied then
            local original = v.original;

            if i == "@ID" then
                p32:SetAttribute("ID", original);
            else
                p32[i] = original;
            end;
        end;
    end;
end;

local function hook(u36: userdata) -- Line: 170
    -- upvalues: u2 (copy), baseProperties (copy), isEligible (copy), applyProperty (copy)
    if u2[u36] then
        return;
    end;

    local v37 = baseProperties(u36);

    if u36:GetAttribute("ID") ~= nil then
        v37 = v37 or {};
        table.insert(v37, "@ID");
    end;

    if not (v37 and isEligible(u36)) then
        return;
    end;

    local u38 = {
        properties = {},
        connections = {}
    };
    u2[u36] = u38;

    for _, v in v37 do
        local v39;

        if v == "@ID" then
            v39 = u36:GetAttributeChangedSignal("ID");
        else
            v39 = u36:GetPropertyChangedSignal(v);
        end;

        table.insert(u38.connections, v39:Connect(function() -- Line: 182
            -- upvalues: applyProperty (ref), u36 (copy), u38 (copy), v (copy)
            applyProperty(u36, u38, v);
        end));
        applyProperty(u36, u38, v);
    end;

    table.insert(u38.connections, u36.Destroying:Connect(function() -- Line: 187
        -- upvalues: u36 (copy), u2 (ref)
        local v40 = u36;
        local v41 = u2[v40];

        if not v41 then
            return;
        end;

        u2[v40] = nil;

        for _, v in v41.connections do
            v:Disconnect();
        end;
    end));
end;

local function scan(p42: userdata, p43: number) -- Line: 192
    -- upvalues: u5 (ref), hook (copy)
    for i, descendant in p42:GetDescendants() do
        if p43 ~= u5 then
            return;
        end;

        hook(descendant);

        if i % 2000 == 0 then
            task.wait();
        end;
    end;
end;

local function activate() -- Line: 204
    -- upvalues: u4 (ref), u5 (ref), u7 (ref), LocalPlayer (copy), u3 (copy), hook (copy), scan (copy)
    if u4 then
        return;
    end;

    u4 = true;
    u5 = u5 + 1;
    local v44 = u5;
    u7 = LocalPlayer:WaitForChild("PlayerGui");

    for _, v in { u7, workspace } do
        table.insert(u3, v.DescendantAdded:Connect(hook));
        task.spawn(scan, v, v44);
    end;
end;

local function deactivate() -- Line: 218
    -- upvalues: u4 (ref), u5 (ref), u3 (copy), u2 (copy), release (copy)
    if not u4 then
        return;
    end;

    u4 = false;
    u5 = u5 + 1;

    for _, v in u3 do
        v:Disconnect();
    end;

    table.clear(u3);
    local v45 = {};

    for i in u2 do
        table.insert(v45, i);
    end;

    for _, v in v45 do
        release(v, true);
    end;
end;

local function shouldBeActive() -- Line: 237
    -- upvalues: LocalPlayer (copy), GemSkinConfig (copy), u6 (ref)
    local Attribute = LocalPlayer:GetAttribute(GemSkinConfig.OverrideAttribute);

    if Attribute == true then
        return true;
    end;

    if Attribute == false then
        return false;
    end;

    return u6 == GemSkinConfig.Region;
end;

local function refresh() -- Line: 248
    -- upvalues: LocalPlayer (copy), GemSkinConfig (copy), u6 (ref), activate (copy), deactivate (copy)
    local Attribute = LocalPlayer:GetAttribute(GemSkinConfig.OverrideAttribute);
    local v46;

    if Attribute == true then
        v46 = true;
    elseif Attribute == false then
        v46 = false;
    else
        v46 = u6 == GemSkinConfig.Region;
    end;

    if v46 then
        activate();

        return;
    end;

    deactivate();
end;

function v1.IsActive(p47) -- Line: 256
    -- upvalues: u4 (ref)
    return u4;
end;

function v1.MapProductId(p48: table, p49: number) -- Line: 260
    -- upvalues: u4 (ref), GemSkinConfig (copy)
    if u4 then
        return GemSkinConfig.ProductSwaps[p49] or p49;
    end;

    return p49;
end;

function v1.KnitStart(p50) -- Line: 267
    -- upvalues: LocalPlayer (copy), GemSkinConfig (copy), refresh (copy), u6 (ref), activate (copy), deactivate (copy), LocalizationServiceHelper (copy)
    LocalPlayer:GetAttributeChangedSignal(GemSkinConfig.OverrideAttribute):Connect(refresh);
    local Attribute = LocalPlayer:GetAttribute(GemSkinConfig.OverrideAttribute);
    local v51;

    if Attribute == true then
        v51 = true;
    elseif Attribute == false then
        v51 = false;
    else
        v51 = u6 == GemSkinConfig.Region;
    end;

    if v51 then
        activate();
    else
        deactivate();
    end;

    task.spawn(function() -- Line: 270
        -- upvalues: LocalizationServiceHelper (ref), LocalPlayer (ref), u6 (ref), GemSkinConfig (ref), activate (ref), deactivate (ref)
        local success, result = pcall(LocalizationServiceHelper.GetCountryRegionForPlayerAsync, LocalPlayer);

        if success and type(result) == "string" then
            u6 = result;
        else
            warn((`GemSkinController: region lookup failed: {result}`));
        end;

        local Attribute2 = LocalPlayer:GetAttribute(GemSkinConfig.OverrideAttribute);
        local v52;

        if Attribute2 == true then
            v52 = true;
        elseif Attribute2 == false then
            v52 = false;
        else
            v52 = u6 == GemSkinConfig.Region;
        end;

        if v52 then
            activate();

            return;
        end;

        deactivate();
    end);
end;

return v1;