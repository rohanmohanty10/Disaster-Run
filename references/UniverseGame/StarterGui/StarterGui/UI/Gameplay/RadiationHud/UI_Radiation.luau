  

 

local function Lerp(p1, p2, p3) -- Line: 1
    return p1 + (p2 - p1) * p3;
end;

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(u4) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy)
    local Parent = script.Parent;
    local Rad = Parent.Rad;
    local Tether = Parent.Tether;
    u4.Knit.OnStart():await();
    require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    require(ReplicatedStorage.ReplicatedModules.Types);
    local ReplicatedRoot = ReplicatedStorage.ReplicatedRoot;
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
    local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
    local u5 = Core.GetClientService("LabService");
    local u6 = Fusion.Value(false);
    local u7 = Fusion.Value(0);
    local u8 = Fusion.Value(0);
    local u9 = Fusion.Value(false);
    local u10 = Fusion.Computed(function() -- Line: 34
        -- upvalues: u8 (copy)
        return u8:get() >= 100;
    end);
    local u11 = Trove.new();

    local function OnCharacterAdded(u12) -- Line: 41
        -- upvalues: u11 (copy), u6 (copy), u7 (copy), EffectsHandler (copy), u8 (copy)
        u11:Destroy();
        u11:AttachToInstance(u12);
        u6:set(false);
        u7:set(0);
        u11:Connect(u12:GetAttributeChangedSignal("SpaceRadiation"), function() -- Line: 48
            -- upvalues: u12 (copy), u6 (ref), u7 (ref), EffectsHandler (ref)
            local v13 = u12:GetAttribute("SpaceRadiation");

            if v13 and v13 >= 0 then
                u6:set(true);
                u7:set((math.clamp(v13, 0, 100)));

                if v13 >= 95 then
                    EffectsHandler.CallEffect("Space_Radiation", u12, {});
                end;
            elseif not v13 then
                u6:set(false);
                u7:set(0);
            end;
        end);
        u11:Connect(u12:GetAttributeChangedSignal("TetherCharge"), function() -- Line: 64
            -- upvalues: u12 (copy), u8 (ref)
            local v14 = u12:GetAttribute("TetherCharge");

            if v14 and v14 >= 0 then
                u8:set((math.clamp(v14, 0, 100)));

                return;
            end;

            if not v14 then
                u8:set(0);
            end;
        end);
    end;

    local u15 = 0;

    local function ActivateTether() -- Line: 76
        -- upvalues: u15 (ref), u5 (copy)
        if os.clock() - u15 < 0.3 then
            return;
        end;

        local v16 = u5:RequestTetherReturn():expect();
        print(v16);
        u15 = os.clock();
    end;

    Fusion.Hydrate(Rad.RadLabel)({
        Text = Fusion.Computed(function() -- Line: 88
            -- upvalues: u7 (copy)
            local v17 = u7:get();

            return `RAD - {math.round(v17)}%`;
        end)
    });
    local u18 = Color3.fromRGB(158, 255, 128);
    local u19 = Color3.fromRGB(255, 99, 99);
    Fusion.Hydrate(Rad.RadFill)({
        ImageColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 97
            -- upvalues: u18 (copy), u19 (copy), u7 (copy)
            local v20 = u7:get() / 100;

            return u18:Lerp(u19, (math.clamp(v20, 0, 1)));
        end), 35, 1)
    });
    Fusion.Hydrate(Rad.RadFill.Gradient)({
        Rotation = Fusion.Spring(Fusion.Computed(function() -- Line: 103
            -- upvalues: u7 (copy)
            local v21 = u7:get() / 100;
            local v22 = math.clamp(v21, 0, 1);

            return math.lerp(-90, 90, v22);
        end), 28, 0.85)
    });
    Fusion.Hydrate(Tether.Bar)({
        Size = Fusion.Spring(Fusion.Computed(function() -- Line: 109
            -- upvalues: u8 (copy)
            local fromScale = UDim2.fromScale;
            local v23 = u8:get() / 100;

            return fromScale(math.clamp(v23, 0, 1), 1);
        end), 28, 0.85)
    });
    Fusion.Hydrate(Tether.TetherLabel)({
        Text = Fusion.Computed(function() -- Line: 115
            -- upvalues: u8 (copy)
            local v24 = u8:get();

            return `TETHER - {math.round(v24)}%`;
        end)
    });
    Fusion.Hydrate(Tether)({
        Position = Fusion.Spring(Fusion.Computed(function() -- Line: 121
            -- upvalues: u10 (copy)
            if u10:get() then
                return UDim2.fromScale(0.5, 0.75);
            end;

            return UDim2.fromScale(0.5, 0.58);
        end), 28, 0.85)
    });
    Fusion.Hydrate(Parent.ReturnButton)({
        Visible = u10,
        [Fusion.OnEvent("MouseButton1Click")] = ActivateTether
    });
    local u26 = Fusion.Tween(Fusion.Computed(function() -- Line: 132
        -- upvalues: u9 (copy), u6 (copy)
        local v25 = u9:get();

        return u6:get() and UDim2.fromScale(0.5, v25 and 0.685 or 0.79) or UDim2.fromScale(0.5, 1.3);
    end), TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut));
    Fusion.Hydrate(Parent)({
        Visible = Fusion.Computed(function() -- Line: 138
            -- upvalues: u6 (copy), u26 (copy)
            return u6:get() and true or u26:get().Y.Scale < 1.25;
        end),
        Position = u26
    });
    Fusion.Observer(u10):onChange(function() -- Line: 145
        -- upvalues: u10 (copy), u4 (copy)
        if u10:get() then
            u4:ShowSelfNotification(
                "<font color=\"rgb(108,172,255)\"><b>[TETHER]</b></font><br /><b>Charge completed.</b> Escape available.",
                3.5
            );
            script.TetherWarning:Play();
        end;
    end);

    if u4.Character then
        task.spawn(OnCharacterAdded, u4.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(OnCharacterAdded);
    LocalPlayer:GetAttributeChangedSignal("InMinigame"):Connect(function() -- Line: 157
        -- upvalues: LocalPlayer (ref), u9 (copy)
        u9:set(LocalPlayer:GetAttribute("InMinigame") ~= nil);
    end);
    debug.setmemorycategory("RadiationHud");
end;