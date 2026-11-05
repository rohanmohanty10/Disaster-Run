  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local Dialogue = Parent.Dialogue;
    local Response = Parent.Response;
    local u2 = require(u1.Knit.Util.Trove).new();
    local TweenService = game:GetService("TweenService");

    local function SetActive() -- Line: 9
        -- upvalues: u1 (copy)
        u1._PSDIALOGUEVISIBLE = u1.Player.Data.Ability.Value == 7723343;
    end;

    local function CharacterAdded(p3) -- Line: 14
        -- upvalues: u2 (copy), u1 (copy)
        u2:Clean();
        u1._PSDIALOGUEVISIBLE = u1.Player.Data.Ability.Value == 7723343;
    end;

    if u1.Character then
        local _ = u1.Character;
        u2:Clean();
        u1._PSDIALOGUEVISIBLE = u1.Player.Data.Ability.Value == 7723343;
    end;

    u1.Player.CharacterAdded:Connect(CharacterAdded);
    u1._PSDIALOGUEVISIBLE = u1.Player.Data.Ability.Value == 7723343;
    u1.Player.Data.Ability.Changed:Connect(SetActive);

    local function Say(p4, p5) -- Line: 31
        -- upvalues: Response (copy), Parent (copy)
        local TextLabel = Response.TextLabel;
        TextLabel.Text = "";

        for i, v in pairs(p4) do
            TextLabel.Text = TextLabel.Text .. v;
            Parent.beep:Play();
            task.wait(p5[i] or nil);
        end;
    end;

    local function ShowPSDialogueGUI() -- Line: 41
        -- upvalues: Dialogue (copy), TweenService (copy), Parent (copy), Response (copy)
        Dialogue.UIGridLayout.CellSize = UDim2.new(0, 0, 0.25, 0);
        TweenService:Create(Dialogue.UIGridLayout, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            CellSize = UDim2.new(0.5, 0, 0.25, 0)
        }):Play();
        Dialogue.Position = UDim2.new(-1, 0, 0.5, 0);
        TweenService:Create(Dialogue, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.3, 0, 0.5, 0)
        }):Play();
        Parent.Portrait.Position = UDim2.new(0.129, 0, -2, 0);
        TweenService:Create(Parent.Portrait, TweenInfo.new(0.3, Enum.EasingStyle.Bounce), {
            Position = UDim2.new(0.129, 0, -0.835, 0)
        }):Play();
        Response.Position = UDim2.new(2, 0, -0.835, 0);
        TweenService:Create(Response, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0.641, 0, -0.835, 0)
        }):Play();
        Parent.Close.Position = UDim2.new(-1, 0, 1.2, 0);
        TweenService:Create(Parent.Close, TweenInfo.new(0.4), {
            Position = UDim2.new(0, 0, 1.2, 0)
        }):Play();
    end;

    local function HidePSDialogueGUI() -- Line: 58
        -- upvalues: TweenService (copy), Dialogue (copy), Parent (copy), Response (copy)
        TweenService:Create(Dialogue.UIGridLayout, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            CellSize = UDim2.new(0, 0, 0.25, 0)
        }):Play();
        TweenService:Create(Parent.Portrait, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 0, 3, 0)
        }):Play();
        TweenService:Create(Response, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0.641, 0, -0.835, 0)
        }):Play();
        Parent.Close.Position = UDim2.new(-1, 0, 1.2, 0);
        TweenService:Create(Parent.Close, TweenInfo.new(0.4), {
            Position = UDim2.new(0, 0, 1.2, 0)
        }):Play();
    end;

    function u1.PSActivateDialogueGUI(p6, p7) -- Line: 69
        -- upvalues: ShowPSDialogueGUI (copy)
        local v8 = false;

        for _, v in pairs({ "p//s", "ps", "planetshaper", "planet//shaper", "niko", "rachel", "shaper", "pshaper" }) do
            if string.match(string.lower(p7:gsub(" ", "")), v) then
                v8 = true;
                break;
            end;
        end;

        if not v8 then
            return;
        end;

        ShowPSDialogueGUI();
    end;

    Parent.Close.MouseButton1Click:Connect(function() -- Line: 94
        -- upvalues: HidePSDialogueGUI (copy)
        HidePSDialogueGUI();
    end);

    local function AddResponseOption() -- Line: 100
    end;

    local function ClearResponses() -- Line: 104
    end;

    local function MakeStatement() -- Line: 108
    end;
end;