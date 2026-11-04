 
 

local ContentProvider = game:GetService("ContentProvider");
local Range = require(script.Parent.Range);
local Flipbook = require(script.Parent.Flipbook);
local VisualHost = require(script.Parent.VisualHost);
local Log = require(script.Parent.Log);
local u1 = {};
local u2 = {
    OneShot = true,
    Loop = true,
    PingPong = true
};
local u3 = setmetatable({}, {
    __mode = "k"
});
local u4 = false;

function u1.isFrame(p5) -- Line: 40
    local v6 = p5:IsA("MeshPart") or p5:IsA("BasePart") and p5:FindFirstChildOfClass("SpecialMesh") ~= nil;

    return v6;
end;

local function firstDecal(p7) -- Line: 45
    for _, child in ipairs(p7:GetChildren()) do
        if child:IsA("Decal") or child:IsA("Texture") then
            return child;
        end;
    end;

    return nil;
end;

local function frameIds(p8) -- Line: 53
    -- upvalues: firstDecal (copy)
    if p8:IsA("MeshPart") then
        return p8.MeshId, p8.TextureID;
    end;

    local v9 = p8:FindFirstChildOfClass("SpecialMesh");
    local v10 = firstDecal(p8);

    return v9.MeshId, v10 and v10.Texture ~= "" and v10.Texture or v9.TextureId;
end;

function u1.readFrames(p11) -- Line: 62
    -- upvalues: u3 (copy), ContentProvider (copy)
    local u12 = {};

    if not p11 then
        return u12;
    end;

    for _, child in ipairs(p11:GetChildren()) do
        local v13 = child:IsA("MeshPart") or child:IsA("BasePart") and child:FindFirstChildOfClass("SpecialMesh") ~= nil;

        if v13 then
            table.insert(u12, child);
        end;
    end;

    table.sort(u12, function(p14, p15) -- Line: 68
        return (tonumber(p14.Name) or 0) < (tonumber(p15.Name) or 0);
    end);

    if #u12 > 0 and u3[p11] ~= #u12 then
        u3[p11] = #u12;
        task.spawn(function() -- Line: 73
            -- upvalues: ContentProvider (ref), u12 (copy)
            pcall(function() -- Line: 74
                -- upvalues: ContentProvider (ref), u12 (ref)
                ContentProvider:PreloadAsync(u12);
            end);
        end);
    end;

    return u12;
end;

function u1.readInto(p16, p17, p18) -- Line: 81
    -- upvalues: u1 (copy), firstDecal (copy), u2 (copy)
    p16.MeshFrames = u1.readFrames(p17:FindFirstChild("MeshFrames"));
    p16.MeshFrameMeshIds = {};
    p16.MeshFrameTextures = {};
    p16.MeshFramesTextured = false;

    for i, v in ipairs(p16.MeshFrames) do
        local v19, v20;

        if v:IsA("MeshPart") then
            v19 = v.MeshId;
            v20 = v.TextureID;
        else
            local v21 = v:FindFirstChildOfClass("SpecialMesh");
            local v22 = firstDecal(v);
            v20 = v22 and v22.Texture ~= "" and v22.Texture or v21.TextureId;
            v19 = v21.MeshId;
        end;

        p16.MeshFrameMeshIds[i] = v19;
        p16.MeshFrameTextures[i] = v20;

        if v20 ~= "" then
            p16.MeshFramesTextured = true;
        end;
    end;

    local Attribute = p18:GetAttribute("MeshFrameMode");

    if typeof(Attribute) == "EnumItem" then
        Attribute = Attribute.Name;
    end;

    p16.MeshFrameMode = u2[Attribute] and Attribute and Attribute or "None";
    p16.MeshFrameFramerate = p18:GetAttribute("MeshFrameFramerate") or NumberRange.new(24);
    p16.MeshFrameStartRandom = p18:GetAttribute("MeshFrameStartRandom") == true;
    p16.MeshFrameReverse = p18:GetAttribute("MeshFrameReverse") == true;
end;

