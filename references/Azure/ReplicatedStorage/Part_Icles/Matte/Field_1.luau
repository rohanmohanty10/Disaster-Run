 
 

local AssetService = game:GetService("AssetService");
local u1 = {
    NAME = "MatteField",
    FLIPBOOK = "MatteFlipbooks",
    MASK_FLIPBOOK = "MatteMaskFlipbooks"
};
local u2 = { {
        span = 0.0625,
        mesh = "rbxassetid://109697954021705"
    }, {
        span = 0.125,
        mesh = "rbxassetid://105515425430393"
    }, {
        span = 0.25,
        mesh = "rbxassetid://133204333374156"
    }, {
        span = 0.5,
        mesh = "rbxassetid://110201460857748"
    }, {
        span = 1,
        mesh = "rbxassetid://95616810785060"
    }, {
        span = 4,
        mesh = "rbxassetid://72910309858637"
    }, {
        span = 16,
        mesh = "rbxassetid://74445454192363"
    }, {
        span = 64,
        mesh = "rbxassetid://92190435164571"
    } };
u1.BACKING = Color3.new(0, 0, 0);
u1.SPANS = {};

for i, v in ipairs(u2) do
    u1.SPANS[i] = v.span;
end;

local function quiet(p3) -- Line: 86
    p3.Anchored = true;
    p3.CanCollide = false;
    p3.CanQuery = false;
    p3.CanTouch = false;
    p3.CastShadow = false;
    p3.Massless = true;
    p3.Material = Enum.Material.SmoothPlastic;
    p3.Color = Color3.new(1, 1, 1);
end;

local function load(u4) -- Line: 97
    -- upvalues: AssetService (copy)
    u4.loading = true;
    task.spawn(function() -- Line: 99
        -- upvalues: AssetService (ref), u4 (copy)
        local success, result = pcall(function() -- Line: 100
            -- upvalues: AssetService (ref), u4 (ref)
            return AssetService:CreateMeshPartAsync(Content.fromUri(u4.mesh));
        end);
        u4.loading = false;

        if not (success and result) then
            u4.failedAt = os.clock();

            return;
        end;

        result.Anchored = true;
        result.CanCollide = false;
        result.CanQuery = false;
        result.CanTouch = false;
        result.CastShadow = false;
        result.Massless = true;
        result.Material = Enum.Material.SmoothPlastic;
        result.Color = Color3.new(1, 1, 1);
        u4.plane = result;
    end);
end;

function u1.plane(p5) -- Line: 113
    -- upvalues: u2 (copy), AssetService (copy)
    local u6 = u2[p5];

    if not u6 then
        return nil;
    end;

    if u6.plane then
        return u6.plane;
    end;

    if not (u6.loading or u6.failedAt and os.clock() - u6.failedAt < 5) then
        u6.loading = true;
        task.spawn(function() -- Line: 99
            -- upvalues: AssetService (ref), u6 (copy)
            local success, result = pcall(function() -- Line: 100
                -- upvalues: AssetService (ref), u6 (ref)
                return AssetService:CreateMeshPartAsync(Content.fromUri(u6.mesh));
            end);
            u6.loading = false;

            if not (success and result) then
                u6.failedAt = os.clock();

                return;
            end;

            result.Anchored = true;
            result.CanCollide = false;
            result.CanQuery = false;
            result.CanTouch = false;
            result.CastShadow = false;
            result.Massless = true;
            result.Material = Enum.Material.SmoothPlastic;
            result.Color = Color3.new(1, 1, 1);
            u6.plane = result;
        end);
    end;

    return nil;
end;

local function storedAppearance(p7) -- Line: 128
    -- upvalues: u1 (copy)
    if p7 then
        p7 = p7:FindFirstChild(u1.NAME);
    end;

    if p7 then
        p7 = p7:FindFirstChildOfClass("SurfaceAppearance");
    end;

    return p7;
end;

function u1.still(p8) -- Line: 133
    -- upvalues: u1 (copy)
    if p8 then
        p8 = p8:FindFirstChild(u1.NAME);
    end;

    if p8 then
        p8 = p8:FindFirstChildOfClass("SurfaceAppearance");
    end;

    return p8;
end;

function u1.bare(p9, p10) -- Line: 137
    -- upvalues: u1 (copy)
    local v11 = u1.plane(p9);

    if not v11 then
        return nil;
    end;

    local v12 = v11:Clone();
    v12.Name = p10;
    v12.Archivable = false;

    return v12;
end;

