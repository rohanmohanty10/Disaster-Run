  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Popup = require(ReplicatedStorage.Shared.Popup);
local Button = require(ReplicatedStorage.Modules.Button);
local UpdateGuisScale = require(ReplicatedStorage.Modules.UpdateGuisScale);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local u1 = nil;
local u2 = nil;
local v3 = Knit.CreateController({
    Name = "Codes"
});

function v3.Redeem(u4) -- Line: 21
    -- upvalues: u1 (ref), Popup (copy), LocalPlayer (copy)
    if u4.MainFrame.TextBox.TextEditable then
        local Text = u4.MainFrame.TextBox.Text;

        if Text ~= "" then
            u4.MainFrame.TextBox.Text = "[...]";
            u4.MainFrame.TextBox.TextEditable = false;
            task.delay(1, function() -- Line: 27
                -- upvalues: u1 (ref), Text (copy), u4 (copy), Popup (ref), LocalPlayer (ref)
                local v5, v6 = u1:Redeem(Text);
                u4.MainFrame.TextBox.Text = v6;

                if not v5 then
                    Popup.Popup(LocalPlayer, v6);
                end;

                task.delay(2, function() -- Line: 33
                    -- upvalues: u4 (ref)
                    u4.MainFrame.TextBox.Text = "";
                    u4.MainFrame.TextBox.TextEditable = true;
                end);
            end);
        end;
    end;
end;

function v3.GuiStart(u7) -- Line: 42
    -- upvalues: Button (copy)
    Button.CreateDefaultButton(u7.MainFrame.Redeem).OnEnded:Connect(function() -- Line: 44
        -- upvalues: u7 (copy)
        u7:Redeem();
    end);
    u7.MainFrame.TextBox.FocusLost:Connect(function(p8: boolean) -- Line: 48
        -- upvalues: u7 (copy)
        if p8 then
            u7:Redeem();
        end;
    end);
end;

function v3.KnitStart(u9) -- Line: 55
    -- upvalues: Knit (copy), UpdateGuisScale (copy)
    u9.MainFrame.DisplayedCode.Text = workspace:GetAttribute("displayedMenuCode") or "[LOADING]";
    workspace:GetAttributeChangedSignal("displayedMenuCode"):Connect(function() -- Line: 56, Name: updateDisplayed
        -- upvalues: u9 (copy)
        u9.MainFrame.DisplayedCode.Text = workspace:GetAttribute("displayedMenuCode") or "[LOADING]";
    end);
    Knit.OnStart():andThenCall(UpdateGuisScale, u9.Screen.UIScale):andThenCall(u9.GuiStart, u9);
end;

function v3.KnitInit(p10) -- Line: 67
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PlayerGui (copy)
    u1 = Knit.GetService("CodesService");
    u2 = Knit.GetController("DataController");
    p10.Screen = PlayerGui:WaitForChild("Codes");
    p10.MainFrame = p10.Screen:WaitForChild("BG");
end;

return v3;