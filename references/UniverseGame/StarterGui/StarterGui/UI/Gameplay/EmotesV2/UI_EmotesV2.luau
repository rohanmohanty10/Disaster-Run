  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local ContextActionService = game:GetService("ContextActionService");

return function(u1) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), ContextActionService (copy), UserInputService (copy), GuiService (copy)
    local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    Core.OnStart():await();
    u1.Knit.GetService("InventoryService");
    u1.Knit.GetService("ShopService");
    local u2 = Core.GetClientService("EmoteServiceV2");
    local Parent = script.Parent;
    local Center = Parent.Center;
    local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    require(PathShortcuts.KnitPath.Trove);
    require(ReplicatedStorage.ReplicatedModules.Types);
    require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
    local u3 = Color3.fromRGB(0, 0, 0);
    local u4 = Color3.fromRGB(177, 161, 112);
    local u5 = {};
    local u6 = Fusion.Value(nil);
    local u7 = Fusion.Value(1);
    local u8 = Fusion.Value(false);
    local u9 = Fusion.Value(nil);
    local u10 = nil;
    local u11 = 1;
    local u12 = {
        Enum.KeyCode.One,
        Enum.KeyCode.Two,
        Enum.KeyCode.Three,
        Enum.KeyCode.Four,
        Enum.KeyCode.Five,
        Enum.KeyCode.Six,
        Enum.KeyCode.Seven,
        Enum.KeyCode.Eight,
        Enum.KeyCode.Nine,
        Enum.KeyCode.Zero
    };

    local function MakeViewport(p13, p14, p15) -- Line: 69
        p13:ClearAllChildren();
        local WorldModel = Instance.new("WorldModel");
        WorldModel.Parent = p13;
        local v16 = p14:Clone();
        v16.Parent = WorldModel;
        v16.PrimaryPart = v16:FindFirstChild("HumanoidRootPart");
        v16:PivotTo(CFrame.new(0, v16:GetExtentsSize().Y / 2, 0) * CFrame.Angles(0, 3.141592653589793, 0));
        local v17 = v16:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator");
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://" .. p15;
        local v18 = v17:LoadAnimation(Animation);
        v18.Looped = true;
        v18:Play();
        local _, v19 = WorldModel:GetBoundingBox();
        local Camera = Instance.new("Camera");
        Camera.FieldOfView = 8;
        Camera.Parent = WorldModel;
        p13.CurrentCamera = Camera;
        local v20 = math.max(v19.X, v19.Y, v19.Z) * 0.5;
        local v21 = math.rad(Camera.FieldOfView * 0.5);
        local v22 = v20 / math.tan(v21) * 1.1;
        local v23 = Vector3.new(0, v19.Y * 0.45, 0);
        Camera.CFrame = CFrame.lookAt(v23 + Vector3.new(0, 0, v22), v23);
    end;

    local function UpdateSlice(p24, p25) -- Line: 103
        -- upvalues: u5 (copy), ItemData (copy), MakeViewport (copy)
        if not p25 then
            u5[p24].Holder.EmoteDisplay3D:ClearAllChildren();

            return;
        end;

        local v26 = ItemData.GetItemInfo(p25);

        if v26.DisplayInfo then
            MakeViewport(u5[p24].Holder.EmoteDisplay3D, script["Mysterious Man"], v26.DisplayInfo.Animations[1]);
        end;
    end;

    local function UpdatePage(p27) -- Line: 115
        -- upvalues: u5 (copy), u7 (copy), u10 (ref), ItemData (copy), MakeViewport (copy)
        if p27 then
            for i = 1, 8 do
                u5[i].Holder.EmoteDisplay3D:ClearAllChildren();
            end;

            return;
        end;

        local v28 = u7:get();

        if not v28 or v28 == 0 then
            for i = 1, 8 do
                u5[i].Holder.EmoteDisplay3D:ClearAllChildren();
            end;

            return;
        end;

        local v29;

        if u10 then
            v29 = u10[tostring(v28)];
        else
            v29 = nil;
        end;

        if v29 then
            for i = 1, 8 do
                local v30 = v29[tostring(i)];

                if v30 then
                    local v31 = ItemData.GetItemInfo(v30);

                    if v31.DisplayInfo then
                        MakeViewport(u5[i].Holder.EmoteDisplay3D, script["Mysterious Man"], v31.DisplayInfo.Animations[1]);
                    end;
                else
                    u5[i].Holder.EmoteDisplay3D:ClearAllChildren();
                end;
            end;
        end;
    end;

    local function Update(p32) -- Line: 138
        -- upvalues: u8 (copy), Center (copy), u6 (copy), u5 (copy)
        if not u8:get() then
            return;
        end;

        local v33 = p32 - (Center.AbsolutePosition + Vector2.new(Center.AbsoluteSize.X / 2, Center.AbsoluteSize.Y / 2));
        local X = v33.X;
        local Y = v33.Y;

        if v33.Magnitude >= Center.AbsoluteSize.X * 1.5 then
            u6:set(nil);

            return;
        end;

        local v34 = math.atan2(Y, X);
        local v35 = ((math.deg(v34) + 90) % 360 + 22.5) / 45;
        local v36 = math.floor(v35) % 8 + 1;

        for i, _ in u5 do
            if i == v36 and u6:get() ~= v36 then
                u6:set(i);
            end;
        end;
    end;

    local function Open() -- Line: 165
        -- upvalues: Parent (copy), u7 (copy), u11 (ref), u8 (copy), UpdatePage (copy)
        Parent.Visible = true;
        u7:set(u11);
        u8:set(true);
        UpdatePage();
    end;

    local function Close() -- Line: 174
        -- upvalues: Parent (copy), u7 (copy), u11 (ref), u6 (copy), u8 (copy), u9 (copy), UpdatePage (copy)
        Parent.Visible = false;
        local v37 = u7:get();
        u11 = math.max(v37, 1);
        u7:set(0);
        u6:set(nil);
        u8:set(false);
        u9:set(nil);
        UpdatePage();
    end;

    local function Activate(p38) -- Line: 188
        -- upvalues: u7 (copy), u10 (ref), u9 (copy), u2 (copy), ItemData (copy), u1 (copy), Close (copy)
        if not p38 or (p38 > 8 or p38 <= 0) then
            return;
        end;

        local v39 = u7:get();

        if not v39 then
            return;
        end;

        local v40;

        if u10 and u10[tostring(v39)] then
            v40 = u10[tostring(v39)][tostring(p38)];
        else
            v40 = nil;
        end;

        local v41 = u9:get();

        if v41 then
            local v42 = u2:BindEmote(v39, p38, v41):expect() and ItemData.GetItemInfo(v41);

            if v42 then
                u1:Notify("Emote Bound", `Bound emote "{v42.Name}" to slot {p38}`, 2);
            end;

            task.spawn(function() -- Line: 211
                -- upvalues: u9 (ref), Close (ref), u1 (ref)
                u9:set(nil);
                Close();
                u1:SetMenu(u1._ReturnMenu or "Inventory", {
                    Manual = true
                });
                u1._ReturnMenu = nil;
            end);

            return;
        end;

        local v43 = u2:PlayEmote(v40):expect();
        print(v43);

        if v43 then
            Close();
        end;
    end;

    ContextActionService:BindAction("ActivateEmote", function(p44, p45, p46) -- Line: 229, Name: ProcessActivation
        -- upvalues: u6 (copy), Activate (copy)
        if p45 ~= Enum.UserInputState.Begin or not u6:get() then
            return Enum.ContextActionResult.Pass;
        end;

        Activate((u6:get()));
        u6:set(nil);

        return Enum.ContextActionResult.Sink;
    end, false, Enum.UserInputType.Touch, Enum.UserInputType.MouseButton1, Enum.KeyCode.ButtonX);
    ContextActionService:BindAction("NumActivateEmote", function(p47, p48, p49) -- Line: 242, Name: ProcessNumInput
        -- upvalues: u8 (copy), u12 (copy), Activate (copy)
        if p48 ~= Enum.UserInputState.Begin or not u8:get() then
            return Enum.ContextActionResult.Pass;
        end;

        local v50 = table.find(u12, p49.KeyCode);

        if not v50 then
            return Enum.ContextActionResult.Pass;
        end;

        Activate(v50);

        return Enum.ContextActionResult.Sink;
    end, false, unpack(u12));
    UserInputService.InputBegan:Connect(function(p51, p52) -- Line: 260
        -- upvalues: GuiService (ref), Update (copy), u1 (copy), Parent (copy), u7 (copy), u11 (ref), u8 (copy), UpdatePage (copy), Close (copy)
        if p52 then
            return;
        end;

        if p51.UserInputType == Enum.UserInputType.Touch then
            GuiService:GetGuiInset();
            local Position = p51.Position;
            Update((Vector2.new(Position.X, Position.Y)));
        end;

        if p51.UserInputType == Enum.UserInputType.Keyboard and (not u1.Locked and (not u1.UI.Menus.Visible and p51.KeyCode == Enum.KeyCode.Comma)) then
            u1:PlaySound("Click");

            if not Parent.Visible then
                Parent.Visible = true;
                u7:set(u11);
                u8:set(true);
                UpdatePage();

                return;
            end;

            Close();
        end;
    end);
    ContextActionService:BindActionAtPriority("ConsoleEmoteWheel", function(p53, p54, p55) -- Line: 283
        -- upvalues: u8 (copy), Center (copy), Update (copy)
        if p54 ~= Enum.UserInputState.Change or u8:get() ~= true then
            return Enum.ContextActionResult.Pass;
        end;

        local v56 = Center.AbsolutePosition + Vector2.new(Center.AbsoluteSize.X / 2, Center.AbsoluteSize.Y / 2);
        local Position = p55.Position;

        if Position.Magnitude <= 0.3333333333333333 then
            return Enum.ContextActionResult.Sink;
        end;

        Update(v56 - Vector2.new(-Position.X, Position.Y) * 50);

        return Enum.ContextActionResult.Sink;
    end, false, 2005, Enum.KeyCode.Thumbstick1);
    UserInputService.InputChanged:Connect(function(p57, p58) -- Line: 295
        -- upvalues: GuiService (ref), UserInputService (ref), Update (copy)
        if p58 then
            return;
        end;

        if p57.UserInputType == Enum.UserInputType.MouseMovement then
            local v59 = GuiService:GetGuiInset();
            Update(UserInputService:GetMouseLocation() - v59);
        end;
    end);

    for i = 1, 8 do
        local v60 = script.Parent.Slice:Clone();
        v60.Parent = Parent;
        v60.Name = "Slice " .. i;
        v60.Size = UDim2.new(0.5, 0, 0.5, 0);
        v60.SizeConstraint = Enum.SizeConstraint.RelativeXX;
        v60.AnchorPoint = Vector2.one * 0.5;
        v60.Visible = true;
        local v61 = math.rad((i - 1) * 45);
        v60.Rotation = math.deg(v61);
        v60.Holder.Rotation = -v60.Rotation;
        u5[i] = v60;
        Fusion.Hydrate(v60)({
            Size = Fusion.Spring(Fusion.Computed(function() -- Line: 323
                -- upvalues: u6 (copy), i (copy)
                if u6:get() == i then
                    return UDim2.new(0.55, 0, 0.55, 0);
                end;

                return UDim2.new(0.5, 0, 0.5, 0);
            end), 40, 0.75),
            ImageTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 330
                -- upvalues: u6 (copy), i (copy)
                return u6:get() == i and 0.425 or 0.6;
            end), 35, 0.8),
            ImageColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 333
                -- upvalues: u9 (copy), u4 (copy), u3 (copy)
                if u9:get() == nil then
                    return u3;
                end;

                return u4;
            end), 40, 0.85)
        });
        Fusion.Hydrate(v60.Outline)({
            ImageTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 343
                -- upvalues: u6 (copy), i (copy)
                return u6:get() == i and 0 or 1;
            end), 35, 0.75)
        });
    end;

    Fusion.Observer(u7):onChange(UpdatePage);
    Fusion.Observer(u6):onChange(function() -- Line: 354
        -- upvalues: u6 (copy), u1 (copy)
        if u6:get() then
            u1:PlaySound("hover4");
        end;
    end);
    task.defer(function() -- Line: 360
        -- upvalues: u2 (copy), u10 (ref)
        local v62 = u2:GetEmotePages():expect();

        if typeof(v62) == "table" then
            u10 = v62;
        end;

        print(u10);
    end);
    Fusion.Hydrate(Center.SelectedName)({
        Text = Fusion.Computed(function() -- Line: 370
            -- upvalues: u6 (copy), u7 (copy), u10 (ref), ItemData (copy)
            local v63 = u6:get();
            local v64 = u7:get();
            local v65 = v63 and (u10 and (u10[tostring(v64)] and ItemData.GetItemInfo(u10[tostring(v64)][tostring(v63)])));

            return not v65 and "" or v65.Name;
        end)
    });
    Fusion.Hydrate(Center.Index)({
        Text = Fusion.Computed(function() -- Line: 386
            -- upvalues: u6 (copy)
            local v66 = u6:get();

            return not v66 and "" or `({v66})`;
        end)
    });
    Fusion.Hydrate(Parent.UIScale)({
        Scale = Fusion.Spring(Fusion.Computed(function() -- Line: 394
            -- upvalues: u8 (copy)
            return u8:get() and 1 or 0.45;
        end), 55, 0.75)
    });
    u2.EmoteBound:Connect(function(p67, p68, p69) -- Line: 403
        -- upvalues: u10 (ref), u7 (copy), UpdatePage (copy)
        if u10 then
            if not u10[tostring(p67)] then
                u10[tostring(p67)] = {};
            end;

            u10[tostring(p67)][tostring(p68)] = p69;
        end;

        if u7:get() == p67 then
            UpdatePage();
        end;
    end);
    u2.EmotesCleared:Connect(function() -- Line: 417
        -- upvalues: u10 (ref), u5 (copy)
        if u10 then
            table.clear(u10);
        end;

        for i = 1, 8 do
            u5[i].Holder.EmoteDisplay3D:ClearAllChildren();
        end;
    end);

    function u1.ShowEmoteWheel(p70) -- Line: 425
        -- upvalues: Parent (copy), u7 (copy), u11 (ref), u8 (copy), UpdatePage (copy)
        Parent.Visible = true;
        u7:set(u11);
        u8:set(true);
        UpdatePage();
    end;

    function u1.CloseEmoteWheel(p71) -- Line: 429
        -- upvalues: Close (copy)
        Close();
    end;

    function u1.SetBindingEmote(p72, p73) -- Line: 433
        -- upvalues: u9 (copy)
        if p73 then
            u9:set(p73);

            return;
        end;

        u9:set(nil);
    end;
end;