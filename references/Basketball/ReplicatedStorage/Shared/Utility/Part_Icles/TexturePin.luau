 
 

local CoreGui = game:GetService("CoreGui");
local ContentProvider = game:GetService("ContentProvider");
local u1 = {};
local u2 = nil;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = newproxy();

local function ensureGui() -- Line: 17
    -- upvalues: u2 (ref), CoreGui (copy)
    if u2 and u2.Parent then
        return u2;
    end;

    u2 = Instance.new("ScreenGui");
    u2.Name = "PartIclesTexturePin";
    u2.Archivable = false;
    u2.DisplayOrder = -999;
    u2.IgnoreGuiInset = true;
    u2.ResetOnSpawn = false;
    u2.Parent = CoreGui;

    return u2;
end;

local function _resolveAssetId(p7) -- Line: 30
    if typeof(p7) == "string" then
        if p7 == "" or not p7 then
            p7 = nil;
        end;

        return p7;
    end;

    if typeof(p7) ~= "Instance" then
        return nil;
    end;

    if p7:IsA("Decal") or (p7:IsA("Texture") or (p7:IsA("ParticleEmitter") or (p7:IsA("Beam") or p7:IsA("Trail")))) then
        local Texture = p7.Texture;

        if not (Texture and (Texture ~= "" and Texture)) then
            Texture = nil;
        end;

        return Texture;
    end;

    if p7:IsA("ImageLabel") or p7:IsA("ImageButton") then
        local Image = p7.Image;

        if not (Image and (Image ~= "" and Image)) then
            Image = nil;
        end;

        return Image;
    end;

    if p7:IsA("SpecialMesh") then
        local TextureId = p7.TextureId;

        if not (TextureId and (TextureId ~= "" and TextureId)) then
            TextureId = nil;
        end;

        return TextureId;
    end;

    if p7:IsA("MeshPart") then
        local TextureID = p7.TextureID;

        if not (TextureID and (TextureID ~= "" and TextureID)) then
            TextureID = nil;
        end;

        return TextureID;
    end;
end;

local function _appendAssetIds(u8, p9) -- Line: 47
    -- upvalues: _resolveAssetId (copy)
    if u8:IsA("SurfaceAppearance") then
        for _, v in ipairs({ "ColorMap", "NormalMap", "MetalnessMap", "RoughnessMap" }) do
            local success, result = pcall(function() -- Line: 50
                -- upvalues: u8 (copy), v (copy)
                return u8[v];
            end);

            if success and (result and result ~= "") then
                table.insert(p9, result);
            end;
        end;

        return;
    end;

    local v10 = _resolveAssetId(u8);

    if v10 then
        table.insert(p9, v10);
    end;
end;

function u1.pin(p11, p12) -- Line: 60
    -- upvalues: u6 (copy), _resolveAssetId (copy), u3 (ref), u2 (ref), CoreGui (copy), u4 (ref), u5 (ref), ContentProvider (copy)
    if not p11 then
        return;
    end;

    local v13 = p12 or u6;
    local v14 = type(p11) == "table" and p11 and p11 or { p11 };
    local u15 = {};

    for _, v in ipairs(v14) do
        local v16 = _resolveAssetId(v);

        if v16 then
            if not u3[v16] then
                local v17;

                if u2 and u2.Parent then
                    v17 = u2;
                else
                    u2 = Instance.new("ScreenGui");
                    u2.Name = "PartIclesTexturePin";
                    u2.Archivable = false;
                    u2.DisplayOrder = -999;
                    u2.IgnoreGuiInset = true;
                    u2.ResetOnSpawn = false;
                    u2.Parent = CoreGui;
                    v17 = u2;
                end;

                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Name = "Pin";
                ImageLabel.Image = v16;
                ImageLabel.Size = UDim2.fromOffset(1, 1);
                ImageLabel.Position = UDim2.fromOffset(0, 0);
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.ImageTransparency = 0.99;
                ImageLabel.BorderSizePixel = 0;
                ImageLabel.ZIndex = 1;
                ImageLabel.Parent = v17;
                u3[v16] = ImageLabel;
                table.insert(u15, ImageLabel);
            end;

            local v18 = u4[v16];

            if not v18 then
                v18 = {};
                u4[v16] = v18;
            end;

            v18[v13] = true;
            local v19 = u5[v13];

            if not v19 then
                v19 = {};
                u5[v13] = v19;
            end;

            v19[v16] = true;
        end;
    end;

    if #u15 > 0 then
        task.spawn(function() -- Line: 85
            -- upvalues: ContentProvider (ref), u15 (copy)
            pcall(ContentProvider.PreloadAsync, ContentProvider, u15);
        end);
    end;
