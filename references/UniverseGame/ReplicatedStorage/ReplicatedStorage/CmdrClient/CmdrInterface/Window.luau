  

 

local GuiService = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local TextChatService = game:GetService("TextChatService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch };
local u2 = {
    Valid = true,
    AutoComplete = nil,
    ProcessEntry = nil,
    OnTextChanged = nil,
    Cmdr = nil,
    HistoryState = nil
};
local Frame = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Frame");
local Line = Frame:WaitForChild("Line");
local Entry = Frame:WaitForChild("Entry");
Line.Parent = nil;

function u2.UpdateLabel(p3) -- Line: 29
    -- upvalues: Entry (copy), LocalPlayer (copy)
    Entry.TextLabel.Text = LocalPlayer.Name .. "@" .. p3.Cmdr.PlaceName .. "$";
end;

function u2.GetLabel(p4) -- Line: 34
    -- upvalues: Entry (copy)
    return Entry.TextLabel.Text;
end;

function u2.UpdateWindowHeight(p5) -- Line: 39
    -- upvalues: Frame (copy)
    local v6 = Frame.UIListLayout.AbsoluteContentSize.Y + Frame.UIPadding.PaddingTop.Offset + Frame.UIPadding.PaddingBottom.Offset;
    Frame.Size = UDim2.new(Frame.Size.X.Scale, Frame.Size.X.Offset, 0, (math.clamp(v6, 0, 300)));
    Frame.CanvasPosition = Vector2.new(0, v6);
end;

function u2.AddLine(p7, p8, p9) -- Line: 48
    -- upvalues: u2 (copy), Line (copy), Frame (copy)
    local v10 = p9 or {};
    local v11 = tostring(p8);
    local v12 = typeof(v10) == "Color3" and {
        Color = v10
    } or v10;

    if #v11 == 0 then
        u2:UpdateWindowHeight();

        return;
    end;

    local v13 = p7.Cmdr.Util.EmulateTabstops(v11 or "nil", 8);
    local v14 = Line:Clone();
    v14.Text = v13;
    v14.TextColor3 = v12.Color or v14.TextColor3;
    v14.RichText = v12.RichText or false;
    v14.Parent = Frame;
end;

function u2.IsVisible(p15) -- Line: 71
    -- upvalues: Frame (copy)
    return Frame.Visible;
end;

function u2.SetVisible(p16, p17) -- Line: 76
    -- upvalues: Frame (copy), TextChatService (copy), Entry (copy), UserInputService (copy)
    Frame.Visible = p17;

    if p17 then
        p16.PreviousChatWindowConfigurationEnabled = TextChatService.ChatWindowConfiguration.Enabled;
        p16.PreviousChatInputBarConfigurationEnabled = TextChatService.ChatInputBarConfiguration.Enabled;
        TextChatService.ChatWindowConfiguration.Enabled = false;
        TextChatService.ChatInputBarConfiguration.Enabled = false;
        Entry.TextBox:CaptureFocus();
        p16:SetEntryText("");

        if p16.Cmdr.ActivationUnlocksMouse then
            p16.PreviousMouseBehavior = UserInputService.MouseBehavior;
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        end;
    else
        TextChatService.ChatWindowConfiguration.Enabled = p16.PreviousChatWindowConfigurationEnabled == nil and true or p16.PreviousChatWindowConfigurationEnabled;
        TextChatService.ChatInputBarConfiguration.Enabled = p16.PreviousChatInputBarConfigurationEnabled == nil and true or p16.PreviousChatInputBarConfigurationEnabled;
        Entry.TextBox:ReleaseFocus();
        p16.AutoComplete:Hide();

        if p16.PreviousMouseBehavior then
            UserInputService.MouseBehavior = p16.PreviousMouseBehavior;
            p16.PreviousMouseBehavior = nil;
        end;
    end;
end;

function u2.Hide(p18) -- Line: 109
    return p18:SetVisible(false);
end;

function u2.Show(p19) -- Line: 114
    return p19:SetVisible(true);
end;

function u2.SetEntryText(p20, p21) -- Line: 119
    -- upvalues: Entry (copy), u2 (copy)
    Entry.TextBox.Text = p21;

    if p20:IsVisible() then
        Entry.TextBox:CaptureFocus();
        Entry.TextBox.CursorPosition = #p21 + 1;
        u2:UpdateWindowHeight();
    end;
end;

function u2.GetEntryText(p22) -- Line: 130
    -- upvalues: Entry (copy)
    return Entry.TextBox.Text:gsub("\t", "");
end;

function u2.SetIsValidInput(p23, p24, p25) -- Line: 136
    -- upvalues: Entry (copy)
    Entry.TextBox.TextColor3 = p24 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73);
    p23.Valid = p24;
    p23._errorText = p25;