local function isActive(p23) -- Line: 100
    local v24;

    if p23.MeshFrames == nil or #p23.MeshFrames <= 0 then
        v24 = false;
    else
        v24 = p23.MeshFrameMode ~= "None";
    end;

    return v24;
end;

local function buildState(p25, p26) -- Line: 104
    -- upvalues: Range (copy), Flipbook (copy)
    local v27 = Range.RandomValueFromRange(p25.MeshFrameFramerate);
    local v28 = Flipbook.layerState(p26, p25.MeshFrames, p25.MeshFrameMode, v27, p25.MeshFrameStartRandom, p25.MeshFrameReverse);
    v28.meshIds = p25.MeshFrameMeshIds;
    v28.textures = p25.MeshFrameTextures;

    return v28;
end;

local function textureSlot(p29, p30) -- Line: 114
    -- upvalues: firstDecal (copy)
    local v31 = firstDecal(p29);

    if v31 then
        return v31, "Texture";
    end;

    return p30, "TextureId";
end;

local function applyFrame(u32, u33, u34) -- Line: 120
    pcall(function() -- Line: 121
        -- upvalues: u32 (copy), u34 (copy), u33 (copy)
        if u32.specialMesh then
            u32.specialMesh.MeshId = u32.meshIds[u34];
            local v35 = u32.textures[u34];

            if v35 ~= "" then
                u32.textureTarget[u32.textureProp] = v35;
            end;

            return;
        end;

        local v36 = u32.frames[u34];
        local TextureID = u33.TextureID;
        u33:ApplyMesh(v36);

        if v36.TextureID == "" and TextureID ~= "" then
            u33.TextureID = TextureID;
        end;
    end);
end;

local function runTask(u37, u38, u39, u40) -- Line: 136
    -- upvalues: Flipbook (copy)
    local os_clock_ret = os.clock();
    task.spawn(function() -- Line: 138
        -- upvalues: u38 (copy), u37 (copy), u40 (copy), os_clock_ret (copy), u39 (copy), Flipbook (ref)
        while not u38.stopped do
            local VisualPart = u37.VisualPart;

            if not (VisualPart and (VisualPart.Parent and (not u37._nestedAlive or u37._nestedAlive[1]))) then
                break;
            end;

            if u37._handedOver then
                return;
            end;

            if not u40 and os.clock() - os_clock_ret > u39 * 4 then
                break;
            end;

            local v41 = u37._effectiveElapsed or os.clock() - os_clock_ret;
            local u42 = Flipbook.frameIndex(u38, v41, u37.LifeTime or u39);

            if u42 ~= u38.lastFrame then
                u38.lastFrame = u42;
                local u43 = u38;
                pcall(function() -- Line: 121
                    -- upvalues: u43 (copy), u42 (copy), VisualPart (copy)
                    if u43.specialMesh then
                        u43.specialMesh.MeshId = u43.meshIds[u42];
                        local v44 = u43.textures[u42];

                        if v44 ~= "" then
                            u43.textureTarget[u43.textureProp] = v44;
                        end;

                        return;
                    end;

                    local v45 = u43.frames[u42];
                    local TextureID = VisualPart.TextureID;
                    VisualPart:ApplyMesh(v45);

                    if v45.TextureID == "" and TextureID ~= "" then
                        VisualPart.TextureID = TextureID;
                    end;
                end);
            end;

            task.wait();
        end;

        if u38.stopped or (u40 or (u38.mode == "Loop" or u38.mode == "PingPong")) then
            return;
        end;

        local VisualPart = u37.VisualPart;

        if VisualPart and VisualPart.Parent then
            local u46 = u38;
            local u47 = Flipbook.finalFrame(u38);
            pcall(function() -- Line: 121
                -- upvalues: u46 (copy), u47 (copy), VisualPart (copy)
                if u46.specialMesh then
                    u46.specialMesh.MeshId = u46.meshIds[u47];
                    local v48 = u46.textures[u47];

                    if v48 ~= "" then
                        u46.textureTarget[u46.textureProp] = v48;
                    end;

                    return;
                end;

                local v49 = u46.frames[u47];
                local TextureID = VisualPart.TextureID;
                VisualPart:ApplyMesh(v49);

                if v49.TextureID == "" and TextureID ~= "" then
                    VisualPart.TextureID = TextureID;
                end;
            end);
        end;
    end);
