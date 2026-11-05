  

 

local LocalPlayer = game.Players.LocalPlayer;
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local StarterGui = game:GetService("StarterGui");
local u1 = {
    Transparency = {
        In = {
            TextLabel = {
                TextStrokeTransparency = 0.75,
                TextTransparency = 0
            },
            Frame = {
                BackgroundTransparency = 0.4
            },
            UIStroke = {
                Transparency = 0
            }
        },
        Out = {
            TextLabel = {
                TextStrokeTransparency = 0.89,
                TextTransparency = 0.89
            },
            Frame = {
                BackgroundTransparency = 0.885
            },
            UIStroke = {
                Transparency = 1
            }
        }
    }
};

return function() -- Line: 35
    -- upvalues: LocalPlayer (copy), TweenService (copy), u1 (copy), CollectionService (copy), StarterGui (copy)
    if not LocalPlayer.PlayerGui.UI.CombatTagFrame.Visible then
        local CombatTagFrame = LocalPlayer.PlayerGui.UI.CombatTagFrame;
        CombatTagFrame.Visible = true;
        local u2 = "Out";
        local u3 = { CombatTagFrame.Description, CombatTagFrame.Label };
        task.spawn(function() -- Line: 52
            -- upvalues: TweenService (ref), CombatTagFrame (copy), u1 (ref), u2 (ref), u3 (copy), CollectionService (ref), LocalPlayer (ref)
            while true do
                task.wait(1);
                TweenService:Create(CombatTagFrame, TweenInfo.new(0.75), u1["Combat Tag"].Transparency[u2].Frame):Play();
                TweenService:Create(CombatTagFrame.UIStroke, TweenInfo.new(0.75), u1["Combat Tag"].Transparency[u2].UIStroke):Play();

                for i = 1, #u3 do
                    TweenService:Create(u3[i], TweenInfo.new(0.75), u1["Combat Tag"].Transparency[u2][u3[i].ClassName]):Play();
                end;

                u2 = u2 == "Out" and "In" or "Out";

                if not CollectionService:HasTag(LocalPlayer, "InCombat") then
                    return;
                end;
            end;
        end);

        repeat
            task.wait(0.1);
            local UIGradient = CombatTagFrame.UIStroke.UIGradient;
            UIGradient.Rotation = UIGradient.Rotation + 2;

            if CombatTagFrame.UIStroke.UIGradient.Rotation >= 360 then
                CombatTagFrame.UIStroke.UIGradient.Rotation = 0;
            end;

            pcall(function() -- Line: 67
                -- upvalues: StarterGui (ref)
                if game.PlaceId ~= 9762298537 then
                    StarterGui:SetCore("ResetButtonCallback", false);
                end;
            end);
        until not CollectionService:HasTag(LocalPlayer, "InCombat");

        CombatTagFrame.Visible = false;
        StarterGui:SetCore("ResetButtonCallback", true);
    end;
end;