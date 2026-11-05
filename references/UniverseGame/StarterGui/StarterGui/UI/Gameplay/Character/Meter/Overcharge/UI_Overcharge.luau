  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
local Fusion = require(ReplicatedRoot.Libraries.Interface.Fusion);
local RunService = game:GetService("RunService");

return function(p1) -- Line: 9
    -- upvalues: Trove (copy), Fusion (copy), RunService (copy)
    local Parent = script.Parent;
    local Parent2 = Parent.Parent;
    local u2 = Trove.new();
    local u3 = Fusion.Value(false);
    local u4 = Fusion.Value(false);
    local u5 = Fusion.Value(0);
    local u6 = Fusion.Value(100);
    local u8 = Fusion.Spring(Fusion.Computed(function() -- Line: 19
        -- upvalues: u3 (copy), u5 (copy), u6 (copy)
        if u3:get() then
            return 1;
        end;

        local v7 = u5:get() / u6:get();

        return math.clamp(v7, 0, 1);
    end), 48);
    local u9 = Fusion.Value(UDim2.new(0, 0, 1, 0));
    local u10 = Fusion.Value(Color3.fromRGB(0, 200, 255));
    local u11 = Fusion.Computed(function() -- Line: 29
        -- upvalues: u3 (copy), u9 (copy), u8 (copy)
        if u3:get() then
            return u9:get();
        end;

        return UDim2.new(u8:get(), 0, 1, 0);
    end);
    local v13 = Fusion.Computed(function() -- Line: 35
        -- upvalues: u11 (copy)
        local v12 = u11:get();

        return UDim2.new(1 + (1 - v12.X.Scale), 0, 1, 0);
    end);
    local u14 = Fusion.Computed(function() -- Line: 40
        -- upvalues: u3 (copy), u5 (copy)
        return u3:get() and true or u5:get() > 0;
    end);
    local u15 = Fusion.Value(0);
    local v16 = Fusion.Computed(function() -- Line: 53
        -- upvalues: u14 (copy)
        return u14:get() and 0.5 or 1;
    end);
    Fusion.Hydrate(Parent.Container.Bar)({
        Size = u11
    });
    Fusion.Hydrate(Parent.Container.Bar.Main)({
        Size = v13
    });
    Fusion.Hydrate(Parent.Container.Bar.Main.ImageLabel)({
        ImageColor3 = u10,
        ImageTransparency = Fusion.Computed(function() -- Line: 71
            -- upvalues: u14 (copy)
            return u14:get() and 0 or 1;
        end)
    });
    Fusion.Hydrate(Parent.Container.Bar.Shine)({
        Size = v13
    });
    Fusion.Hydrate(Parent.Container.Bar.Shine.Back)({
        ImageTransparency = v16
    });
    Fusion.Hydrate(Parent.Container.Bar.Shine.Front)({
        ImageTransparency = v16
    });
    Fusion.Hydrate(Parent.Container.Bar.Shine.Back.UIGradient)({
        Offset = Fusion.Computed(function() -- Line: 92
            -- upvalues: u15 (copy)
            local v17 = u15:get();

            return Vector2.new(-1 + v17, 0);
        end)
    });
    Fusion.Hydrate(Parent.Container.Bar.Shine.Front.UIGradient)({
        Offset = Fusion.Computed(function() -- Line: 99
            -- upvalues: u15 (copy)
            local v18 = u15:get();

            return Vector2.new(-1 + (1 + v18) % 2, 0);
        end)
    });
    Fusion.Hydrate(Parent.Container.Background)({
        ImageColor3 = u10,
        ImageTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 107
            -- upvalues: u3 (copy), u5 (copy)
            return u3:get() and 0 or (u5:get() > 0 and 0.5 or 1);
        end), 48)
    });

    local function BindAttribute(u19, u20, u21, u22) -- Line: 119
        -- upvalues: u2 (copy)
        local function UpdateAttribute() -- Line: 120
            -- upvalues: u19 (copy), u20 (copy), u21 (copy), u22 (copy)
            local v23 = u19:GetAttribute(u20);

            if v23 == nil then
                v23 = u22;
            end;

            u21:set(v23);
        end;

        local v24 = u19:GetAttribute(u20);

        if v24 == nil then
            v24 = u22;
        end;

        u21:set(v24);
        u2:Connect(u19:GetAttributeChangedSignal(u20), function() -- Line: 125
            -- upvalues: u19 (copy), u20 (copy), u21 (copy), u22 (copy)
            local v25 = u19:GetAttribute(u20);

            if v25 == nil then
                v25 = u22;
            end;

            u21:set(v25);
        end);
        u2:Add(function() -- Line: 128
            -- upvalues: u21 (copy), u22 (copy)
            u21:set(u22);
        end);
    end;

    local function Update(p26) -- Line: 133
        -- upvalues: u9 (copy), Parent2 (copy), u15 (copy)
        if u9:get() ~= Parent2.Container.Bar.Main.Size then
            u9:set(Parent2.Container.Bar.Main.Size);
        end;

        u15:set((u15:get() + p26 * 2) % 2);
    end;

    local function CharacterAdded(p27) -- Line: 143
        -- upvalues: u2 (copy), BindAttribute (copy), u3 (copy), u4 (copy), u5 (copy), u6 (copy), u10 (copy), RunService (ref), Update (copy)
        u2:Destroy();
        BindAttribute(p27, "FullPower", u3, false);
        BindAttribute(p27, "Overcharging", u4, false);
        BindAttribute(p27, "Overcharge", u5, 0);
        BindAttribute(p27, "MaxOvercharge", u6, 100);
        BindAttribute(p27, "MeterColor", u10, Color3.fromRGB(0, 200, 255));
        u2:Connect(RunService.PreRender, Update);
    end;

    local function CharacterRemoving(p28) -- Line: 153
        -- upvalues: u2 (copy)
        u2:Destroy();
    end;

    if p1.Character then
        CharacterAdded(p1.Character);
    end;

    p1.Player.CharacterAdded:Connect(CharacterAdded);
    p1.Player.CharacterRemoving:Connect(CharacterRemoving);
    task.delay(0.5, function() -- Line: 163
        -- upvalues: Parent (copy)
        Parent.Visible = true;
    end);
end;