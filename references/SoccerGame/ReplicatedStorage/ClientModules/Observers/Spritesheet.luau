  

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return require(ReplicatedStorage.Packages.Observers).observeTag("SpriteSheet", function(u1: userdata) -- Line: 4
    local u2 = false;
    local Attribute = u1:GetAttribute("COLUMNS");
    local Attribute2 = u1:GetAttribute("ROWS");
    local Attribute3 = u1:GetAttribute("TOTAL_FRAMES");
    local Attribute4 = u1:GetAttribute("FPS");
    local Attribute5 = u1:GetAttribute("IMAGE_WIDTH");
    local Attribute6 = u1:GetAttribute("IMAGE_HEIGHT");
    local u3 = Attribute5 / Attribute;
    local u4 = Attribute6 / Attribute2;
    local u5 = u3 / u4;
    local u6 = u1:FindFirstChildOfClass("UIAspectRatioConstraint");

    if not u6 then
        u6 = Instance.new("UIAspectRatioConstraint");
        u6.Parent = u1;
    end;

    u6.AspectRatio = u5;
    u1.ImageRectSize = Vector2.new(u3, u4);
    u1.ScaleType = Enum.ScaleType.Stretch;
    local u7 = 0;
    local u8 = false;

    local function updateFrame() -- Line: 30
        -- upvalues: u2 (ref), u7 (ref), Attribute (copy), u1 (copy), u3 (ref), u4 (ref)
        if u2 then
            return;
        end;

        local math_floor_ret = math.floor(u7 / Attribute);
        u1.ImageRectOffset = Vector2.new(u7 % Attribute * u3, math_floor_ret * u4);
    end;

    local function startAnimation() -- Line: 40
        -- upvalues: u8 (ref), u2 (ref), u7 (ref), Attribute (copy), u1 (copy), u3 (ref), u4 (ref), Attribute3 (ref), Attribute4 (ref)
        if u8 then
            return;
        end;

        u8 = true;
        task.spawn(function() -- Line: 43
            -- upvalues: u8 (ref), u2 (ref), u7 (ref), Attribute (ref), u1 (ref), u3 (ref), u4 (ref), Attribute3 (ref), Attribute4 (ref)
            while u8 and not u2 do
                if not u2 then
                    local math_floor_ret = math.floor(u7 / Attribute);
                    u1.ImageRectOffset = Vector2.new(u7 % Attribute * u3, math_floor_ret * u4);
                end;

                u7 = (u7 + 1) % Attribute3;
                task.wait(1 / Attribute4);
            end;
        end);
    end;

    local function stopAnimation() -- Line: 52
        -- upvalues: u8 (ref), u7 (ref), u2 (ref), Attribute (copy), u1 (copy), u3 (ref), u4 (ref)
        u8 = false;
        u7 = 0;

        if u2 then
            return;
        end;

        local math_floor_ret = math.floor(u7 / Attribute);
        u1.ImageRectOffset = Vector2.new(u7 % Attribute * u3, math_floor_ret * u4);
    end;

    local u9 = {};
    local AttributeChangedSignal = u1:GetAttributeChangedSignal("FPS");
    table.insert(u9, AttributeChangedSignal:Connect(function() -- Line: 60
        -- upvalues: Attribute4 (ref), u1 (copy)
        Attribute4 = u1:GetAttribute("FPS");
    end));
    local AttributeChangedSignal2 = u1:GetAttributeChangedSignal("TOTAL_FRAMES");
    table.insert(u9, AttributeChangedSignal2:Connect(function() -- Line: 64
        -- upvalues: Attribute3 (ref), u1 (copy), u7 (ref)
        Attribute3 = u1:GetAttribute("TOTAL_FRAMES");
        u7 = math.min(u7, Attribute3 - 1);
    end));
    local AttributeChangedSignal3 = u1:GetAttributeChangedSignal("IMAGE_WIDTH");
    table.insert(u9, AttributeChangedSignal3:Connect(function() -- Line: 69
        -- upvalues: Attribute5 (ref), u1 (copy), u3 (ref), Attribute (copy), u5 (ref), u4 (ref), u6 (ref), u2 (ref), u7 (ref)
        Attribute5 = u1:GetAttribute("IMAGE_WIDTH");
        u3 = Attribute5 / Attribute;
        u5 = u3 / u4;
        u6.AspectRatio = u5;
        u1.ImageRectSize = Vector2.new(u3, u4);

        if u2 then
            return;
        end;

        local math_floor_ret = math.floor(u7 / Attribute);
        u1.ImageRectOffset = Vector2.new(u7 % Attribute * u3, math_floor_ret * u4);
    end));
    local AttributeChangedSignal4 = u1:GetAttributeChangedSignal("IMAGE_HEIGHT");
    table.insert(u9, AttributeChangedSignal4:Connect(function() -- Line: 78
        -- upvalues: Attribute6 (ref), u1 (copy), u4 (ref), Attribute2 (copy), u5 (ref), u3 (ref), u6 (ref), u2 (ref), u7 (ref), Attribute (copy)
        Attribute6 = u1:GetAttribute("IMAGE_HEIGHT");
        u4 = Attribute6 / Attribute2;
        u5 = u3 / u4;
        u6.AspectRatio = u5;
        u1.ImageRectSize = Vector2.new(u3, u4);

        if u2 then
            return;
        end;

        local math_floor_ret = math.floor(u7 / Attribute);
        u1.ImageRectOffset = Vector2.new(u7 % Attribute * u3, math_floor_ret * u4);
    end));

    if u1:GetAttribute("Playing") and not u8 then
        u8 = true;
        task.spawn(function() -- Line: 43
            -- upvalues: u8 (ref), u2 (ref), u7 (ref), Attribute (copy), u1 (copy), u3 (ref), u4 (ref), Attribute3 (ref), Attribute4 (ref)
            while u8 and not u2 do
                if not u2 then
                    local math_floor_ret = math.floor(u7 / Attribute);
                    u1.ImageRectOffset = Vector2.new(u7 % Attribute * u3, math_floor_ret * u4);
                end;

                u7 = (u7 + 1) % Attribute3;
                task.wait(1 / Attribute4);
            end;
        end);
    end;

    local AttributeChangedSignal5 = u1:GetAttributeChangedSignal("Playing");
    table.insert(u9, AttributeChangedSignal5:Connect(function() -- Line: 91
        -- upvalues: u1 (copy), u8 (ref), u2 (ref), u7 (ref), Attribute (copy), u3 (ref), u4 (ref), Attribute3 (ref), Attribute4 (ref)
        if u1:GetAttribute("Playing") then
            if u8 then
                return;
            end;

            u8 = true;
            task.spawn(function() -- Line: 43
                -- upvalues: u8 (ref), u2 (ref), u7 (ref), Attribute (ref), u1 (ref), u3 (ref), u4 (ref), Attribute3 (ref), Attribute4 (ref)
                while u8 and not u2 do
                    if not u2 then
                        local math_floor_ret = math.floor(u7 / Attribute);
                        u1.ImageRectOffset = Vector2.new(u7 % Attribute * u3, math_floor_ret * u4);
                    end;

                    u7 = (u7 + 1) % Attribute3;
                    task.wait(1 / Attribute4);
                end;
            end);

            return;
        end;

        u8 = false;
        u7 = 0;

        if u2 then
            return;
        end;

        local math_floor_ret = math.floor(u7 / Attribute);
        u1.ImageRectOffset = Vector2.new(u7 % Attribute * u3, math_floor_ret * u4);
    end));

    if not u2 then
        local math_floor_ret = math.floor(u7 / Attribute);
        u1.ImageRectOffset = Vector2.new(u7 % Attribute * u3, math_floor_ret * u4);
    end;

    return function() -- Line: 101
        -- upvalues: u2 (ref), u8 (ref), u9 (copy)
        u2 = true;
        u8 = false;

        for _, v in u9 do
            v:Disconnect();
        end;
    end;
end, { game.Players, workspace });