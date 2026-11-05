  

 

local ReplicatedModules = game.ReplicatedStorage:WaitForChild("ReplicatedModules");
local Stands = require(ReplicatedModules:WaitForChild("Stands"));

repeat
    wait();
until script.Parent;

local u1 = 0;

local function deepCopy(p2) -- Line: 10
    -- upvalues: deepCopy (copy)
    local v3 = {};

    for i, v in pairs(p2) do
        if type(v) == "table" then
            local v = deepCopy(v) or v;
        end;

        v3[i] = v;
    end;

    return v3;
end;

local function createButton(p4) -- Line: 18
    -- upvalues: u1 (ref)
    local TextButton = Instance.new("TextButton", script.Parent.Standos);
    TextButton.Size = UDim2.new(1, 0, 0, 30);
    TextButton.Position = UDim2.new(0, 0, 0, u1);
    TextButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60);
    TextButton.BorderColor3 = script.Parent.Standos.BackgroundColor3;
    TextButton.BorderMode = Enum.BorderMode.Inset;
    TextButton.BorderSizePixel = 2;
    TextButton.Text = p4;
    TextButton.TextScaled = true;
    TextButton.TextColor3 = Color3.new(1, 1, 1);
    TextButton.MouseButton1Click:Connect(function() -- Line: 33
        -- upvalues: TextButton (copy)
        script.Parent.SelectedStand.Value = TextButton.Text;

        for _, child in pairs(script.Parent.Standos:GetChildren()) do
            child.BackgroundColor3 = Color3.fromRGB(60, 60, 60);
        end;

        TextButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
    end);
    u1 = u1 + 30;
end;

local v5 = {};
local u6 = false;
local u7 = false;

for _, v in pairs(Stands) do
    table.insert(v5, v);
end;

table.sort(v5, function(p8, p9) -- Line: 51
    return string.lower(p8) < string.lower(p9);
end);

for _, v in pairs(v5) do
    createButton(v);
end;

script.Parent.Parent.Enabled = game.ReplicatedStorage.Remotes.OutputFunc:InvokeServer("IsAdmin");
script.Parent:WaitForChild("ToggleMenu").MouseButton1Click:Connect(function() -- Line: 63
    -- upvalues: u6 (ref)
    ({
        [false] = function() -- Line: 65
            -- upvalues: u6 (ref)
            u6 = true;
            script.Parent:TweenPosition(UDim2.new(1, 0, script.Parent.Position.Y.Scale, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5);
        end,

        [true] = function() -- Line: 69
            -- upvalues: u6 (ref)
            u6 = false;
            script.Parent:TweenPosition(UDim2.new(1 + script.Parent.Size.X.Scale, 0, script.Parent.Position.Y.Scale, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5);
        end
    })[u6]();
end);
script.Parent.Send.MouseButton1Click:Connect(function() -- Line: 77
    -- upvalues: u7 (ref)
    if u7 == true then
        return;
    end;

    u7 = true;
    local v10 = {
        [script.Parent.SelectedStand.Value] = {
            Description = script.Parent.TextBox.Text
        }
    };
    script.Parent.TextBox.PlaceholderText = "Please wait...";
    script.Parent.TextBox.TextEditable = false;
    script.Parent.Send.Text = "Sending...";
    local v11 = game.ReplicatedStorage.Remotes.OutputFunc:InvokeServer("ReportBug", v10, script.Parent.SelectedStand.Value);

    if v11 then
        script.Parent.Send.Text = v11;
    else
        script.Parent.Send.Text = "Success!";
    end;

    script.Parent.TextBox.Text = "";
    wait(3);
    script.Parent.TextBox.PlaceholderText = "Type here...";
    script.Parent.TextBox.TextEditable = true;
    script.Parent.Send.Text = "Submit";
    u7 = false;
end);