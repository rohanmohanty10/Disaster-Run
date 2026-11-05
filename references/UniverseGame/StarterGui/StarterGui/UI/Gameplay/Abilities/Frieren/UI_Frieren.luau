  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");

return function(u1) -- Line: 4
    -- upvalues: ReplicatedStorage (copy)
    local Parent = script.Parent;
    local Trove = require(u1.Knit.Util.Trove);
    require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
    require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    local Cores = script:WaitForChild("Cores");

    local function Setup(u2) -- Line: 15
        -- upvalues: Parent (copy), u1 (copy), Trove (copy), Cores (copy), Fusion (copy)
        Parent.Visible = false;

        if tonumber(u1.Player.Data.Ability.Value) ~= 3333 then
            return;
        end;

        Parent.Visible = true;
        local v3 = Trove.new();
        v3:AttachToInstance(u2);
        local u4 = v3:Clone(Cores);
        u4.Parent = Parent;
        u4.Visible = true;
        local u5 = Fusion.Value(0);
        local u6 = Fusion.Value(u2:GetAttribute("TriangulationActive") or false);

        for i = 1, 5 do
            local v7 = script:FindFirstChild("Core"):Clone();
            v7.LayoutOrder = i;
            v7.Parent = u4;
            v3:Add(v7);
            local u8 = Fusion.Computed(function() -- Line: 41
                -- upvalues: u5 (ref), i (copy)
                return i <= u5:get() and 0 or 1;
            end);
            local u9 = Fusion.Spring(u8, 15, 0.8);
            Fusion.Hydrate(v7)({
                Visible = Fusion.Computed(function() -- Line: 48
                    -- upvalues: u9 (copy)
                    return u9:get() < 0.99;
                end),
                Size = Fusion.Spring(Fusion.Computed(function() -- Line: 51
                    -- upvalues: u8 (copy)
                    return u8:get() == 1 and UDim2.fromScale(0.03, 1) or UDim2.fromScale(0.1, 1);
                end), 20, 0.8)
            });

            for _, child in v7:GetChildren() do
                if child:IsA("ImageLabel") then
                    local v10 = Fusion.Hydrate(child);
                    local v11 = {
                        Rotation = Fusion.Computed(function() -- Line: 59
                            -- upvalues: i (copy)
                            return i % 2 == 0 and 180 or 0;
                        end),
                        ImageTransparency = u9
                    };
                    local v12;

                    if child.Name == "Glow" and i % 2 == 0 then
                        v12 = UDim2.fromScale(0.5, 0.5);
                    else
                        v12 = nil;
                    end;

                    v11.Position = v12;
                    v10(v11);
                end;
            end;
        end;

        Fusion.Hydrate(Parent.TriLabel)({
            Text = Fusion.Computed(function() -- Line: 70
                -- upvalues: u6 (ref)
                return u6:get() and "TRIANGULATION: ACTIVE" or "TRIANGULATION: INACTIVE";
            end),
            TextColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 73
                -- upvalues: u6 (ref)
                return u6:get() and Color3.fromRGB(75, 255, 120) or Color3.fromRGB(255, 97, 97);
            end), 25, 0.8)
        });
        Fusion.Hydrate(Parent.CoresLabel)({
            Text = Fusion.Computed(function() -- Line: 79
                -- upvalues: u5 (ref)
                return `CORES: {u5:get() or 0}`;
            end)
        });
        v3:Add(function() -- Line: 84
            -- upvalues: u6 (ref), u5 (ref)
            u6 = nil;
            u5 = nil;
        end);
        v3:Connect(u2:GetAttributeChangedSignal("Cores"), function() -- Line: 91
            -- upvalues: u5 (ref), u2 (copy)
            u5:set((u2:GetAttribute("Cores")));
        end);
        v3:Connect(u2:GetAttributeChangedSignal("TriangulationActive"), function() -- Line: 94
            -- upvalues: u6 (ref), u2 (copy)
            u6:set((u2:GetAttribute("TriangulationActive")));
        end);
        local u13 = true;
        v3:Add(function() -- Line: 100
            -- upvalues: u13 (ref)
            u13 = false;
        end);
        task.spawn(function() -- Line: 104
            -- upvalues: u13 (ref), Parent (ref), u4 (copy)
            task.wait();

            while u13 and Parent.Visible do
                task.wait(0.02);
                local v14 = os.clock();

                for _, child in u4:GetChildren() do
                    if child:IsA("Frame") then
                        local LayoutOrder = child.LayoutOrder;

                        for _, child2 in child:GetChildren() do
                            child2.ImageColor3 = Color3.fromHSV(0.375, 0.705882, math.cos(v14 * 1.75 - LayoutOrder) * 0.2 + 0.8);
                        end;
                    end;
                end;
            end;
        end);
    end;

    if u1.Character then
        Setup(u1.Character);
    end;

    u1.Player.CharacterAdded:Connect(Setup);
end;