end;

local function resetToTemplate(u50, u51, u52) -- Line: 161
    if not u52 then
        return;
    end;

    if u51 then
        local u53 = u52:FindFirstChildOfClass("SpecialMesh");

        if u53 and u51.MeshId ~= u53.MeshId then
            pcall(function() -- Line: 165
                -- upvalues: u51 (copy), u53 (copy)
                u51.MeshId = u53.MeshId;
            end);
        end;
    elseif u52:IsA("MeshPart") and u50.MeshId ~= u52.MeshId then
        pcall(function() -- Line: 167
            -- upvalues: u50 (copy), u52 (copy)
            u50:ApplyMesh(u52);
        end);
    end;
end;

function u1.attach(u54, p55, p56, u57, u58) -- Line: 173
    -- upvalues: u4 (ref), Log (copy), resetToTemplate (copy), Range (copy), Flipbook (copy), firstDecal (copy), VisualHost (copy)
    u54.MeshFrames = nil;
    local v59;

    if p55.MeshFrames == nil or #p55.MeshFrames <= 0 then
        v59 = false;
    else
        v59 = p55.MeshFrameMode ~= "None";
    end;

    local v60;

    if p56:IsA("MeshPart") then
        v60 = nil;
    else
        v60 = p56:FindFirstChildOfClass("SpecialMesh") or nil;
    end;

    if not (p56:IsA("MeshPart") or v60) then
        if v59 and not u4 then
            u4 = true;
            Log.warn(("[Part-Icles] Mesh Frames need a MeshPart or a Part with a SpecialMesh as RenderTemplate; %s is a %s."):format(p56:GetFullName(), p56.ClassName));
        end;

        return;
    end;

    if not v59 then
        if not u58 then
            resetToTemplate(p56, v60, p55.RenderTemplate);
        end;

        return;
    end;

    local v61 = Range.RandomValueFromRange(p55.MeshFrameFramerate);
    local u62 = Flipbook.layerState(p56, p55.MeshFrames, p55.MeshFrameMode, v61, p55.MeshFrameStartRandom, p55.MeshFrameReverse);
    u62.meshIds = p55.MeshFrameMeshIds;
    u62.textures = p55.MeshFrameTextures;

    if v60 then
        u62.specialMesh = v60;
        local v63 = firstDecal(p56);
        local v64;

        if v63 then
            v64 = "Texture";
        else
            v63 = v60;
            v64 = "TextureId";
        end;

        u62.textureTarget = v63;
        u62.textureProp = v64;
    end;

    if u58 then
        if v60 then
            u62.backup = {
                meshId = v60.MeshId,
                texture = u62.textureTarget[u62.textureProp]
            };
        else
            local v65 = p56:Clone();

            for _, child in ipairs(v65:GetChildren()) do
                child:Destroy();
            end;

            v65.Name = "_MeshFrameBackup";
            v65.Archivable = false;
            v65.Parent = VisualHost.getPoolFolder();
            u62.backup = v65;
        end;
    end;

    u54.MeshFrames = u62;
    local os_clock_ret = os.clock();
    task.spawn(function() -- Line: 138
        -- upvalues: u62 (copy), u54 (copy), u58 (copy), os_clock_ret (copy), u57 (copy), Flipbook (ref)
        while not u62.stopped do
            local VisualPart = u54.VisualPart;

            if not (VisualPart and (VisualPart.Parent and (not u54._nestedAlive or u54._nestedAlive[1]))) then
                break;
            end;

            if u54._handedOver then
                return;
            end;

            if not u58 and os.clock() - os_clock_ret > u57 * 4 then
                break;
            end;

            local v66 = u54._effectiveElapsed or os.clock() - os_clock_ret;
            local u67 = Flipbook.frameIndex(u62, v66, u54.LifeTime or u57);

            if u67 ~= u62.lastFrame then
                u62.lastFrame = u67;
                local u68 = u62;
                pcall(function() -- Line: 121
                    -- upvalues: u68 (copy), u67 (copy), VisualPart (copy)
                    if u68.specialMesh then
                        u68.specialMesh.MeshId = u68.meshIds[u67];
                        local v69 = u68.textures[u67];

                        if v69 ~= "" then
                            u68.textureTarget[u68.textureProp] = v69;
                        end;

                        return;
                    end;

                    local v70 = u68.frames[u67];
                    local TextureID = VisualPart.TextureID;
                    VisualPart:ApplyMesh(v70);

                    if v70.TextureID == "" and TextureID ~= "" then
                        VisualPart.TextureID = TextureID;
                    end;
                end);
            end;

            task.wait();
        end;

        if u62.stopped or (u58 or (u62.mode == "Loop" or u62.mode == "PingPong")) then
            return;
        end;

        local VisualPart = u54.VisualPart;

        if VisualPart and VisualPart.Parent then
            local u71 = u62;
            local u72 = Flipbook.finalFrame(u62);
            pcall(function() -- Line: 121
                -- upvalues: u71 (copy), u72 (copy), VisualPart (copy)
                if u71.specialMesh then
                    u71.specialMesh.MeshId = u71.meshIds[u72];
                    local v73 = u71.textures[u72];

                    if v73 ~= "" then
                        u71.textureTarget[u71.textureProp] = v73;
                    end;

                    return;
                end;

                local v74 = u71.frames[u72];
                local TextureID = VisualPart.TextureID;
                VisualPart:ApplyMesh(v74);

                if v74.TextureID == "" and TextureID ~= "" then
                    VisualPart.TextureID = TextureID;
                end;
            end);
        end;
    end);