local function numbered(p13, p14) -- Line: 149
    local v15 = {};

    for _, child in ipairs(p13:GetChildren()) do
        if child:IsA(p14) and tonumber(child.Name) then
            table.insert(v15, child);
        end;
    end;

    table.sort(v15, function(p16, p17) -- Line: 156
        return tonumber(p16.Name) < tonumber(p17.Name);
    end);

    return v15;
end;

function u1.frames(p18) -- Line: 162
    -- upvalues: u1 (copy), numbered (copy)
    if p18 then
        p18 = p18:FindFirstChild(u1.NAME);
    end;

    if p18 then
        p18 = p18:FindFirstChild("Frames");
    end;

    return not p18 and {} or numbered(p18, "SurfaceAppearance");
end;

local function maskHolder(p19) -- Line: 172
    -- upvalues: u1 (copy)
    if p19 then
        p19 = p19:FindFirstChild(u1.NAME);
    end;

    if p19 then
        p19 = p19:FindFirstChild("Mask");
    end;

    return p19;
end;

function u1.maskStill(p20) -- Line: 177
    -- upvalues: u1 (copy)
    if p20 then
        p20 = p20:FindFirstChild(u1.NAME);
    end;

    if p20 then
        p20 = p20:FindFirstChild("Mask");
    end;

    if p20 then
        p20 = p20:FindFirstChild("Still");
    end;

    return p20;
end;

function u1.maskFrames(p21) -- Line: 182
    -- upvalues: u1 (copy), numbered (copy)
    if p21 then
        p21 = p21:FindFirstChild(u1.NAME);
    end;

    if p21 then
        p21 = p21:FindFirstChild("Mask");
    end;

    return not p21 and {} or numbered(p21, "SurfaceAppearance");
end;

function u1.flipbookTextures(p22, p23) -- Line: 191
    -- upvalues: u1 (copy), numbered (copy)
    local v24 = p22:FindFirstChild(p23 or u1.FLIPBOOK);
    local v25 = {};

    if v24 then
        for _, v in ipairs((numbered(v24, "Decal"))) do
            local Texture = v.Texture;

            if string.match(Texture, "^%d+$") then
                Texture = "rbxassetid://" .. Texture;
            end;

            if Texture ~= "" then
                table.insert(v25, Texture);
            end;
        end;
    end;

    return v25;
end;

local function sameTextures(p26, p27) -- Line: 209
    if #p26 ~= #p27 then
        return false;
    end;

    for i, v in ipairs(p26) do
        if v.ColorMap ~= p27[i] then
            return false;
        end;
    end;

    return true;
end;

function u1.framesInStep(p28, p29) -- Line: 221
    -- upvalues: u1 (copy)
    local v30 = u1.frames(p28);

    if #v30 ~= #p29 then
        return false;
    end;

    for i, v in ipairs(v30) do
        if v.ColorMap ~= p29[i] then
            return false;
        end;
    end;

    return true;
end;

function u1.maskFramesInStep(p31, p32) -- Line: 225
    -- upvalues: u1 (copy)
    local v33 = u1.maskFrames(p31);

    if #v33 ~= #p32 then
        return false;
    end;

    for i, v in ipairs(v33) do
        if v.ColorMap ~= p32[i] then
            return false;
        end;
    end;

    return true;
end;

function u1.maskInStep(p34, p35) -- Line: 229
    -- upvalues: u1 (copy)
    local v36 = u1.maskStill(p34);

    if p35 == "" then
        return v36 == nil;
    end;

    local v37;

    if v36 == nil then
        v37 = false;
    else
        v37 = v36.ColorMap == p35;
    end;

    return v37;
end;

function u1.inStep(p38, p39) -- Line: 237
    -- upvalues: u1 (copy)
    local v40 = p38:FindFirstChild(u1.NAME);

    if v40 and not v40:IsA("Folder") then
        return false;
    end;

    if v40 then
        v40 = v40:FindFirstChildOfClass("SurfaceAppearance");
    end;

    if p39 == "" then
        return v40 == nil;
    end;

    local v41;

    if v40 == nil then
        v41 = false;
    else
        v41 = v40.ColorMap == p39;
    end;

    return v41;
end;

local function holderOf(p42, p43) -- Line: 251
    -- upvalues: u1 (copy)
    local v44 = p42:FindFirstChild(u1.NAME);

    if v44 and not v44:IsA("Folder") then
        v44.Parent = nil;
        v44 = nil;
    end;

    if not v44 and p43 then
        v44 = Instance.new("Folder");
        v44.Name = u1.NAME;
        v44.Parent = p42;
    end;

    return v44;
end;

local function tidy(p45) -- Line: 267
    if p45 and #p45:GetChildren() == 0 then
        p45.Parent = nil;
    end;
end;

