  

 

local function Lerp(p1, p2, p3) -- Line: 1
    return p1 + (p2 - p1) * p3;
end;

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContextActionService = game:GetService("ContextActionService");
local TextService = game:GetService("TextService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u4 = {
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

return function(u5) -- Line: 23
    -- upvalues: ReplicatedStorage (copy), TextService (copy), LocalPlayer (copy), u4 (copy), ContextActionService (copy)
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local Knit = u5.Knit;
    Knit.OnStart():await();
    local v6 = Knit.GetService("DialogueService");
    local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    require(ReplicatedStorage.ReplicatedModules.Types);
    local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    local Knit2 = require(PathShortcuts.KnitPath.Knit);
    require(Knit2.Util.Trove);
    local RichText = require(ReplicatedStorage.ClientLibrary.RichText);
    local _ = ReplicatedStorage.ReplicatedModules.DialoguePackage.DialogueTrees;
    local u7 = nil;
    local u8 = Fusion.Value();
    local u9 = Fusion.Value();
    local u10 = Fusion.Value(false);

    local function CalculateTextBounds(p11, p12, p13, p14) -- Line: 50
        -- upvalues: TextService (ref)
        local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
        GetTextBoundsParams.RichText = true;
        GetTextBoundsParams.Font = Font.fromEnum(p14);
        GetTextBoundsParams.Size = p13 or 25;
        GetTextBoundsParams.Width = p12;
        GetTextBoundsParams.Text = p11;
        local v15 = TextService:GetTextBoundsAsync(GetTextBoundsParams);
        GetTextBoundsParams:Destroy();

        return v15;
    end;

    local function CreateOption(p16, p17) -- Line: 64
        -- upvalues: Parent (copy), Assets (copy), TextService (ref)
        if p17 and p17.Response then
            local u18 = Parent.AbsoluteSize.Y / 346.5;
            local u19 = Assets.Option:Clone();
            local u20 = `<b><font color="#{(p17.Next and Color3.fromRGB(255, 208, 115) or Color3.fromRGB(255, 107, 107)):ToHex()}">{p16}.</font></b> {p17.Response}`;
            u19.LayoutOrder = p16;
            u19.Content.Text = u20;
            local Content = u19.Content;
            Content.TextSize = Content.TextSize * u18;
            u19.Visible = true;
            task.spawn(function() -- Line: 79
                -- upvalues: u20 (copy), u18 (copy), u19 (copy), TextService (ref)
                local TextSize = u19.Content.TextSize;
                local Font2 = u19.Content.Font;
                local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
                GetTextBoundsParams.RichText = true;
                GetTextBoundsParams.Font = Font.fromEnum(Font2);
                GetTextBoundsParams.Size = TextSize or 25;
                GetTextBoundsParams.Width = 277.656 * u18;
                GetTextBoundsParams.Text = u20;
                local v21 = TextService:GetTextBoundsAsync(GetTextBoundsParams);
                GetTextBoundsParams:Destroy();
                u19.Content.Size = UDim2.new(u19.Content.Size.X.Scale, 0, u19.Content.Size.Y.Scale, v21.Y);
            end);

            return u19;
        end;
    end;

    local function CreateDialogue(p22, u23) -- Line: 87
        -- upvalues: u7 (ref), u10 (copy), u8 (copy), u9 (copy), Dialogue (copy), RichText (copy), Parent (copy), u5 (copy), LocalPlayer (ref)
        if u7 then
            u7:Destroy();
            u10:set(false);
            u8:set(nil);
            u9:set(nil);
            u7 = nil;
        end;

        local u24 = Dialogue.new(p22, u23);
        u24.NodeEntered:Connect(function(u25) -- Line: 100
            -- upvalues: u8 (ref), RichText (ref), Parent (ref), u24 (ref), u10 (ref), u7 (ref), u5 (ref)
            u8:set(u25);
            local Text = u25.Text;

            if u25.Text then
                if type(u25.Text) == "function" then
                    Text = u25.Text();
                end;

                local TextList = Parent.TextHolder.TextLabel.TextList;
                local v26 = {
                    TextScale = 0.12,
                    TextColor3 = "UG",
                    AnimateStyle = "Swing",
                    Font = Enum.Font.SourceSans
                };
                local v27 = math.floor(#Text / 200);
                v26.AnimateStepFrequency = math.max(v27, 1);
                v26.ContainerVerticalAlignment = Enum.VerticalAlignment.Top;
                local u28 = RichText:New(TextList, Text, v26);
                u24.Trove:Add(function() -- Line: 119
                    -- upvalues: u10 (ref), u28 (copy), u7 (ref), u5 (ref)
                    u10:set(false);
                    u28:Hide();
                    task.defer(function() -- Line: 123
                        -- upvalues: u7 (ref), u5 (ref)
                        if not u7 then
                            u5:PlaySound("DialogueClose");
                        end;
                    end);
                end);
                u24.Trove:Connect(Parent.TextHolder.TextLabel.InputBegan, function(p29) -- Line: 130
                    -- upvalues: u7 (ref), u24 (ref), u10 (ref), u25 (copy), u28 (copy)
                    if u7 ~= u24 then
                        return;
                    end;

                    if not u10:get() then
                        return;
                    end;

                    if not u25.Unskippable and (p29.UserInputType == Enum.UserInputType.MouseButton1 or p29.UserInputType == Enum.UserInputType.Touch) then
                        u28:Show(false);
                    end;
                end);
                u10:set(true);
                u28:Animate(true);
                u5:PlaySound("hover2");

                if u7 == u24 then
                    u10:set(false);
                end;
            end;
        end);
        u24.Ended:Connect(function() -- Line: 152
            -- upvalues: u7 (ref), u24 (ref), u8 (ref), u9 (ref)
            if u7 == u24 then
                u7 = nil;
            end;

            u8:set(nil);
            u9:set(nil);
            u24 = nil;
        end);
        u24:Init();
        u7 = u24;
        u9:set(u7:GetTree().Title);
        u5:PlaySound("DialogueOpen");

        if u23 and u23.Model then
            task.spawn(function() -- Line: 170
                -- upvalues: u23 (copy), u24 (ref), u7 (ref), LocalPlayer (ref)
                local v30 = u23.Model:GetPivot();

                while u24 and u7 == u24 do
                    if LocalPlayer:DistanceFromCharacter(v30.Position) >= 20 then
                        u24:Destroy();

                        return;
                    end;

                    task.wait(0.05);
                end;
            end);
        end;
    end;

    local function ProcessNumInput(p31, p32, p33) -- Line: 185
        -- upvalues: u7 (ref), u4 (ref), u8 (copy), u5 (copy)
        if p32 ~= Enum.UserInputState.Begin or not u7 then
            return Enum.ContextActionResult.Pass;
        end;

        local v34 = table.find(u4, p33.KeyCode);

        if v34 then
            local v35 = u8:get();

            if v35 and v35.Options then
                local Options = v35.Options;

                if Options[v34] then
                    u7:Choose(Options[v34]);
                    u5:PlaySound("DialoguePick");
                end;

                return Enum.ContextActionResult.Sink;
            end;
        end;

        return Enum.ContextActionResult.Pass;
    end;

    Fusion.Hydrate(Parent.TextHolder.Title)({
        Text = Fusion.Computed(function() -- Line: 218
            -- upvalues: u8 (copy), u9 (copy)
            local v36 = u8:get();
            local v37 = u9:get();

            return v36 and v36.Title or (v37 or "");
        end)
    });
    Fusion.Hydrate(Parent.TextHolder.Title.UIGradient)({
        Color = Fusion.Computed(function() -- Line: 226
            -- upvalues: u8 (copy)
            local v38 = u8:get();
            local v39 = v38 and v38.TitleColor or ColorSequence.new(Color3.fromRGB(201, 202, 255), Color3.fromRGB(176, 176, 255));

            if typeof(v39) == "Color3" then
                v39 = ColorSequence.new(v39);
            end;

            return v39;
        end)
    });
    Fusion.Hydrate(Parent.OptionHolder)({
        Size = Fusion.Spring(Fusion.Computed(function() -- Line: 241
            -- upvalues: u8 (copy), u10 (copy)
            local v40 = u8:get();
            local v41 = u10:get();

            if v40 and (v40.Options and not v41) then
                return UDim2.fromScale(0.35, 0.86);
            end;

            return UDim2.fromScale(0, 0.86);
        end), 25, 0.825)
    });
    Fusion.Hydrate(Parent.OptionHolder.Options)({
        [Fusion.Children] = Fusion.Computed(function() -- Line: 252
            -- upvalues: u8 (copy), u10 (copy), Fusion (copy), CreateOption (copy), u7 (ref), u5 (copy)
            local v42 = u8:get();
            local v43 = u10:get();

            if not v42 then
                return;
            end;

            if not (v42 and v43) then
                return Fusion.ForPairs(v42.Options or {}, function(p44, u45) -- Line: 260
                    -- upvalues: CreateOption (ref), Fusion (ref), u7 (ref), u5 (ref)
                    local v46 = CreateOption(p44, u45);

                    if v46 then
                        Fusion.Hydrate(v46)({
                            [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 265
                                -- upvalues: u7 (ref), u45 (copy), u5 (ref)
                                if not u7 then
                                    return;
                                end;

                                u7:Choose(u45);
                                u5:PlaySound("DialoguePick");
                            end,

                            [Fusion.OnEvent("MouseEnter")] = function() -- Line: 270
                                -- upvalues: u5 (ref)
                                u5:PlaySound("hover3");
                            end
                        });
                    end;

                    return p44, v46;
                end, Fusion.cleanup);
            end;
        end)
    });
    local u47 = Fusion.Spring(Fusion.Computed(function() -- Line: 281
        -- upvalues: u8 (copy)
        return u8:get() == nil and 1 or 0;
    end), 20, 0.7);
    Fusion.Hydrate(Parent)({
        Visible = Fusion.Computed(function() -- Line: 286
            -- upvalues: u47 (copy)
            return u47:get() <= 0.99;
        end),
        Position = Fusion.Spring(Fusion.Computed(function() -- Line: 289
            -- upvalues: u8 (copy)
            return u8:get() ~= nil and UDim2.fromScale(0.5, 0.95) or UDim2.fromScale(0.5, 0.985);
        end), 25, 0.75),
        GroupTransparency = u47
    });
    v6.DialogueSignalV2:Connect(function(p48, p49) -- Line: 296
        -- upvalues: Dialogue (copy), CreateDialogue (copy)
        local v50, v51 = Dialogue.ResolveFromPath(p48);

        if v50 and v51 == "Tree" then
            CreateDialogue(v50, p49);

            return;
        end;

        error((`Failed to create dialogue with path: {p48}, got type: {v51}`));
    end);

    for i, v in u4 do
        ContextActionService:BindAction(`DialogueInput{i}`, ProcessNumInput, false, v);
    end;

    debug.setmemorycategory("DialogueV2");
end;