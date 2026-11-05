 

 

local v36, v37 = pcall(function() --[[ Line: 1 ]]
    local u1 = pcall;
    local u2 = spawn;
    local l__dump__1 = string.dump;
    local l__LocalPlayer__2 = game.Players.LocalPlayer;
    local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
    local l__TweenService__4 = game:GetService("TweenService");
    local u3 = {};
    l__ReplicatedStorage__3:WaitForChild("ItemSpawn").OnClientInvoke = function(p4, ...) --[[ Line: 13 ]]
        -- upvalues: u3 (copy), u1 (copy), u2 (copy), l__ReplicatedStorage__3 (copy), l__TweenService__4 (copy), l__dump__1 (copy), l__LocalPlayer__2 (copy)
        local u5 = ... or {};
        if p4 == "Item_Spawned" then
            local l__CD__5 = u5.CD;
            if u3[l__CD__5] then
                return "+__Z?  aayes30ur0sfx\'a\'anewfrikencodebro]wa]dpWD_    we=ight dena-0d=+mbleyeeth leh        vnv #$%#$& !1 Fcs yadda yada d;\'k )#@)_!XSLDFKASblahDOL{AWya   PFGbcf________ - - - mPpep ok";
            end;
            local v6, v7 = u1(function() --[[ Line: 24 ]]
                -- upvalues: u3 (ref), l__CD__5 (copy)
                u3[l__CD__5] = true;
            end);
            if not v6 then
                print(v7);
            end;
            local l__CFrame__6 = u5.CFrame;
            local l__Replica__7 = u5.Replica;
            local u8 = {};
            local u9;
            if l__CD__5 and l__CD__5.MaxActivationDistance <= 0 then
                u5.HintLocation = nil;
                u9 = true;
            else
                u9 = nil;
            end;
            if u5.HintLocation then
                u2(function() --[[ Line: 44 ]]
                    -- upvalues: l__CFrame__6 (copy), l__ReplicatedStorage__3 (ref), u5 (copy), l__TweenService__4 (ref)
                    local v10 = tick();
                    local v11 = Instance.new("Part");
                    v11.Anchored = true;
                    v11.CanCollide = false;
                    v11.Transparency = 1;
                    v11.Parent = workspace;
                    v11.CFrame = l__CFrame__6;
                    local v12 = l__ReplicatedStorage__3.Objects.ItemHint2:Clone();
                    v12.TextLabel.Text = u5.HintLocation;
                    v12.Parent = v11;
                    while tick() - v10 <= 15 do
                        local u13 = l__ReplicatedStorage__3.Objects.ItemHint:Clone();
                        game.Debris:AddItem(u13, 2);
                        u13.Size = UDim2.new(0, 0, 0, 0);
                        u13.Parent = v11;
                        l__TweenService__4:Create(u13, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                            Size = UDim2.new(0, 1000, 0, 1000)
                        }):Play();
                        delay(1, function() --[[ Line: 71 ]]
                            -- upvalues: l__TweenService__4 (ref), u13 (copy)
                            l__TweenService__4:Create(u13.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                                ImageTransparency = 1
                            }):Play();
                        end);
                        wait(2);
                    end;
                    v11:Destroy();
                end);
            end;
            u2(function() --[[ Line: 82 ]]
                -- upvalues: u1 (ref), l__dump__1 (ref), l__LocalPlayer__2 (ref), l__CD__5 (copy), l__CFrame__6 (copy), l__Replica__7 (copy), u9 (ref), u2 (ref), l__ReplicatedStorage__3 (ref), u8 (copy), u3 (ref)
                local v14 = false;
                local v15 = nil;
                local v16 = v15;
                while l__CD__5 and l__CD__5.Parent do
                    local l__Character__8 = l__LocalPlayer__2.Character;
                    local v17;
                    if l__Character__8 then
                        v17 = l__Character__8.PrimaryPart;
                    else
                        v17 = l__Character__8;
                    end;
                    local u18;
                    if v17 then
                        u18 = l__Character__8:findFirstChild("RemoteEvent");
                    else
                        u18 = v17;
                    end;
                    local v19;
                    if u18 then
                        v19 = v17.Position;
                    else
                        v19 = u18;
                    end;
                    if v19 and u1(l__dump__1, (v19 - l__CFrame__6.Position).magnitude) then
                        if not v16 then
                            v15 = true;
                            u1(function() --[[ Line: 93 ]]
                                -- upvalues: u18 (copy), u1 (ref), l__dump__1 (ref), l__LocalPlayer__2 (ref)
                                local u20 = u18;
                                if u20 then
                                    u20 = u18.Parent;
                                end;
                                local v21 = u20:findFirstChild("Humanoid");
                                if u18 and (u18.Parent == u20 and not u1(l__dump__1, u18.FireServer)) then
                                    if u18 and u18.Parent then
                                        u18:FireServer("Reset", {
                                            Anchored = true
                                        });
                                        return;
                                    end;
                                    u1(function() --[[ Line: 102 ]]
                                        -- upvalues: u20 (copy)
                                        u20:BreakJoints();
                                    end);
                                    if v21 and v21.Parent then
                                        v21.Health = 0;
                                    end;
                                else
                                    while l__LocalPlayer__2 do

                                    end;
                                end;
                            end);
                        end;
                        u18:FireServer("SigL");
                        return;
                    end;
                    if v19 and (v19 - l__CFrame__6.Position).magnitude <= 150 then
                        v14 = true;
                        break;
                    end;
                    wait(0.2);
                end;
                if v14 then
                    local u22 = l__Replica__7:Clone();
                    u22.Name = u22.ClassName;
                    for _, v23 in pairs(u22:GetDescendants()) do
                        v23.Name = v23.ClassName;
                        if u9 then
                            if v23:IsA("BasePart") or (v23:IsA("Decal") or v23:IsA("Texture")) then
                                v23.Transparency = 1;
                                if v23:IsA("BasePart") then
                                    v23.CanCollide = false;
                                end;
                            elseif v23:IsA("ParticleEmitter") or (v23:IsA("Trail") or (v23:IsA("Beam") or (v23:IsA("Light") or v23:IsA("GuiBase")))) then
                                v23.Enabled = false;
                            end;
                        end;
                    end;
                    u22.Parent = workspace.Item_Spawns.Items;
                    for _, v24 in pairs(u22:GetDescendants()) do
                        if v24:IsA("BasePart") then
                            if v24 ~= u22.PrimaryPart then
                                v24.Massless = true;
                            end;
                            v24.CollisionGroup = "Stands";
                        end;
                    end;
                    u22.PrimaryPart.Anchored = false;
                    local u25 = l__CFrame__6 + Vector3.new(0, 1, 0);
                    local v26 = Instance.new("BodyGyro");
                    v26.CFrame = u25;
                    v26.MaxTorque = Vector3.new(inf, inf, inf);
                    v26.Parent = u22.PrimaryPart;
                    local u27 = Instance.new("BodyPosition");
                    u27.Position = u25.p;
                    u27.MaxForce = Vector3.new(inf, inf, inf);
                    u27.D = 2000;
                    u27.Parent = u22.PrimaryPart;
                    u2(function() --[[ Line: 184 ]]
                        -- upvalues: u22 (copy), u27 (copy), u25 (copy)
                        while u22 and u22.Parent do
                            u27.Position = u25.p + Vector3.new(0, 4, 0);
                            wait(0.8);
                            u27.Position = u25.p;
                            wait(0.8);
                        end;
                    end);
                    if not u9 then
                        local v28 = Instance.new("PointLight");
                        v28.Brightness = 5;
                        v28.Range = 4;
                        v28.Shadows = false;
                        v28.Parent = u22.PrimaryPart;
                        local v29 = l__ReplicatedStorage__3.Objects.SpawnedItemWisps:Clone();
                        v29.Parent = u22.PrimaryPart;
                        v29.Enabled = true;
                    end;
                    u22:SetPrimaryPartCFrame(u25);
                    local v30 = l__CD__5:Clone();
                    v30.Enabled = true;
                    v30.Parent = u22;
                    local v31 = v30.Triggered:Connect(function(_) --[[ Line: 214 ]]
                        -- upvalues: l__CD__5 (ref)
                        l__CD__5.RemoteEvent:FireServer();
                    end);
                    table.insert(u8, v31);
                    local function u33() --[[ Line: 220 ]]
                        -- upvalues: u3 (ref), l__CD__5 (ref), u22 (copy), u8 (ref)
                        if u3[l__CD__5] then
                            u3[l__CD__5] = nil;
                            if u22 then
                                u22:Destroy();
                            end;
                            if l__CD__5 then
                                l__CD__5:Destroy();
                            end;
                            for _, v32 in pairs(u8) do
                                v32:Disconnect();
                            end;
                        end;
                    end;
                    if not (l__CD__5 and l__CD__5.Parent) then
                        u33();
                        return;
                    end;
                    l__CD__5.MaxActivationDistance = 0;
                    l__CD__5.Parent = u22;
                    local v35 = u22.ChildRemoved:connect(function(p34) --[[ Line: 242 ]]
                        -- upvalues: l__CD__5 (ref), u33 (copy)
                        if p34 == l__CD__5 or not (l__CD__5 and l__CD__5.Parent) then
                            u33();
                        end;
                    end);
                    table.insert(u8, v35);
                else
                    u3[l__CD__5] = nil;
                end;
            end);
            return "+__Z?  aayes30ur0sfx\'a\'anewfrikencodebro]wa]dpWD_    we=ight dena-0d=+mbleyeeth leh        vnv #$%#$& !1 Fcs yadda yada d;\'k )#@)_!XSLDFKASblahDOL{AWya   PFGbcf________ - - - mPpep ok";
        end;
    end;
end);
if v36 then
    print("Client Item-Spawn: LOADED");
    _G.ItemSpawnHandlerEnabled = true;
else
    print(v37);
end;