local function appearanceOf(u46, p47, p48) -- Line: 275
    local u49 = p47 or Instance.new("SurfaceAppearance");
    u49.AlphaMode = p48 and Enum.AlphaMode.Transparency or Enum.AlphaMode.Overlay;

    if pcall(function() -- Line: 278
        -- upvalues: u49 (copy), u46 (copy)
        u49.ColorMap = u46;
    end) then
        return u49;
    end;

    return nil;
end;

function u1.store(p50, u51) -- Line: 287
    -- upvalues: u1 (copy)
    local v52 = p50:FindFirstChild(u1.NAME);

    if v52 and not v52:IsA("Folder") then
        v52.Parent = nil;
        v52 = nil;
    end;

    local v53;

    if v52 then
        v53 = v52:FindFirstChildOfClass("SurfaceAppearance");
    else
        v53 = v52;
    end;

    if u51 == "" then
        if v53 then
            v53.Parent = nil;
        end;

        if v52 and #v52:GetChildren() == 0 then
            v52.Parent = nil;
        end;

        return true;
    end;

    local u54 = v53 or Instance.new("SurfaceAppearance");
    u54.AlphaMode = Enum.AlphaMode.Overlay;

    if not pcall(function() -- Line: 278
        -- upvalues: u54 (copy), u51 (copy)
        u54.ColorMap = u51;
    end) then
        u54 = nil;
    end;

    if not u54 then
        return false;
    end;

    local v55 = p50:FindFirstChild(u1.NAME);

    if v55 and not v55:IsA("Folder") then
        v55.Parent = nil;
        v55 = nil;
    end;

    if not v55 then
        v55 = Instance.new("Folder");
        v55.Name = u1.NAME;
        v55.Parent = p50;
    end;

    u54.Parent = v55;

    return true;
end;

function u1.storeFrames(p56, p57) -- Line: 305
    -- upvalues: u1 (copy)
    local v58 = p56:FindFirstChild(u1.NAME);

    if v58 and not v58:IsA("Folder") then
        v58.Parent = nil;
        v58 = nil;
    end;

    local v59;

    if v58 then
        v59 = v58:FindFirstChild("Frames");
    else
        v59 = v58;
    end;

    if v59 then
        v59.Parent = nil;
    end;

    if #p57 == 0 then
        if v58 and #v58:GetChildren() == 0 then
            v58.Parent = nil;
        end;

        return true;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "Frames";

    for i, v in ipairs(p57) do
        local SurfaceAppearance = Instance.new("SurfaceAppearance");
        SurfaceAppearance.AlphaMode = Enum.AlphaMode.Overlay;

        if not pcall(function() -- Line: 278
            -- upvalues: SurfaceAppearance (copy), v (copy)
            SurfaceAppearance.ColorMap = v;
        end) then
            SurfaceAppearance = nil;
        end;

        if not SurfaceAppearance then
            Folder:Destroy();

            if v58 and #v58:GetChildren() == 0 then
                v58.Parent = nil;
            end;

            return false;
        end;

        SurfaceAppearance.Name = tostring(i);
        SurfaceAppearance.Parent = Folder;
    end;

    local v60 = p56:FindFirstChild(u1.NAME);

    if v60 and not v60:IsA("Folder") then
        v60.Parent = nil;
        v60 = nil;
    end;

    if not v60 then
        v60 = Instance.new("Folder");
        v60.Name = u1.NAME;
        v60.Parent = p56;
    end;

    Folder.Parent = v60;

    return true;
end;

local function maskHolderOf(p61, p62) -- Line: 332
    -- upvalues: u1 (copy)
    local v63 = p61:FindFirstChild(u1.NAME);

    if v63 and not v63:IsA("Folder") then
        v63.Parent = nil;
        v63 = nil;
    end;

    if not v63 and p62 then
        v63 = Instance.new("Folder");
        v63.Name = u1.NAME;
        v63.Parent = p61;
    end;

    local v64;

    if v63 then
        v64 = v63:FindFirstChild("Mask");
    else
        v64 = v63;
    end;

    if not v64 and p62 then
        v64 = Instance.new("Folder");
        v64.Name = "Mask";
        v64.Parent = v63;
    end;

    return v64;
end;

local function tidyMask(p65) -- Line: 344
    -- upvalues: u1 (copy)
    local v66 = p65:FindFirstChild(u1.NAME);

    if v66 and not v66:IsA("Folder") then
        v66.Parent = nil;
        v66 = nil;
    end;

    local v67;

    if v66 then
        v67 = v66:FindFirstChild("Mask");
    else
        v67 = v66;
    end;

    if v67 and #v67:GetChildren() == 0 then
        v67.Parent = nil;
    end;

    if v66 and #v66:GetChildren() == 0 then
        v66.Parent = nil;
    end;
