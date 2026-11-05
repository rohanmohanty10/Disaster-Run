  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Parent = script.Parent;
local Assets = Parent:WaitForChild("Assets");
local Page = Parent:WaitForChild("Paper"):WaitForChild("Page");

function updatePage()
    -- upvalues: Page (copy)
    Page.CanvasSize = UDim2.new(0, 0, 0, #Page:GetChildren() * 50);
end;

function ugoFill(p1)
    -- upvalues: Players (copy)
    local v2 = {};

    for _, child in pairs(Players:GetChildren()) do
        if child.Name:sub(1, #p1):upper() == p1:upper() and #p1 >= 1 then
            table.insert(v2, child.Name:upper());
        end;
    end;

    if #v2 >= 1 then
        return v2[1];
    end;

    return p1;
end;

function confirmVictim(p3)
    -- upvalues: Players (copy), ReplicatedStorage (copy)
    for _, child in pairs(Players:GetChildren()) do
        if child.Name:upper() == p3.Text then
            p3.TextEditable = false;
            p3.Selectable = false;
            p3.ClearTextOnFocus = false;
            insertVictim();
            ReplicatedStorage.SystemRemotes.DeathNote:FireServer(child);

            return true;
        end;
    end;
end;

function insertVictim()
    -- upvalues: Assets (copy), Page (copy)
    local u4 = Assets.Victim:Clone();
    u4.Position = UDim2.new(0.15, 0, 0, #Page:GetChildren() * 50);
    u4.Visible = true;
    u4.Parent = Page;
    updatePage();
    local u5 = u4:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 48, Name: ugofillEvent
        -- upvalues: u4 (copy)
        u4.Text = u4.Text:upper();
        u4.Autofill.Text = ugoFill(u4.Text);
    end);
    local u6 = nil;
    u6 = u4.FocusLost:Connect(function(p7) -- Line: 55, Name: confirmEvent
        -- upvalues: u4 (copy), u5 (ref), u6 (ref)
        if p7 then
            u4.Text = ugoFill(u4.Text);

            if confirmVictim(u4) then
                u5:Disconnect();
                u6:Disconnect();
            end;
        end;
    end);
end;

insertVictim();