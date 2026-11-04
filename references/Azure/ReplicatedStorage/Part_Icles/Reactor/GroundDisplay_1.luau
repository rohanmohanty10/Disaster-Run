 
 

local Display = require(script.Parent.Display);
local Index = require(script.Parent.Index);
local Sites = require(script.Parent.Sites);
local Layers = require(script.Parent.Layers);
local SkinDisplay = require(script.Parent.SkinDisplay);
local v1 = {};

local function makeBox(p2, p3) -- Line: 36
    -- upvalues: Display (copy), Index (copy)
    local Instance_fromExisting_ret = Instance.fromExisting(p2);
    Instance_fromExisting_ret.Name = "GroundBox";
    Instance_fromExisting_ret.Archivable = false;
    Instance_fromExisting_ret.Anchored = true;
    Instance_fromExisting_ret.CanCollide = false;
    Instance_fromExisting_ret.CanQuery = false;
    Instance_fromExisting_ret.CanTouch = false;
    Instance_fromExisting_ret.Locked = true;
    Instance_fromExisting_ret.Transparency = Display.ownTransparency(p2);
    Index.unmark(Instance_fromExisting_ret);
    Instance_fromExisting_ret:SetAttribute("_PartIcleEmit", true);
    Instance_fromExisting_ret.Parent = p3;

    return Instance_fromExisting_ret;
end;

local function carried(p4, p5) -- Line: 54
    local v6 = {};

    if p4.plain or (p5.axis ~= "Y" or p5.side ~= 1) then
        return v6;
    end;

    for _, child in ipairs(p4.part:GetChildren()) do
        if child:IsA("Texture") and child.Face == Enum.NormalId.Top then
            table.insert(v6, child);
        end;
    end;

    return v6;
end;

function v1.new(u7, u8, p9) -- Line: 69
    -- upvalues: SkinDisplay (copy), Display (copy), Layers (copy), carried (copy), makeBox (copy), Sites (copy)
    local u10 = {};
    local u11 = {};
    local u12 = SkinDisplay.new(u7, u8, p9);

    local function whole(p13) -- Line: 76
        -- upvalues: u10 (copy), Display (ref), u8 (copy)
        local v14 = u10[p13];

        if not v14 then
            return;
        end;

        u10[p13] = nil;

        for _, v in ipairs(v14.boxes) do
            v:Destroy();
        end;

        Display.show(p13, u8, v14.kept);
    end;

    function u11.draw(p15, p16, p17) -- Line: 88
        -- upvalues: u12 (copy), Layers (ref), u11 (copy), whole (copy), u10 (copy), carried (ref), makeBox (ref), u7 (copy), Display (ref), Sites (ref), u8 (copy)
        if p15.layers then
            for _, v in ipairs(p15.layers) do
                if v.skin then
                    u12.draw(p15, v, p16, p17);
                else
                    local v18;

                    if p16 then
                        v18 = Layers.clip(p15, v, p16, p17);
                    else
                        v18 = p16;
                    end;

                    u11.draw(v.slice, v18, p17);
                end;
            end;

            return;
        end;

        local part = p15.part;

        if not p16 then
            whole(part);

            return;
        end;

        local v19 = u10[part];

        if not v19 then
            v19 = {
                boxes = {},
                textures = carried(p15, p17)
            };
            u10[part] = v19;
        end;

        local boxes = v19.boxes;

        for i = #boxes, #p16 + 1, -1 do
            boxes[i]:Destroy();
            boxes[i] = nil;
            local _ = i;
        end;

        local v20 = p15.size[p17.axis];

        for i, v in ipairs(p16) do
            local v21 = boxes[i];
            local v22;

            if v21 then
                v22 = v;
            else
                v21 = makeBox(part, u7);
                v22 = v;

                for _, v2 in ipairs(v19.textures) do
                    local v23 = v2:Clone();
                    Display.unhidden(v23, v2);
                    v23.Parent = v21;
                end;

                boxes[i] = v21;
            end;

            local v24 = Sites.alongFace(p17.axis, (v22.minU + v22.maxU) / 2, (v22.minV + v22.maxV) / 2, 0);
            v21.Size = Sites.alongFace(p17.axis, v22.maxU - v22.minU, v22.maxV - v22.minV, v20);
            v21.CFrame = p15.frame * CFrame.new(v24.X, v24.Y, v24.Z);

            if #v19.textures > 0 then
                local v25 = {};

                for _, child in ipairs(v21:GetChildren()) do
                    if child:IsA("Texture") then
                        table.insert(v25, child);
                    end;
                end;

                for i2, v2 in ipairs(v19.textures) do
                    v25[i2].OffsetStudsU = v2.OffsetStudsU + p15.size.X / 2 - v22.maxU;
                    v25[i2].OffsetStudsV = v2.OffsetStudsV + p15.size.Z / 2 - v22.maxV;
                end;
            end;
        end;

        if not v19.kept then
            v19.kept = Display.hide(part, u8, true);
        end;
    end;

    function u11.clear() -- Line: 154
        -- upvalues: u10 (copy), whole (copy), u12 (copy)
        for i in pairs(table.clone(u10)) do
            whole(i);
        end;

        u12.clear();
    end;

    return u11;
end;

return v1;