end;

function u1.restore(p75) -- Line: 211
    local MeshFrames = p75.MeshFrames;

    if not MeshFrames then
        return;
    end;

    MeshFrames.stopped = true;
    local backup = MeshFrames.backup;

    if not backup then
        return;
    end;

    MeshFrames.backup = nil;
    local VisualPart = p75.VisualPart;

    if MeshFrames.specialMesh then
        pcall(function() -- Line: 220
            -- upvalues: MeshFrames (copy), backup (copy)
            MeshFrames.specialMesh.MeshId = backup.meshId;
            MeshFrames.textureTarget[MeshFrames.textureProp] = backup.texture;
        end);

        return;
    end;

    if VisualPart and VisualPart.Parent then
        pcall(function() -- Line: 226
            -- upvalues: VisualPart (copy), backup (copy)
            VisualPart:ApplyMesh(backup);
        end);
    end;

    pcall(function() -- Line: 227
        -- upvalues: backup (copy)
        backup:Destroy();
    end);
end;

function u1.refresh(p76, p77) -- Line: 231
    -- upvalues: Range (copy), Flipbook (copy)
    local MeshFrames = p76.MeshFrames;

    if MeshFrames and p77 then
        local v78;

        if p77.MeshFrames == nil or #p77.MeshFrames <= 0 then
            v78 = false;
        else
            v78 = p77.MeshFrameMode ~= "None";
        end;

        if v78 then
            local target = MeshFrames.target;
            local v79 = Range.RandomValueFromRange(p77.MeshFrameFramerate);
            local v80 = Flipbook.layerState(target, p77.MeshFrames, p77.MeshFrameMode, v79, p77.MeshFrameStartRandom, p77.MeshFrameReverse);
            v80.meshIds = p77.MeshFrameMeshIds;
            v80.textures = p77.MeshFrameTextures;
            local n = v80.n;
            local mode = v80.mode;
            MeshFrames.frames = v80.frames;
            MeshFrames.n = n;
            MeshFrames.mode = mode;
            local textures = v80.textures;
            MeshFrames.meshIds = v80.meshIds;
            MeshFrames.textures = textures;
            local startOffset = v80.startOffset;
            local reverse = v80.reverse;
            MeshFrames.frameDelay = v80.frameDelay;
            MeshFrames.startOffset = startOffset;
            MeshFrames.reverse = reverse;
            MeshFrames.lastFrame = -1;
        end;
    end;
end;

return u1;