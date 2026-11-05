  

 

return function(u1) -- Line: 3
    local LocalPlayer = game.Players.LocalPlayer;
    local Parent = script.Parent.Parent;
    local Skins = Parent:WaitForChild("Skins");
    local StandCache = game.ReplicatedStorage:WaitForChild("StandCache");
    StandCache:SetAttribute("UserId", LocalPlayer.UserId);
    local Data = LocalPlayer:WaitForChild("Data");
    local u2 = nil;
    local Stands = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);
    local Skins2 = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Skins);
    local StatsHandler = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").StatsHandler);
    local ItemData = require(game.ReplicatedStorage.ReplicatedModules.ItemData);
    game.ReplicatedStorage:WaitForChild("Remotes");
    local u3 = u1.Knit.GetService("InventoryService");
    local u4 = u1.Knit.GetService("RigService");
    local u5 = {};
    local u6 = "";
    local u7 = {};
    local u8 = 1;
    local u9 = 0;
    local u10 = 0;
    local u11 = nil;
    local u12 = {};
    local u13 = os.time() + 1;
    pcall(function() -- Line: 39
        -- upvalues: u12 (ref), u3 (copy)
        u12 = u3:GetItems("SkinInventory"):expect();
    end);
    local u14 = {};

    local function ClearViewport(p15) -- Line: 45
        if p15:FindFirstChild("Camera") then
            p15.Camera:Destroy();
        end;

        if p15:FindFirstChild("WorldModel") then
            p15.WorldModel:Destroy();
        end;
    end;

    local function CreateViewport(p16, p17, p18, p19, p20, p21) -- Line: 54
        -- upvalues: Skins2 (copy), StatsHandler (copy), u10 (ref), Skins (copy), u11 (ref)
        local v22 = tostring(p19);
        tostring(p20);
        local v23 = Skins2.Funcs.GetSkin(p19, p20);
        local u24 = nil;
        local v25 = nil;
        local u26 = Skins2.Funcs.GetViewportSettings(v22, v23) or {};

        if p16:FindFirstChild("Camera") then
            p16.Camera:Destroy();
        end;

        if p16:FindFirstChild("WorldModel") then
            p16.WorldModel:Destroy();
        end;

        if p17 then
            local WorldModel = Instance.new("WorldModel");
            local u27 = p17:Clone();
            u27.Name = "Model";
            local v28 = u26 and u26.Offset or CFrame.new(0, 0, 0);
            local StandHumanoidRootPart = u27:FindFirstChild("StandHumanoidRootPart", true);

            if StandHumanoidRootPart then
                u24 = script.Character:Clone();
                u24:PivotTo(CFrame.new(0, 0, 0) * v28);
                u27:PivotTo(u24.HumanoidRootPart.CFrame);
                u27.Name = "Stand";
                u27.Parent = u24;
                local Weld = Instance.new("Weld");
                Weld.Part0 = u24.HumanoidRootPart;
                Weld.Part1 = StandHumanoidRootPart;
                Weld.Name = "Stand2Human";
                Weld.C0 = CFrame.new();
                Weld.Parent = Weld.Part0;
                v25 = u24.Humanoid;
                u24.Parent = WorldModel;
            else
                u27:PivotTo(CFrame.new(0, 0, 0) * v28);
                u27.Parent = WorldModel;
            end;

            local v29 = StatsHandler.GetStats(p18);
            local v30 = {};
            local v31 = {};

            if v29 and v29.Stats then
                local Summon = v29.Stats.Summon;

                if Summon then
                    v30 = Summon.IgnoreParts or (Summon.LeaveParts or {});
                    v31 = Summon.CustomTransparency or {};
                end;
            end;

            if not v30 and (u26 and u26.LeaveParts) then
                v30 = u26.LeaveParts;
            end;

            if not (u26 and u26.Visible) then
                for _, descendant in pairs(u27:GetDescendants()) do
                    if not table.find(v30, descendant.Name) and (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) then
                        local v32 = 0;

                        if v31[descendant.Name] then
                            v32 = v31[descendant.Name].SummonTransparency or v32;
                        end;

                        descendant.Transparency = v32;
                    end;
                end;
            end;

            if u26.TransparencyCallback then
                local success, result = pcall(u26.TransparencyCallback, v23, u27);

                if not success then
                    warn(result);
                end;
            end;

            WorldModel.Parent = p16;
            local Camera = Instance.new("Camera");
            Camera.Parent = p16;

            local function SetCameraCF() -- Line: 137
                -- upvalues: u24 (ref), u27 (copy), u26 (copy), Camera (copy), u10 (ref)
                local v36 = u26 and u26.Camera or function(p33, p34, p35) -- Line: 139
                    p33.CFrame = CFrame.Angles(0, math.rad(180 + p35), 0) * CFrame.new(0, 0, 4.25) * CFrame.Angles(-0.08726646259971647, 0, 0);
                end;

                if typeof(v36) ~= "function" then
                    return;
                end;

                pcall(v36, Camera, u24 or u27, u10);
            end;

            if p16 == Skins.ViewportFrame then
                u11 = SetCameraCF;
            end;

            if u26 then
                local v37 = u24 or u27;
                local v41 = u26 and (u26.Camera or function(p38, p39, p40) -- Line: 139
                    p38.CFrame = CFrame.Angles(0, math.rad(180 + p40), 0) * CFrame.new(0, 0, 4.25) * CFrame.Angles(-0.08726646259971647, 0, 0);
                end) or function(p38, p39, p40) -- Line: 139
                    p38.CFrame = CFrame.Angles(0, math.rad(180 + p40), 0) * CFrame.new(0, 0, 4.25) * CFrame.Angles(-0.08726646259971647, 0, 0);
                end;

                if typeof(v41) == "function" then
                    pcall(v41, Camera, v37, u10);
                end;

                if u26.Pose and v25 then
                    local Animation = Instance.new("Animation");
                    Animation.AnimationId = "rbxassetid://" .. tostring(u26.Pose);
                    Animation.Parent = u24;
                    local u42 = v25:LoadAnimation(Animation);
                    u42:Play(0, 1, 0);
                    task.spawn(function() -- Line: 161
                        -- upvalues: u42 (copy), Camera (copy), u24 (ref), u27 (copy), u26 (copy), u10 (ref)
                        local v43 = os.time() + 1;

                        repeat
                            task.wait();
                        until u42.Length ~= 0 or v43 < os.time();

                        if Camera then
                            local v44 = u24 or u27;
                            local v48 = u26 and u26.Camera or function(p45, p46, p47) -- Line: 139
                                p45.CFrame = CFrame.Angles(0, math.rad(180 + p47), 0) * CFrame.new(0, 0, 4.25) * CFrame.Angles(-0.08726646259971647, 0, 0);
                            end;

                            if typeof(v48) == "function" then
                                pcall(v48, Camera, v44, u10);
                            end;
                        end;
                    end);
                end;
            else
                local v49 = u24 or u27;
                local v53 = u26 and u26.Camera or function(p50, p51, p52) -- Line: 139
                    p50.CFrame = CFrame.Angles(0, math.rad(180 + p52), 0) * CFrame.new(0, 0, 4.25) * CFrame.Angles(-0.08726646259971647, 0, 0);
                end;

                if typeof(v53) == "function" then
                    pcall(v53, Camera, v49, u10);
                end;
            end;

            p16.CurrentCamera = Camera;

            return p16, u27;
        end;
    end;

    local function GetActiveSkinId(p54) -- Line: 176
        -- upvalues: Data (copy), u2 (ref)
        return Data.Ability.Value == p54 and Data.Skin.Value or u2[tostring(p54)];
    end;

    local function RefreshButtons() -- Line: 180
        -- upvalues: Stands (copy), u6 (ref), Skins (copy), u8 (ref), u7 (ref)
        if not Stands[u6] then
            Skins.Rotate.Visible = false;
            Skins.Skins.Buttons.Visible = false;

            return;
        end;

        Skins.Skins.Buttons.Visible = true;

        if u8 == 0 then
            Skins.Skins.Buttons.Left.Button.Visible = false;
            Skins.Skins.Buttons.Right.Button.Visible = false;
        else
            Skins.Skins.Buttons.Left.Button.Visible = u8 - 1 > 0;
            Skins.Skins.Buttons.Right.Button.Visible = u8 + 1 <= #u7;
        end;

        Skins.Rotate.Visible = true;
    end;

    local function GetStandModel(p55) -- Line: 197
        -- upvalues: u14 (copy), StandCache (copy), u4 (copy)
        if u14[p55] then
            return u14[p55];
        end;

        if StandCache:FindFirstChild(p55) or u4:RequestAbilityModel(p55):expect() then
            local v56 = StandCache:WaitForChild(p55, 1);

            if v56 and not u14[p55] then
                u14[p55] = v56:Clone();
            end;

            return u14[p55];
        end;
    end;

    local function Select(p57, p58) -- Line: 213
        -- upvalues: u11 (ref), Skins (copy), Stands (copy), Data (copy), u2 (ref), u6 (ref), u7 (ref), Skins2 (copy), u5 (copy), u8 (ref), u14 (copy), GetStandModel (copy), ItemData (copy), CreateViewport (copy), u9 (ref), u10 (ref), RefreshButtons (copy)
        u11 = nil;

        for _, child in pairs(Skins.Skins.Buttons:GetChildren()) do
            if child:IsA("Frame") then
                local ViewportFrame = child.Button.ViewportFrame;

                if ViewportFrame:FindFirstChild("Camera") then
                    ViewportFrame.Camera:Destroy();
                end;

                if ViewportFrame:FindFirstChild("WorldModel") then
                    ViewportFrame.WorldModel:Destroy();
                end;
            end;
        end;

        if Stands[p57] then
            local v59 = p58 or (Data.Ability.Value == p57 and Data.Skin.Value or u2[tostring(p57)]);
            u6 = p57;
            u7 = { "Default" };

            for i, _ in pairs(Skins2.Funcs.GetSkinsForAbility(p57)) do
                if u5[tostring(u6)] and u5[tostring(u6)][i] then
                    local v60 = tostring(i);
                    table.insert(u7, v60);
                end;
            end;

            u8 = table.find(u7, (tostring(v59))) or 1;
            local v61 = u7[u8];
            local v62 = `ABILITY_{p57}`;

            if not u14[v62] then
                GetStandModel(v62);
            end;

            local v63 = `SKIN_{p57}_{v61}`;
            local v64 = ItemData.GetItemInfo(v63);
            local v65 = Skins2.Funcs.GetSkin(p57, v61) or nil;

            if v61 ~= "Default" then
                v62 = v63;
            end;

            if v65 or v64 then
                if v64 then
                    v65 = v64.Name or v65;
                end;

                Skins.Label.Text = v65;
            else
                Skins.Label.Text = Stands[p57] or "ERROR";
            end;

            if (Data.Ability.Value == p57 and Data.Skin.Value or u2[tostring(p57)]) == v61 then
                Skins.Skins.Buttons.Middle.Button.Label.Text = "Equipped";
            else
                Skins.Skins.Buttons.Middle.Button.Label.Text = "Equip";
            end;

            local v66 = GetStandModel(v62);
            CreateViewport(Skins.ViewportFrame, v66, Stands[p57], p57, u7[u8]);

            if u8 ~= 0 then
                if u8 - 1 > 0 then
                    local v67 = u7[u8 - 1];
                    local v68 = GetStandModel((`SKIN_{p57}_{v67}`));
                    CreateViewport(Skins.Skins.Buttons.Left.Button.ViewportFrame, v68, Stands[p57], p57, v67);
                end;

                if u8 + 1 <= #u7 then
                    local v69 = u7[u8 + 1];
                    local v70 = GetStandModel((`SKIN_{p57}_{v69}`));
                    CreateViewport(Skins.Skins.Buttons.Right.Button.ViewportFrame, v70, Stands[p57], p57, v69);
                end;
            end;
        elseif not Stands[p57] or p57 == "nil" then
            u6 = "";
            Skins.Label.Text = "";
            u7 = {};
            u8 = 0;
            local ViewportFrame = Skins.ViewportFrame;

            if ViewportFrame:FindFirstChild("Camera") then
                ViewportFrame.Camera:Destroy();
            end;

            if ViewportFrame:FindFirstChild("WorldModel") then
                ViewportFrame.WorldModel:Destroy();
            end;
        end;

        u9 = 0;
        u10 = 0;
        RefreshButtons();
    end;

    local function Left() -- Line: 304
        -- upvalues: u1 (copy), Stands (copy), u6 (ref), u8 (ref), Select (copy), u7 (ref)
        u1:PlaySound("Click");

        if Stands[u6] and (u8 ~= 0 and u8 - 1 > 0) then
            Select(u6, u7[u8 - 1]);
        end;
    end;

    local function Middle() -- Line: 311
        -- upvalues: u1 (copy), Stands (copy), u6 (ref), Data (copy), u2 (ref), u7 (ref), u8 (ref), u13 (ref), u12 (ref), u3 (copy), LocalPlayer (copy), Skins (copy)
        u1:PlaySound("Click");

        if not Stands[u6] then
            return;
        end;

        local v71 = u6;

        if (Data.Ability.Value == v71 and Data.Skin.Value or u2[tostring(v71)]) == u7[u8] then
            return;
        end;

        local v72 = u6;
        local v73 = u7[u8];

        if u13 < os.time() then
            u13 = os.time() + 1;
            pcall(function() -- Line: 319
                -- upvalues: u12 (ref), u3 (ref)
                u12 = u3:GetItems("SkinInventory"):expect();
            end);
        end;

        warn(v72, v73);

        if v73 == "Default" then
            u3.SkinInventory:Fire({
                EquipSkin = false,
                AbilityId = v72
            });
            v73 = "0";
        else
            local v74 = nil;

            for i, v in u12 do
                if v._AbilityId == v72 and v._SkinId == v73 then
                    v74 = i;
                    break;
                end;
            end;

            u3.SkinInventory:Fire({
                EquipSkin = true,
                UUID = v74
            });
        end;

        task.wait(0.5);

        if LocalPlayer.Data.Skin.Value == v73 then
            Skins.Skins.Buttons.Middle.Button.Label.Text = "Equipped";

            return;
        end;

        Skins.Skins.Buttons.Middle.Button.Label.Text = "Equip";
    end;

    local function Right() -- Line: 355
        -- upvalues: u1 (copy), Stands (copy), u6 (ref), u8 (ref), u7 (ref), Select (copy)
        u1:PlaySound("Click");

        if Stands[u6] and (u8 ~= 0 and u8 + 1 <= #u7) then
            Select(u6, u7[u8 + 1]);
        end;
    end;

    local function CreateButtons() -- Line: 362
        -- upvalues: Skins (copy), u12 (ref), u5 (copy), Skins2 (copy), Stands (copy), u1 (copy), Select (copy), StandCache (copy), CreateViewport (copy)
        for _, child in pairs(Skins.Specs.ScrollingFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        for _, v in u12 do
            if v._AbilityId and v._SkinId then
                local v75 = tostring(v._AbilityId);

                if not u5[v75] then
                    u5[v75] = {};
                end;

                if not u5[v75][v._SkinId] then
                    u5[v75][v._SkinId] = true;
                end;
            end;
        end;

        warn(u5);

        for i, _ in u5 do
            if Skins2.Skins[i] ~= nil then
                local v76 = script.Container:Clone();
                v76.Name = Stands[tonumber(i)] or "[ERROR " .. i .. "]";
                v76.Button.Label.Text = v76.Name;
                v76.Visible = true;
                v76.Button.MouseButton1Down:Connect(function() -- Line: 391
                    -- upvalues: u1 (ref), Select (ref), i (copy)
                    u1:PlaySound("Click");
                    Select((tonumber(i)));
                end);
                v76.Parent = Skins.Specs.ScrollingFrame;
                local v77 = StandCache:FindFirstChild(i) and StandCache[i]:FindFirstChild("Model");

                if v77 then
                    CreateViewport(v76.Button.ViewportFrame, v77, v76.Name, i);
                end;
            end;
        end;

        Skins.Specs.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #Skins.Specs.ScrollingFrame:GetChildren() * 100);
    end;

    local function lerp(p78, p79, p80) -- Line: 405
        return p78 + (p79 - p78) * p80;
    end;

    local function UpdateRotation() -- Line: 409
        -- upvalues: u10 (ref), u9 (ref), Skins (copy), u11 (ref)
        if u10 ~= u9 then
            local v81 = u10;
            u10 = v81 + (u9 - v81) * 0.175;
            local WorldModel = Skins.ViewportFrame:FindFirstChild("WorldModel");

            if WorldModel and (Skins.ViewportFrame:FindFirstChild("Camera") and (WorldModel:FindFirstChildOfClass("Model") and u11)) then
                u11();
            end;
        end;
    end;

    local function RotateLeft() -- Line: 423
        -- upvalues: u1 (copy), u9 (ref)
        u1:PlaySound("Click");
        u9 = u9 - 45;
    end;

    local function RotateRight() -- Line: 428
        -- upvalues: u1 (copy), u9 (ref)
        u1:PlaySound("Click");
        u9 = u9 + 45;
    end;

    Skins:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 445
        -- upvalues: Parent (copy), CreateButtons (copy)
        if Parent.Visible then
            CreateButtons();
        end;
    end);
    Skins.Close.MouseButton1Down:Connect(function() -- Line: 433, Name: Close
        -- upvalues: u1 (copy), Select (copy)
        u1:SetMenu(nil);
        u1:PlaySound("Click");
        Select();
    end);
    Skins.Back.MouseButton1Down:Connect(function() -- Line: 439, Name: Back
        -- upvalues: u1 (copy), Select (copy)
        u1:SetMenu("Menu");
        u1:PlaySound("Click");
        Select();
    end);
    Skins.Skins.Buttons.Left.Button.MouseButton1Down:Connect(Left);
    Skins.Skins.Buttons.Middle.Button.MouseButton1Down:Connect(Middle);
    Skins.Skins.Buttons.Right.Button.MouseButton1Down:Connect(Right);
    Skins.Rotate.Left.Button.MouseButton1Down:Connect(RotateLeft);
    Skins.Rotate.Right.Button.MouseButton1Down:Connect(RotateRight);
    game:GetService("RunService").RenderStepped:Connect(UpdateRotation);

    local function UpdateEquippedSkins() -- Line: 463
        -- upvalues: u2 (ref), u3 (copy)
        u2 = u3:GetEquippedSkins():expect() or {};
    end;

    Data.Ability.Changed:Connect(function() -- Line: 467
        -- upvalues: UpdateEquippedSkins (copy)
        task.defer(UpdateEquippedSkins);
    end);
    Data.Skin.Changed:Connect(function() -- Line: 470
        -- upvalues: UpdateEquippedSkins (copy)
        task.defer(UpdateEquippedSkins);
    end);
    u2 = u3:GetEquippedSkins():expect() or {};
end;