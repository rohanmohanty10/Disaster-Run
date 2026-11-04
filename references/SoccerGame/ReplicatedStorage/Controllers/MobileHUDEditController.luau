  

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local v1 = Knit.CreateController({
    Name = "MobileHUDEditController"
});
local u2 = { "Dribble", "Emote", "Awaken", "Flow", "Shoot", "Pass", "Shiftlock", "Run", "Slide", "Dive", "Request", "RequestCR", "Bicycle" };
local u3 = {};

for _, v in u2 do
    u3[v] = true;
end;

local u4 = { "Ball", "NoBall" };

local function keyFor(p5, p6) -- Line: 24
    return p5 .. "_" .. p6;
end;

local function editableButtons(p7) -- Line: 26
    -- upvalues: u4 (copy), u2 (copy)
    local v8 = {};

    for _, v in u4 do
        local v9 = p7:FindFirstChild(v);

        if v9 then
            local v10 = v;

            for _, v2 in u2 do
                local v11 = v9:FindFirstChild(v2);

                if v11 and v11:IsA("GuiButton") then
                    v8[#v8 + 1] = {
                        frame = v10,
                        action = v2,
                        btn = v11
                    };
                end;
            end;
        end;
    end;

    return v8;
end;

function v1.KnitStart(p12) -- Line: 42
    -- upvalues: UserInputService (copy), Players (copy), Knit (copy), ClientGlobals (copy), u4 (copy), u2 (copy), u3 (copy)
    if not UserInputService.TouchEnabled then
        return;
    end;

    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
    local Mobile = PlayerGui:WaitForChild("Mobile", 30);

    if not Mobile then
        return;
    end;

    local NoBall = Mobile:WaitForChild("NoBall", 10);

    if not NoBall then
        return;
    end;

    local function findCtrl(p13) -- Line: 53
        -- upvalues: Mobile (copy)
        local v14 = Mobile:FindFirstChild(p13);

        if v14 and (v14:IsA("ImageButton") or v14:IsA("TextButton")) then
            return v14;
        end;

        for _, descendant in Mobile:GetDescendants() do
            if descendant.Name == p13 and (descendant:IsA("ImageButton") or descendant:IsA("TextButton")) then
                return descendant;
            end;
        end;

        return nil;
    end;

    local u15 = findCtrl("Edit") or NoBall:WaitForChild("Edit", 10);
    local u16 = findCtrl("Save") or NoBall:WaitForChild("Save", 10);
    local u17 = findCtrl("Cancel") or NoBall:WaitForChild("Cancel", 10);
    local u18 = findCtrl("Reset");
    local u19 = findCtrl("Switch") or NoBall:WaitForChild("Switch", 10);
    local u20;

    if u19 then
        u20 = u19:FindFirstChild("ButtonName");
    else
        u20 = u19;
    end;

    if not (u15 and (u16 and u17)) then
        return;
    end;

    for _, v in {
        u15,
        u16,
        u17,
        u18,
        u19
    } do
        if v and v.Parent ~= Mobile then
            v.Parent = Mobile;
        end;
    end;

    u15.Active = true;
    u15.AutoButtonColor = true;
    u16.Active = true;
    u17.Active = true;

    if u18 then
        u18.Active = true;
    end;

    if u19 then
        u19.Active = true;
    end;

    u15.Visible = true;
    u16.Visible = false;
    u17.Visible = false;

    if u18 then
        u18.Visible = false;
    end;

    if u19 then
        u19.Visible = false;
    end;

    local u21 = {};
    local u22 = {};
    local u23 = nil;
    task.spawn(function() -- Line: 98
        -- upvalues: u23 (ref), Knit (ref)
        u23 = Knit.GetService("SettingsService");
    end);

    local function setupVariant(u24, u25) -- Line: 103
        -- upvalues: Mobile (copy), u22 (copy), u21 (copy), ClientGlobals (ref)
        task.spawn(function() -- Line: 104
            -- upvalues: Mobile (ref), u24 (copy), u25 (copy), u22 (ref), u21 (ref), ClientGlobals (ref)
            local v26 = Mobile:WaitForChild(u24, 30);

            if not v26 then
                return;
            end;

            local u27 = v26:WaitForChild(u25, 10);

            if not (u27 and u27:IsA("GuiButton")) then
                return;
            end;

            u22[u27] = u27.Position;
            table.insert(u21, {
                frame = u24,
                action = u25,
                btn = u27
            });
            task.spawn(function() -- Line: 113
                -- upvalues: ClientGlobals (ref), u24 (ref), u25 (ref), u27 (copy)
                ClientGlobals.PlayerData:WaitForLoaded();
                local v28 = ClientGlobals.PlayerData:TryIndex({ "PlayerKeybinds", "Mobile", u24 .. "_" .. u25 });

                if typeof(v28) == "table" and (tonumber(v28[1]) and tonumber(v28[2])) then
                    u27.Position = UDim2.fromScale(v28[1], v28[2]);
                end;

                ClientGlobals.PlayerData:Observe({ "PlayerKeybinds", "Mobile", u24 .. "_" .. u25 }, function(p29) -- Line: 122
                    -- upvalues: u27 (ref)
                    if typeof(p29) == "table" and (tonumber(p29[1]) and tonumber(p29[2])) then
                        u27.Position = UDim2.fromScale(p29[1], p29[2]);
                    end;
                end);
            end);
        end);
    end;

    for _, v in u4 do
        local u30 = v;

        for _, v2 in u2 do
            task.spawn(function() -- Line: 104
                -- upvalues: Mobile (copy), u30 (copy), v2 (copy), u22 (copy), u21 (copy), ClientGlobals (ref)
                local v31 = Mobile:WaitForChild(u30, 30);

                if not v31 then
                    return;
                end;

                local u32 = v31:WaitForChild(v2, 10);

                if not (u32 and u32:IsA("GuiButton")) then
                    return;
                end;

                u22[u32] = u32.Position;
                table.insert(u21, {
                    frame = u30,
                    action = v2,
                    btn = u32
                });
                task.spawn(function() -- Line: 113
                    -- upvalues: ClientGlobals (ref), u30 (ref), v2 (ref), u32 (copy)
                    ClientGlobals.PlayerData:WaitForLoaded();
                    local v33 = ClientGlobals.PlayerData:TryIndex({ "PlayerKeybinds", "Mobile", u30 .. "_" .. v2 });

                    if typeof(v33) == "table" and (tonumber(v33[1]) and tonumber(v33[2])) then
                        u32.Position = UDim2.fromScale(v33[1], v33[2]);
                    end;

                    ClientGlobals.PlayerData:Observe({ "PlayerKeybinds", "Mobile", u30 .. "_" .. v2 }, function(p34) -- Line: 122
                        -- upvalues: u32 (ref)
                        if typeof(p34) == "table" and (tonumber(p34[1]) and tonumber(p34[2])) then
                            u32.Position = UDim2.fromScale(p34[1], p34[2]);
                        end;
                    end);
                end);
            end);
        end;
    end;

    local u35 = false;
    local u36 = nil;
    local u37 = {};
    local u38 = nil;
    local u39 = nil;
    local u40 = nil;

    local function beginDrag(u41, p42) -- Line: 147
        -- upvalues: u3 (ref), UserInputService (ref)
        local Parent = u41.Parent;

        if not Parent then
            return;
        end;

        local Position = p42.Position;
        local Position2 = u41.Position;
        local AbsoluteSize = Parent.AbsoluteSize;
        local AbsolutePosition = Parent.AbsolutePosition;

        if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
            return;
        end;

        local u43 = {};

        for _, child in Parent:GetChildren() do
            if child ~= u41 and (u3[child.Name] and child:IsA("GuiObject")) then
                u43[#u43 + 1] = {
                    abs = child.AbsolutePosition,
                    size = child.AbsoluteSize
                };
            end;
        end;

        local AbsoluteSize2 = u41.AbsoluteSize;
        local AnchorPoint = u41.AnchorPoint;

        local function overlapsAt(p44, p45) -- Line: 168
            -- upvalues: AbsolutePosition (copy), AbsoluteSize (copy), AnchorPoint (copy), AbsoluteSize2 (copy), u43 (copy)
            local v46 = AbsolutePosition.X + p44 * AbsoluteSize.X - AnchorPoint.X * AbsoluteSize2.X;
            local v47 = AbsolutePosition.Y + p45 * AbsoluteSize.Y - AnchorPoint.Y * AbsoluteSize2.Y;

            for _, v in u43 do
                if v46 < v.abs.X + v.size.X and (v46 + AbsoluteSize2.X > v.abs.X and (v47 < v.abs.Y + v.size.Y and v47 + AbsoluteSize2.Y > v.abs.Y)) then
                    return true;
                end;
            end;

            return false;
        end;

        local u48 = Position2;
        local u49 = nil;
        local u52 = UserInputService.InputChanged:Connect(function(p50) -- Line: 182
            -- upvalues: Position (copy), Position2 (copy), AbsoluteSize (copy), u48 (ref), overlapsAt (copy), u41 (copy)
            if p50.UserInputType ~= Enum.UserInputType.Touch and p50.UserInputType ~= Enum.UserInputType.MouseMovement then
                return;
            end;

            local v51 = p50.Position - Position;
            local math_clamp_ret = math.clamp(Position2.X.Scale + v51.X / AbsoluteSize.X, 0.02, 0.98);
            local math_clamp_ret2 = math.clamp(Position2.Y.Scale + v51.Y / AbsoluteSize.Y, 0.02, 0.98);
            local Scale = u48.X.Scale;
            local Scale2 = u48.Y.Scale;

            if overlapsAt(math_clamp_ret, math_clamp_ret2) then
                if overlapsAt(math_clamp_ret, Scale2) then
                    if overlapsAt(Scale, math_clamp_ret2) then
                        math_clamp_ret2 = Scale2;
                    end;
                else
                    math_clamp_ret2 = Scale2;
                    Scale = math_clamp_ret;
                end;
            else
                Scale = math_clamp_ret;
            end;

            local UDim2_fromScale_ret = UDim2.fromScale(Scale, math_clamp_ret2);
            u41.Position = UDim2_fromScale_ret;
            u48 = UDim2_fromScale_ret;
        end);
        u49 = UserInputService.InputEnded:Connect(function(p53) -- Line: 204
            -- upvalues: u52 (ref), u49 (ref)
            if p53.UserInputType == Enum.UserInputType.Touch or p53.UserInputType == Enum.UserInputType.MouseButton1 then
                if u52 then
                    u52:Disconnect();
                end;

                if u49 then
                    u49:Disconnect();
                end;
            end;
        end);
    end;

    local function attachDrag(p54) -- Line: 213
        -- upvalues: u37 (copy)
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Name = "_EditStroke";
        UIStroke.Thickness = 3;
        UIStroke.Color = Color3.fromRGB(255, 200, 0);
        UIStroke.Transparency = 0.2;
        UIStroke.Parent = p54;
        u37[p54] = {
            stroke = UIStroke
        };
    end;

    local function detachDrag(p55) -- Line: 224
        -- upvalues: u37 (copy)
        local v56 = u37[p55];

        if not v56 then
            return;
        end;

        if v56.stroke then
            v56.stroke:Destroy();
        end;

        u37[p55] = nil;
    end;

    local function pointInBtn(p57, p58) -- Line: 231
        local AbsolutePosition = p58.AbsolutePosition;
        local AbsoluteSize = p58.AbsoluteSize;
        local v59;

        if p57.X >= AbsolutePosition.X and (p57.X <= AbsolutePosition.X + AbsoluteSize.X and p57.Y >= AbsolutePosition.Y) then
            v59 = p57.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
        else
            v59 = false;
        end;

        return v59;
    end;

    local function enterEditMode() -- Line: 237
        -- upvalues: u35 (ref), u36 (ref), u21 (copy), attachDrag (copy), u38 (ref), Mobile (copy), u15 (copy), u16 (copy), u17 (copy), u18 (copy), u19 (copy), beginDrag (copy), u40 (ref)
        if u35 then
            return;
        end;

        u35 = true;
        u36 = {};

        for _, v in u21 do
            u36[v.btn] = v.btn.Position;
            attachDrag(v.btn);
        end;

        u38 = Instance.new("ImageButton");
        u38.Name = "_MobileHUDEditBlocker";
        u38.Size = UDim2.fromScale(1, 1);
        u38.Position = UDim2.fromScale(0, 0);
        u38.BackgroundTransparency = 1;
        u38.ImageTransparency = 1;
        u38.AutoButtonColor = false;
        u38.Active = true;
        u38.ZIndex = 32000;
        u38.Parent = Mobile;
        u15.ZIndex = 32001;
        u16.ZIndex = 32001;
        u17.ZIndex = 32001;

        if u18 then
            u18.ZIndex = 32001;
        end;

        if u19 then
            u19.ZIndex = 32001;
        end;

        u38.InputBegan:Connect(function(p60) -- Line: 268
            -- upvalues: u21 (ref), beginDrag (ref)
            if p60.UserInputType ~= Enum.UserInputType.Touch and p60.UserInputType ~= Enum.UserInputType.MouseButton1 then
                return;
            end;

            local Position = p60.Position;

            for _, v in u21 do
                local btn = v.btn;

                if btn.Parent and (btn.Visible and btn.Parent.Visible) then
                    local AbsolutePosition = btn.AbsolutePosition;
                    local AbsoluteSize = btn.AbsoluteSize;
                    local v61;

                    if Position.X >= AbsolutePosition.X and (Position.X <= AbsolutePosition.X + AbsoluteSize.X and Position.Y >= AbsolutePosition.Y) then
                        v61 = Position.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
                    else
                        v61 = false;
                    end;

                    if v61 then
                        beginDrag(btn, p60);

                        return;
                    end;
                end;
            end;
        end);
        u15.Visible = false;
        u16.Visible = true;
        u17.Visible = true;

        if u18 then
            u18.Visible = true;
        end;

        if u19 then
            u19.Visible = true;
        end;

        Mobile:SetAttribute("HUDEditing", true);
        u40();
    end;

    local function exitEditModeUI() -- Line: 293
        -- upvalues: u38 (ref), u36 (ref), u37 (copy), u35 (ref), u15 (copy), u16 (copy), u17 (copy), u18 (copy), u19 (copy), u39 (ref), Mobile (copy)
        if u38 then
            u38:Destroy();
            u38 = nil;
        end;

        if u36 then
            for i in u36 do
                local v62 = u37[i];

                if v62 then
                    if v62.stroke then
                        v62.stroke:Destroy();
                    end;

                    u37[i] = nil;
                end;
            end;
        end;

        u36 = nil;
        u35 = false;
        u15.Visible = true;
        u16.Visible = false;
        u17.Visible = false;

        if u18 then
            u18.Visible = false;
        end;

        if u19 then
            u19.Visible = false;
        end;

        u39 = nil;
        Mobile:SetAttribute("HUDEditing", false);
    end;

    local function commitSave() -- Line: 309
        -- upvalues: u35 (ref), u23 (ref), u21 (copy), exitEditModeUI (copy)
        if not u35 then
            return;
        end;

        if u23 then
            for _, v in u21 do
                u23.Keybind:Fire("Mobile", v.frame .. "_" .. v.action, { v.btn.Position.X.Scale, v.btn.Position.Y.Scale });
            end;
        end;

        exitEditModeUI();
    end;

    local function cancelEdit() -- Line: 321
        -- upvalues: u35 (ref), u36 (ref), exitEditModeUI (copy)
        if not u35 then
            return;
        end;

        if u36 then
            for i, v in u36 do
                i.Position = v;
            end;
        end;

        exitEditModeUI();
    end;

    local function applyResetToDefaults() -- Line: 331
        -- upvalues: u21 (copy), u22 (copy), u23 (ref)
        for _, v in u21 do
            local v63 = u22[v.btn];

            if v63 then
                v.btn.Position = v63;

                if u23 then
                    u23.Keybind:Fire("Mobile", v.frame .. "_" .. v.action, { v63.X.Scale, v63.Y.Scale });
                end;
            end;
        end;
    end;

    local function askReset() -- Line: 344
        -- upvalues: u35 (ref), PlayerGui (copy), applyResetToDefaults (copy), exitEditModeUI (copy)
        if not u35 then
            return;
        end;

        local Confirmation = PlayerGui:WaitForChild("Confirmation", 5);

        if not Confirmation then
            return;
        end;

        local Confirmation2 = Confirmation:WaitForChild("Confirmation", 5);

        if not Confirmation2 then
            return;
        end;

        local bg = Confirmation2:WaitForChild("bg", 5);

        if bg then
            bg = bg:WaitForChild("TextLabel", 5);
        end;

        local Options = Confirmation2:WaitForChild("Options", 5);
        local v64;

        if Options then
            v64 = Options:WaitForChild("Yes", 5);
        else
            v64 = Options;
        end;

        if Options then
            Options = Options:WaitForChild("No", 5);
        end;

        if not (bg and (v64 and Options)) then
            return;
        end;

        bg.Text = "ARE YOU SURE YOU WANT TO RESET?";
        local u65 = nil;
        local u66 = nil;

        local function cleanup() -- Line: 360
            -- upvalues: u65 (ref), u66 (ref), Confirmation (copy)
            if u65 then
                u65:Disconnect();
                u65 = nil;
            end;

            if u66 then
                u66:Disconnect();
                u66 = nil;
            end;

            Confirmation.Enabled = false;
        end;

        u65 = v64.Activated:Connect(function() -- Line: 366
            -- upvalues: u65 (ref), u66 (ref), Confirmation (copy), applyResetToDefaults (ref), exitEditModeUI (ref)
            if u65 then
                u65:Disconnect();
                u65 = nil;
            end;

            if u66 then
                u66:Disconnect();
                u66 = nil;
            end;

            Confirmation.Enabled = false;
            applyResetToDefaults();
            exitEditModeUI();
        end);
        u66 = Options.Activated:Connect(function() -- Line: 371
            -- upvalues: u65 (ref), u66 (ref), Confirmation (copy)
            if u65 then
                u65:Disconnect();
                u65 = nil;
            end;

            if u66 then
                u66:Disconnect();
                u66 = nil;
            end;

            Confirmation.Enabled = false;
        end);
        Confirmation.Enabled = true;
    end;

    u40 = function() -- Line: 378
        -- upvalues: u20 (copy), Mobile (copy)
        if not u20 then
            return;
        end;

        local Ball = Mobile:FindFirstChild("Ball");

        if Ball and Ball.Visible then
            u20.Text = "ON BALL";

            return;
        end;

        u20.Text = "OFF BALL";
    end;

    local function toggleSwitch() -- Line: 388
        -- upvalues: u35 (ref), Mobile (copy), u39 (ref), u40 (ref)
        if not u35 then
            return;
        end;

        local Ball = Mobile:FindFirstChild("Ball");
        local NoBall2 = Mobile:FindFirstChild("NoBall");

        if not (Ball and NoBall2) then
            return;
        end;

        if u39 == nil then
            u39 = Ball.Visible;
        end;

        u39 = not u39;
        Ball.Visible = u39;
        NoBall2.Visible = not u39;
        u40();
    end;

    u15.Activated:Connect(enterEditMode);
    u16.Activated:Connect(commitSave);
    u17.Activated:Connect(cancelEdit);

    if u18 then
        u18.Activated:Connect(askReset);
    end;

    if u19 then
        u19.Activated:Connect(toggleSwitch);
    end;
end;

return v1;