end;

function u1.pinSubtree(p20) -- Line: 89
    -- upvalues: _appendAssetIds (copy), u1 (copy)
    if not p20 then
        return;
    end;

    local v21 = {};
    _appendAssetIds(p20, v21);
    local success, result = pcall(p20.GetDescendants, p20);

    if success then
        for _, v in ipairs(result) do
            _appendAssetIds(v, v21);
        end;
    end;

    if #v21 > 0 then
        u1.pin(v21, p20);
    end;
end;

function u1.isPinned(p22) -- Line: 100
    -- upvalues: u3 (ref)
    return u3[p22] ~= nil;
end;

function u1.count() -- Line: 102
    -- upvalues: u3 (ref)
    local v23 = 0;

    for _ in pairs(u3) do
        v23 = v23 + 1;
    end;

    return v23;
end;

function u1.unpin(p24, p25) -- Line: 107
    -- upvalues: u6 (copy), _resolveAssetId (copy), u3 (ref), u4 (ref), u5 (ref)
    if not p24 then
        return;
    end;

    local v26 = p25 or u6;
    local v27 = type(p24) == "table" and p24 and p24 or { p24 };

    for _, v in ipairs(v27) do
        local v28 = _resolveAssetId(v);

        if v28 and u3[v28] then
            local v29 = u4[v28];

            if v29 then
                v29[v26] = nil;
            end;

            local v30 = u5[v26];

            if v30 then
                v30[v28] = nil;
            end;

            local v31 = false;

            if v29 then
                for _ in pairs(v29) do
                    v31 = true;
                    break;
                end;
            end;

            if not v31 then
                pcall(u3[v28].Destroy, u3[v28]);
                u3[v28] = nil;
                u4[v28] = nil;
            end;
        end;
    end;
end;

function u1.releaseOwner(p32) -- Line: 128
    -- upvalues: u5 (ref), u4 (ref), u3 (ref)
    if not p32 then
        return;
    end;

    local v33 = u5[p32];

    if not v33 then
        return;
    end;

    for i in pairs(v33) do
        local v34 = u4[i];

        if v34 then
            v34[p32] = nil;
        end;

        local v35 = false;

        if v34 then
            for _ in pairs(v34) do
                v35 = true;
                break;
            end;
        end;

        if not v35 and u3[i] then
            pcall(u3[i].Destroy, u3[i]);
            u3[i] = nil;
            u4[i] = nil;
        end;
    end;

    u5[p32] = nil;
end;

function u1.unpinSubtree(p36) -- Line: 144
    -- upvalues: _appendAssetIds (copy), u1 (copy)
    if not p36 then
        return;
    end;

    local v37 = {};
    _appendAssetIds(p36, v37);
    local success, result = pcall(p36.GetDescendants, p36);

    if success then
        for _, v in ipairs(result) do
            _appendAssetIds(v, v37);
        end;
    end;

    if #v37 > 0 then
        u1.unpin(v37, p36);
    end;
end;

function u1.clear() -- Line: 156
    -- upvalues: u3 (ref), u4 (ref), u5 (ref), u2 (ref)
    u3 = {};
    u4 = {};
    u5 = {};

    if u2 then
        pcall(u2.Destroy, u2);
        u2 = nil;
    end;
end;

return u1;