end;

function u1.storeMask(p68, u69) -- Line: 351
    -- upvalues: u1 (copy)
    local v70 = u1.maskStill(p68);

    if u69 == "" then
        if v70 then
            v70.Parent = nil;
        end;

        local v71 = p68:FindFirstChild(u1.NAME);

        if v71 and not v71:IsA("Folder") then
            v71.Parent = nil;
            v71 = nil;
        end;

        local v72;

        if v71 then
            v72 = v71:FindFirstChild("Mask");
        else
            v72 = v71;
        end;

        if v72 and #v72:GetChildren() == 0 then
            v72.Parent = nil;
        end;

        if v71 and #v71:GetChildren() == 0 then
            v71.Parent = nil;
        end;

        return true;
    end;

    local u73 = v70 or Instance.new("SurfaceAppearance");
    u73.AlphaMode = Enum.AlphaMode.Transparency or Enum.AlphaMode.Overlay;

    if not pcall(function() -- Line: 278
        -- upvalues: u73 (copy), u69 (copy)
        u73.ColorMap = u69;
    end) then
        u73 = nil;
    end;

    if not u73 then
        return false;
    end;

    u73.Name = "Still";
    local v74 = p68:FindFirstChild(u1.NAME);

    if v74 and not v74:IsA("Folder") then
        v74.Parent = nil;
        v74 = nil;
    end;

    if not v74 then
        v74 = Instance.new("Folder");
        v74.Name = u1.NAME;
        v74.Parent = p68;
    end;

    local v75;

    if v74 then
        v75 = v74:FindFirstChild("Mask");
    else
        v75 = v74;
    end;

    if not v75 then
        v75 = Instance.new("Folder");
        v75.Name = "Mask";
        v75.Parent = v74;
    end;

    u73.Parent = v75;

    return true;
end;

function u1.storeMaskFrames(p76, p77) -- Line: 369
    -- upvalues: u1 (copy)
    for _, v in ipairs(u1.maskFrames(p76)) do
        v.Parent = nil;
    end;

    local v78 = {};

    for i, v in ipairs(p77) do
        local SurfaceAppearance = Instance.new("SurfaceAppearance");
        SurfaceAppearance.AlphaMode = Enum.AlphaMode.Transparency or Enum.AlphaMode.Overlay;

        if not pcall(function() -- Line: 278
            -- upvalues: SurfaceAppearance (copy), v (copy)
            SurfaceAppearance.ColorMap = v;
        end) then
            SurfaceAppearance = nil;
        end;

        if not SurfaceAppearance then
            for _, v2 in ipairs(v78) do
                v2:Destroy();
            end;

            local v79 = p76:FindFirstChild(u1.NAME);

            if v79 and not v79:IsA("Folder") then
                v79.Parent = nil;
                v79 = nil;
            end;

            local v80;

            if v79 then
                v80 = v79:FindFirstChild("Mask");
            else
                v80 = v79;
            end;

            if v80 and #v80:GetChildren() == 0 then
                v80.Parent = nil;
            end;

            if v79 and #v79:GetChildren() == 0 then
                v79.Parent = nil;
            end;

            return false;
        end;

        SurfaceAppearance.Name = tostring(i);
        table.insert(v78, SurfaceAppearance);
    end;

    if #v78 > 0 then
        local v81 = p76:FindFirstChild(u1.NAME);

        if v81 and not v81:IsA("Folder") then
            v81.Parent = nil;
            v81 = nil;
        end;

        if not v81 then
            v81 = Instance.new("Folder");
            v81.Name = u1.NAME;
            v81.Parent = p76;
        end;

        local v82;

        if v81 then
            v82 = v81:FindFirstChild("Mask");
        else
            v82 = v81;
        end;

        if not v82 then
            v82 = Instance.new("Folder");
            v82.Name = "Mask";
            v82.Parent = v81;
        end;

        for _, v in ipairs(v78) do
            v.Parent = v82;
        end;
    end;

    local v83 = p76:FindFirstChild(u1.NAME);

    if v83 and not v83:IsA("Folder") then
        v83.Parent = nil;
        v83 = nil;
    end;

    local v84;

    if v83 then
        v84 = v83:FindFirstChild("Mask");
    else
        v84 = v83;
    end;

    if v84 and #v84:GetChildren() == 0 then
        v84.Parent = nil;
    end;

    if v83 and #v83:GetChildren() == 0 then
        v83.Parent = nil;
    end;

    return true;
end;

return u1;