end;

function u2.HideInvalidState(p26) -- Line: 142
    -- upvalues: Entry (copy)
    Entry.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255);
end;

function u2.LoseFocus(p27, p28) -- Line: 147
    -- upvalues: Entry (copy), Frame (copy), GuiService (copy)
    local Text = Entry.TextBox.Text;
    p27:ClearHistoryState();

    if Frame.Visible and not GuiService.MenuIsOpen then
        Entry.TextBox:CaptureFocus();
    elseif GuiService.MenuIsOpen and Frame.Visible then
        p27:Hide();
    end;

    if not (p28 and p27.Valid) then
        if p28 then
            p27:AddLine(p27._errorText, Color3.fromRGB(255, 153, 153));
        end;

        return;
    end;

    task.wait();
    p27:SetEntryText("");
    p27.ProcessEntry(Text);
end;

function u2.TraverseHistory(p29, p30) -- Line: 168
    local v31 = p29.Cmdr.Dispatcher:GetHistory();

    if p29.HistoryState == nil then
        p29.HistoryState = {
            Position = #v31 + 1,
            InitialText = p29:GetEntryText()
        };
    end;

    p29.HistoryState.Position = math.clamp(p29.HistoryState.Position + p30, 1, #v31 + 1);
    p29:SetEntryText(p29.HistoryState.Position == #v31 + 1 and p29.HistoryState.InitialText or v31[p29.HistoryState.Position]);
end;

function u2.ClearHistoryState(p32) -- Line: 186
    p32.HistoryState = nil;
end;

function u2.SelectVertical(p33, p34) -- Line: 190
    if p33.AutoComplete:IsVisible() and not p33.HistoryState then
        p33.AutoComplete:Select(p34);

        return;
    end;

    p33:TraverseHistory(p34);
end;

local u35 = 0;
local u36 = 0;
local u37 = nil;
local u38 = nil;

function u2.BeginInput(u39, u40, p41) -- Line: 204
    -- upvalues: GuiService (copy), u35 (ref), u36 (ref), u1 (copy), Frame (copy), u38 (ref), u37 (ref), UserInputService (copy)
    if GuiService.MenuIsOpen then
        u39:Hide();
    end;

    if p41 and u39:IsVisible() == false then
        return;
    end;

    if not u39.Cmdr.ActivationKeys[u40.KeyCode] then
        if u39.Cmdr.Enabled == false or not u39:IsVisible() then
            if u39:IsVisible() then
                u39:Hide();
            end;

            return;
        end;

        if u39.Cmdr.HideOnLostFocus and table.find(u1, u40.UserInputType) then
            local Position = u40.Position;
            local AbsolutePosition = Frame.AbsolutePosition;
            local AbsoluteSize = Frame.AbsoluteSize;

            if Position.X < AbsolutePosition.X or (Position.X > AbsolutePosition.X + AbsoluteSize.X or (Position.Y < AbsolutePosition.Y or Position.Y > AbsolutePosition.Y + AbsoluteSize.Y)) then
                u39:Hide();

                return;
            end;
        else
            if u40.KeyCode == Enum.KeyCode.Down then
                u39:SelectVertical(1);

                if u38 then
                    task.cancel(u38);
                end;

                u37 = u40.KeyCode;
                u38 = task.delay(0.3, function() -- Line: 259
                    -- upvalues: UserInputService (ref), u40 (copy), u39 (copy)
                    if UserInputService:IsKeyDown(u40.KeyCode) then
                        local v42 = 0;

                        repeat
                            u39:SelectVertical(1);
                            v42 = v42 + 1;
                            task.wait((math.clamp(0.3 - v42 / 18.75, 0.05, 0.5)));
                        until not UserInputService:IsKeyDown(u40.KeyCode);
                    end;
                end);

                return;
            end;

            if u40.KeyCode == Enum.KeyCode.Up then
                u39:SelectVertical(-1);

                if u38 then
                    task.cancel(u38);
                end;

                u37 = u40.KeyCode;
                u38 = task.delay(0.3, function() -- Line: 276
                    -- upvalues: UserInputService (ref), u40 (copy), u39 (copy)
                    if UserInputService:IsKeyDown(u40.KeyCode) then
                        local v43 = 0;

                        repeat
                            u39:SelectVertical(-1);
                            v43 = v43 + 1;
                            task.wait((math.clamp(0.3 - v43 / 18.75, 0.05, 0.5)));
                        until not UserInputService:IsKeyDown(u40.KeyCode);
                    end;
                end);

                return;
            end;

            if u40.KeyCode == Enum.KeyCode.Return then
                task.wait();
                u39:SetEntryText(u39:GetEntryText():gsub("\n", ""):gsub("\r", ""));

                return;
            end;

            if u40.KeyCode == Enum.KeyCode.Tab then
                local v44 = u39.AutoComplete:GetSelectedItem();
                local v45 = u39:GetEntryText();

                if not v44 or v45:sub(#v45, #v45):match("%s") and u39.AutoComplete.LastItem then
                    task.wait();
                    u39:SetEntryText(u39:GetEntryText());

                    return;
                end;

                local v46 = v44[2];
                local Command = u39.AutoComplete.Command;
                local v47, v48;

                if Command then
                    local Arg = u39.AutoComplete.Arg;
                    v47 = Command.Alias;

                    if u39.AutoComplete.NumArgs == #Command.ArgumentDefinitions then
                        v48 = false;
                    else
                        v48 = u39.AutoComplete.IsPartial == false;
                    end;

                    local Arguments = Command.Arguments;

                    for i = 1, #Arguments do
                        local v49 = Arguments[i];
                        local RawSegments = v49.RawSegments;

                        if v49 == Arg then
                            RawSegments[#RawSegments] = v46;
                        end;

                        local v50 = v49.Prefix .. table.concat(RawSegments, ",");

                        if v50:find(" ") or v50 == "" then
                            v50 = ("%q"):format(v50);
                        end;

                        v47 = ("%s %s"):format(v47, v50);

                        if v49 == Arg then
                            break;
                        end;
                    end;
                else
                    v47 = v46;
                    v48 = true;
                end;

                task.wait();
                u39:SetEntryText(v47 .. (v48 and " " or ""));

                return;
            end;

            u39:ClearHistoryState();
        end;

        return;
    end;

    if not u39.Cmdr.MashToEnable or u39.Cmdr.Enabled then
        if u39.Cmdr.Enabled then
            u39:SetVisible(not u39:IsVisible());
            task.wait();
            u39:SetEntryText("");

            if GuiService.MenuIsOpen then
                u39:Hide();
            end;
        end;

        return;
    end;

    if tick() - u35 < 1 then
        if u36 >= 5 then
            return u39.Cmdr:SetEnabled(true);
        end;

        u36 = u36 + 1;
    else
        u36 = 1;
    end;

    u35 = tick();
end;

function u2.EndInput(p51, p52, p53) -- Line: 344
    -- upvalues: GuiService (copy), u37 (ref), u38 (ref)
    if GuiService.MenuIsOpen then
        p51:Hide();
    end;

    if p53 and p51:IsVisible() == false then
        return;
    end;

    if p52.KeyCode == u37 and u38 then
        task.cancel(u38);
        u38 = nil;
    end;
end;

Entry.TextBox.FocusLost:Connect(function(p54) -- Line: 359
    -- upvalues: u2 (copy)
    return u2:LoseFocus(p54);
end);
UserInputService.InputBegan:Connect(function(p55, p56) -- Line: 363
    -- upvalues: u2 (copy)
    return u2:BeginInput(p55, p56);
end);
Entry.TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 367
    -- upvalues: Frame (copy), Entry (copy), u2 (copy)
    Frame.CanvasPosition = Vector2.new(0, Frame.AbsoluteCanvasSize.Y);

    if Entry.TextBox.Text:match("\t") then
        Entry.TextBox.Text = Entry.TextBox.Text:gsub("\t", "");

        return;
    end;

    if u2.OnTextChanged then
        return u2.OnTextChanged(Entry.TextBox.Text);
    end;
end);
Frame.ChildAdded:Connect(function() -- Line: 379
    -- upvalues: u2 (copy)
    task.defer(u2.UpdateWindowHeight);
end);

return u2;