  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");

return function(u1) -- Line: 4
    -- upvalues: ReplicatedStorage (copy)
    local Parent = script.Parent;
    local Trove = require(u1.Knit.Util.Trove);
    require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
    require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    local CombatStar = script:WaitForChild("CombatStar");
    local u2 = {
        TLC = {
            "Amethyst",
            -45,
            UDim2.fromScale(-0.15, -0.15),
            UDim2.fromScale(0.65, 0.65)
        },
        TRC = {
            "Cinnabar",
            45,
            UDim2.fromScale(0.15, -0.15),
            UDim2.fromScale(0.35, 0.65)
        },
        BLC = { "None", -135, UDim2.fromScale(-0.15, 0.15) },
        BRC = { "None", 135, UDim2.fromScale(0.15, 0.15) }
    };
    local u3 = {
        Amethyst = Color3.fromRGB(135, 9, 255),
        Cinnabar = Color3.fromRGB(255, 67, 42)
    };

    local function Setup(u4) -- Line: 28
        -- upvalues: Parent (copy), u1 (copy), Trove (copy), CombatStar (copy), Fusion (copy), u2 (copy), u3 (copy)
        Parent.Visible = false;

        if tonumber(u1.Player.Data.Ability.Value) ~= 8008135 then
            return;
        end;

        Parent.Visible = true;
        local v5 = Trove.new();
        v5:AttachToInstance(u4);
        local v6 = v5:Clone(CombatStar);
        v6.Parent = Parent;
        v6.Visible = true;
        local Effect = v6:FindFirstChild("Effect");
        local u7 = Fusion.Value(u4:GetAttribute("Gemstone") or "Amethyst");
        local u8 = Fusion.Value(u4:GetAttribute("InfusedGemstone"));
        local u9 = Fusion.Tween(Fusion.Computed(function() -- Line: 48
            -- upvalues: u8 (copy)
            return u8:get() and 1 or 0;
        end), TweenInfo.new(0.25));
        local v10 = Fusion.Computed(function() -- Line: 52
            -- upvalues: u2 (ref), u7 (copy)
            for _, v in u2 do
                if v[1] == u7:get() then
                    return v[2];
                end;
            end;
        end);

        for i, v in u2 do
            local u11 = v[1];
            local _ = v[2];
            local _ = v[3];
            local u12 = v[4];
            local v13 = v6:FindFirstChild(i);

            if v13 then
                Fusion.Hydrate(v13)({
                    ImageColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 71
                        -- upvalues: u8 (copy), u3 (ref), u7 (copy), u11 (copy)
                        local v14 = u8:get();

                        return v14 and u3[v14] or (u7:get() == u11 and u3[u11] or Color3.fromRGB(0, 0, 0));
                    end), 8, 0.65),
                    Position = Fusion.Spring(Fusion.Computed(function() -- Line: 75
                        -- upvalues: u8 (copy), v (copy)
                        return u8:get() and v[3] or UDim2.fromScale(0, 0);
                    end), 8, 0.75)
                });
                local Container = v13:FindFirstChild("Container");
                local Position = Container.Position;

                if Container and u11 ~= "None" then
                    local Icon = Container:FindFirstChild("Icon");
                    local u15 = UDim2.fromScale(Icon.Size.X.Scale, Icon.Size.Y.Scale);
                    local v16 = Fusion.Spring(Fusion.Computed(function() -- Line: 87
                        -- upvalues: u8 (copy), u11 (copy), u12 (copy), Position (copy)
                        return u8:get() == u11 and u12 or Position;
                    end), 12, 0.75);
                    Fusion.Hydrate(Icon)({
                        ImageTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 92
                            -- upvalues: u7 (copy), u11 (copy)
                            return u7:get() == u11 and 0 or 0.7;
                        end), 8, 0.65),
                        ImageColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 95
                            -- upvalues: u7 (copy), u11 (copy)
                            return u7:get() == u11 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(152, 152, 152);
                        end), 8, 0.65),
                        Size = Fusion.Spring(Fusion.Computed(function() -- Line: 98
                            -- upvalues: u7 (copy), u11 (copy), u15 (copy)
                            return u7:get() == u11 and u15 + UDim2.fromScale(0.05, 0.05) or u15;
                        end), 8, 0.65)
                    });
                    Fusion.Hydrate(Container)({
                        Position = v16
                    });
                end;

                local DiamondShadow = v13:FindFirstChild("DiamondShadow");

                if DiamondShadow then
                    Fusion.Hydrate(DiamondShadow)({
                        ImageColor3 = u11 == "None" and Color3.fromRGB(0, 0, 0) or u3[u11],
                        ImageTransparency = u11 == "None" and 0.85 or 0.765
                    });
                end;
            end;
        end;

        Fusion.Hydrate(v6:FindFirstChild("Diamond"))({
            Rotation = Fusion.Spring(v10, 8, 0.65),
            ImageTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 119
                -- upvalues: u8 (copy)
                return u8:get() and 1 or 0;
            end), 30, 0.8)
        });
        Fusion.Hydrate(Effect)({
            ImageTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 125
                -- upvalues: u9 (copy)
                return u9:get() >= 0.75 and 0 or 1;
            end), 8, 0.75),
            ImageColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 129
                -- upvalues: u3 (ref), u8 (copy)
                return u3[u8:get()] or Color3.fromRGB(217, 142, 255);
            end), 35, 0.85)
        });
        v5:Connect(u4:GetAttributeChangedSignal("Gemstone"), function() -- Line: 149
            -- upvalues: u7 (copy), u4 (copy)
            u7:set((u4:GetAttribute("Gemstone")));
        end);
        v5:Connect(u4:GetAttributeChangedSignal("InfusedGemstone"), function() -- Line: 152
            -- upvalues: u8 (copy), u4 (copy)
            u8:set((u4:GetAttribute("InfusedGemstone")));
        end);
    end;

    if u1.Character then
        Setup(u1.Character);
    end;

    u1.Player.CharacterAdded:Connect(Setup);
end;